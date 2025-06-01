import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../models/character.dart';

part 'character_store.g.dart';

enum SortType { name, status }

class CharacterStore = _CharacterStore with _$CharacterStore;

abstract class _CharacterStore with Store {
  final Box _characterBox = Hive.box('characters');
  final Box _favoritesBox = Hive.box('favorites');

  @observable
  ObservableList<Character> characters = ObservableList<Character>();

  @observable
  ObservableList<int> favorites = ObservableList<int>();

  @observable
  bool isLoading = false;

  @observable
  int page = 1;

  @observable
  bool hasMore = true;

  @observable
  SortType sortType = SortType.name;

  _CharacterStore() {
    loadCache();
    loadFavorites();
    fetchCharacters();
  }

  @computed
  List<Character> get favoriteCharacters {
    var list = characters.where((c) => favorites.contains(c.id)).toList();
    switch (sortType) {
      case SortType.status:
        list.sort((a, b) => a.status.compareTo(b.status));
        break;
      case SortType.name:
        list.sort((a, b) => a.name.compareTo(b.name));
    }
    return list;
  }

  @action
  Future<void> fetchCharacters() async {
    if (isLoading || !hasMore) return;
    isLoading = true;

    try {
      final response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];
        final newCharacters =
            results
                .map((json) => Character.fromJson(json))
                .where((char) => !characters.any((c) => c.id == char.id))
                .toList();

        characters.addAll(newCharacters.cast<Character>());
        page++;
        if (newCharacters.isEmpty || page > data['info']['pages'])
          hasMore = false;
        await _characterBox.put('characters', characters.toList());
      }
    } catch (_) {
      hasMore = false;
    }
    isLoading = false;
  }

  @action
  void toggleFavorite(int id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    saveFavorites();
  }

  @action
  void setSortType(SortType type) {
    sortType = type;
  }

  @action
  void loadFavorites() {
    favorites = ObservableList<int>.of(
      (_favoritesBox.get('favorites', defaultValue: <int>[]) as List)
          .cast<int>(),
    );
  }

  @action
  void saveFavorites() {
    _favoritesBox.put('favorites', favorites.toList());
  }

  @action
  void loadCache() {
    final cached = _characterBox.get('characters');
    if (cached != null) {
      characters = ObservableList<Character>.of(
        (cached as List).cast<Character>(),
      );
    }
  }

  bool isFavorite(int id) => favorites.contains(id);
}
