import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart' as fmobx;
import 'package:provider/provider.dart' as pro;
import 'package:rick_and_morty_app/models/character.dart' as mcharacter;
import 'package:rick_and_morty_app/stores/character_store.dart' as cstore;
import '../widgets/character_card.dart' as card;
import '../utils/snackbar_helper.dart' as snack;

class AllCharactersMobxScreen extends StatelessWidget {
  const AllCharactersMobxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = pro.Provider.of<cstore.CharacterStore>(context);

    void handleFavorite(mcharacter.Character character) {
      store.isFavorite(character.id);
      store.toggleFavorite(character.id);
      final nowFavorite = store.isFavorite(character.id);

      snack.showFavoriteSnackBar(
        context,
        character.name,
        nowFavorite,
        stateManager: 'MobX state management',
      );
    }

    return fmobx.Observer(
      builder:
          (_) => NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (!store.isLoading &&
                  store.hasMore &&
                  scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 200) {
                store.fetchCharacters();
              }
              return false;
            },
            child: RefreshIndicator(
              onRefresh: () async => store.fetchCharacters(),
              child: ListView.builder(
                itemCount: store.characters.length + (store.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < store.characters.length) {
                    final character = store.characters[index];
                    return fmobx.Observer(
                      builder:
                          (_) => card.CharacterCard(
                            character: character,
                            isFavorite: store.isFavorite(character.id),
                            onFavorite: () => handleFavorite(character),
                          ),
                    );
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
    );
  }
}
