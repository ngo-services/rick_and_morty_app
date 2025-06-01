import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as pro;
import 'package:rick_and_morty_app/models/character.dart' as mc;
import 'character_provider.dart' as cprovider;
import '../widgets/character_card.dart' as card;
import '../utils/snackbar_helper.dart' as snack;

class AllCharactersProviderScreen extends StatelessWidget {
  const AllCharactersProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = pro.Provider.of<cprovider.CharacterProvider>(context);

    void handleFavorite(mc.Character character) {
      provider.isFavorite(character.id);
      provider.toggleFavorite(character.id);
      final nowFavorite = provider.isFavorite(character.id);
     snack. showFavoriteSnackBar(
        context,
        character.name,
        nowFavorite,
        stateManager: 'Provider state management',
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!provider.isLoading &&
            provider.hasMore &&
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
          provider.fetchCharacters();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async => provider.fetchCharacters(),
        child: ListView.builder(
          itemCount: provider.characters.length + (provider.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < provider.characters.length) {
              final character = provider.characters[index];
              return card.CharacterCard(
                character: character,
                isFavorite: provider.isFavorite(character.id),
                onFavorite: () => handleFavorite(character),
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
    );
  }
}
