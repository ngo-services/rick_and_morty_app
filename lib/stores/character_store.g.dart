// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CharacterStore on _CharacterStore, Store {
  Computed<List<Character>>? _$favoriteCharactersComputed;

  @override
  List<Character> get favoriteCharacters => (_$favoriteCharactersComputed ??=
          Computed<List<Character>>(() => super.favoriteCharacters,
              name: '_CharacterStore.favoriteCharacters'))
      .value;

  late final _$charactersAtom =
      Atom(name: '_CharacterStore.characters', context: context);

  @override
  ObservableList<Character> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(ObservableList<Character> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  late final _$favoritesAtom =
      Atom(name: '_CharacterStore.favorites', context: context);

  @override
  ObservableList<int> get favorites {
    _$favoritesAtom.reportRead();
    return super.favorites;
  }

  @override
  set favorites(ObservableList<int> value) {
    _$favoritesAtom.reportWrite(value, super.favorites, () {
      super.favorites = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_CharacterStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$pageAtom = Atom(name: '_CharacterStore.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$hasMoreAtom =
      Atom(name: '_CharacterStore.hasMore', context: context);

  @override
  bool get hasMore {
    _$hasMoreAtom.reportRead();
    return super.hasMore;
  }

  @override
  set hasMore(bool value) {
    _$hasMoreAtom.reportWrite(value, super.hasMore, () {
      super.hasMore = value;
    });
  }

  late final _$sortTypeAtom =
      Atom(name: '_CharacterStore.sortType', context: context);

  @override
  SortType get sortType {
    _$sortTypeAtom.reportRead();
    return super.sortType;
  }

  @override
  set sortType(SortType value) {
    _$sortTypeAtom.reportWrite(value, super.sortType, () {
      super.sortType = value;
    });
  }

  late final _$fetchCharactersAsyncAction =
      AsyncAction('_CharacterStore.fetchCharacters', context: context);

  @override
  Future<void> fetchCharacters() {
    return _$fetchCharactersAsyncAction.run(() => super.fetchCharacters());
  }

  late final _$_CharacterStoreActionController =
      ActionController(name: '_CharacterStore', context: context);

  @override
  void toggleFavorite(int id) {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
        name: '_CharacterStore.toggleFavorite');
    try {
      return super.toggleFavorite(id);
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortType(SortType type) {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
        name: '_CharacterStore.setSortType');
    try {
      return super.setSortType(type);
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadFavorites() {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
        name: '_CharacterStore.loadFavorites');
    try {
      return super.loadFavorites();
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveFavorites() {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
        name: '_CharacterStore.saveFavorites');
    try {
      return super.saveFavorites();
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadCache() {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
        name: '_CharacterStore.loadCache');
    try {
      return super.loadCache();
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
characters: ${characters},
favorites: ${favorites},
isLoading: ${isLoading},
page: ${page},
hasMore: ${hasMore},
sortType: ${sortType},
favoriteCharacters: ${favoriteCharacters}
    ''';
  }
}
