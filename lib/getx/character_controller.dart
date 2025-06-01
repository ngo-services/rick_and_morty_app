import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart' as h;
import '../models/character.dart';

enum SortType { name, status }

class CharacterController extends GetxController {
  final _characterBox = h.Hive.box('characters');
  final _favoritesBox = h.Hive.box('favorites');

  var characters = <Character>[].obs;
  var favorites = <int>[].obs;
  var isLoading = false.obs;
  var page = 1.obs;
  var hasMore = true.obs;
  var sortType = SortType.name.obs;

  @override
  void onInit() {
    loadCache();
    loadFavorites();
    fetchCharacters();
    super.onInit();
  }

  List<Character> get favoriteCharacters {
    var list = characters.where((c) => favorites.contains(c.id)).toList();
    switch (sortType.value) {
      case SortType.status:
        list.sort((a, b) => a.status.compareTo(b.status));
        break;
      case SortType.name:
        list.sort((a, b) => a.name.compareTo(b.name));
    }
    return list;
  }

  Future<void> fetchCharacters() async {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse(
          'https://rickandmortyapi.com/api/character/?page=${page.value}',
        ),
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
        page.value++;
        if (newCharacters.isEmpty || page.value > data['info']['pages']) {
          hasMore.value = false;
        }
        await _characterBox.put('characters', characters);
      }
    } catch (_) {
      hasMore.value = false;
    }
    isLoading.value = false;
  }

  void toggleFavorite(int id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    saveFavorites();
  }

  void setSortType(SortType type) {
    sortType.value = type;
  }

  void loadFavorites() {
    favorites.value =
        (_favoritesBox.get('favorites', defaultValue: <int>[]) as List)
            .cast<int>();
  }

  void saveFavorites() {
    _favoritesBox.put('favorites', favorites);
  }

  void loadCache() {
    final cached = _characterBox.get('characters');
    if (cached != null) {
      characters.value = (cached as List).cast<Character>();
    }
  }

  bool isFavorite(int id) => favorites.contains(id);
}
