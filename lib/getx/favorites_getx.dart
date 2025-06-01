import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import '../getx/character_controller.dart' as controller;
import '../widgets/character_card.dart' as card;

class FavoritesGetxScreen extends StatelessWidget {
  const FavoritesGetxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = g.Get.find<controller.CharacterController>();
    return g.Obx(() {
      final favorites = ctrl.favoriteCharacters;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton(
                value: ctrl.sortType.value,
                items: const [
                  DropdownMenuItem(
                    value: controller.SortType.name,
                    child: Text('By Name'),
                  ),
                  DropdownMenuItem(
                    value: controller.SortType.status,
                    child: Text('By Status'),
                  ),
                ],
                onChanged: (controller.SortType? value) {
                  if (value != null) ctrl.setSortType(value);
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
          Expanded(
            child:
                favorites.isEmpty
                    ? const Center(child: Text('No favorites yet'))
                    : ListView.builder(
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        return card.CharacterCard(
                          character: favorites[index],
                          isFavorite: true,
                          onFavorite:
                              () => ctrl.toggleFavorite(favorites[index].id),
                        );
                      },
                    ),
          ),
        ],
      );
    });
  }
}
