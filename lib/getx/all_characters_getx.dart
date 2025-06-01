import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:rick_and_morty_app/models/character.dart' as mcharacter;
import 'character_controller.dart' as controller;
import '../widgets/character_card.dart' as card;
import '../utils/snackbar_helper.dart' as snack;

class AllCharactersGetxScreen extends StatelessWidget {
  const AllCharactersGetxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = g.Get.find<controller.CharacterController>();

    void handleFavorite(mcharacter.Character character) {
      ctrl.isFavorite(character.id);
      ctrl.toggleFavorite(character.id);
      final nowFavorite = ctrl.isFavorite(character.id);
      snack.showFavoriteSnackBar(
        context,
        character.name,
        nowFavorite,
        stateManager: 'GetX state management',
      );
    }

    return g.Obx(
      () => NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (!ctrl.isLoading.value &&
              ctrl.hasMore.value &&
              scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
            ctrl.fetchCharacters();
          }
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () async => ctrl.fetchCharacters(),
          child: ListView.builder(
            itemCount: ctrl.characters.length + (ctrl.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < ctrl.characters.length) {
                final character = ctrl.characters[index];
                return g.Obx(
                  () => card.CharacterCard(
                    character: character,
                    isFavorite: ctrl.isFavorite(character.id),
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
