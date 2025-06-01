import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as pro;
import 'package:rick_and_morty_app/providers/character_provider.dart'
    as cprovider;
import '../widgets/character_card.dart' as card;

class FavoritesProviderScreen extends StatelessWidget {
  const FavoritesProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = pro.Provider.of<cprovider.CharacterProvider>(context);

    final favorites = provider.favoriteCharacters;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButton(
              value: provider.sortType,
              items: const [
                DropdownMenuItem(
                  value: cprovider.SortType.name,
                  child: Text('By Name'),
                ),
                DropdownMenuItem(
                  value: cprovider.SortType.status,
                  child: Text('By Status'),
                ),
              ],
              onChanged: (cprovider.SortType? value) {
                if (value != null) provider.setSortType(value);
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
                            () => provider.toggleFavorite(favorites[index].id),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
