import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart' as h;
import '../models/character.dart' as mcharacter;

enum SortType { name, status }

class CharacterProvider extends ChangeNotifier {
  final _characterBox = h.Hive.box('characters');
  final _favoritesBox = h.Hive.box('favorites');

  List<mcharacter.Character> _characters = [];
  List<int> _favorites = [];
  bool _isLoading = false;
  int _page = 1;
  bool _hasMore = true;
  SortType _sortType = SortType.name;

  CharacterProvider() {
    loadCache();
    loadFavorites();
    fetchCharacters();
  }

  List<mcharacter.Character> get characters => _characters;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  SortType get sortType => _sortType;
  List<int> get favorites => _favorites;

  List<mcharacter.Character> get favoriteCharacters {
    var list = _characters.where((c) => _favorites.contains(c.id)).toList();
    switch (_sortType) {
      case SortType.status:
        list.sort((a, b) => a.status.compareTo(b.status));
        break;
      case SortType.name:
        list.sort((a, b) => a.name.compareTo(b.name));
    }
    return list;
  }

  bool isFavorite(int id) => _favorites.contains(id);

  Future<void> fetchCharacters() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?page=$_page'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];
        final newCharacters =
            results
                .map((json) => mcharacter.Character.fromJson(json))
                .where((char) => !_characters.any((c) => c.id == char.id))
                .toList();

        _characters.addAll(newCharacters.cast<mcharacter.Character>());
        _page++;
        if (newCharacters.isEmpty || _page > data['info']['pages']) {
          _hasMore = false;
        }
        await _characterBox.put('characters', _characters);
      }
    } catch (_) {
      _hasMore = false;
    }
    _isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(int id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    saveFavorites();
    notifyListeners();
  }

  void setSortType(SortType type) {
    _sortType = type;
    notifyListeners();
  }

  void loadFavorites() {
    _favorites =
        (_favoritesBox.get('favorites', defaultValue: <int>[]) as List)
            .cast<int>();
    notifyListeners();
  }

  void saveFavorites() {
    _favoritesBox.put('favorites', _favorites);
  }

  void loadCache() {
    final cached = _characterBox.get('characters');
    if (cached != null) {
      _characters = (cached as List).cast<mcharacter.Character>();
      notifyListeners();
    }
  }
}
