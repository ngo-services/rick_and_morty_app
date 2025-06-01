import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/stores/character_store.dart';
import '../widgets/character_card.dart';

class FavoritesMobxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<CharacterStore>(context);

    return Observer(
      builder: (_) {
        final favorites = store.favoriteCharacters;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton(
                  value: store.sortType,
                  items: const [
                    DropdownMenuItem(
                      value: SortType.name,
                      child: Text('By Name'),
                    ),
                    DropdownMenuItem(
                      value: SortType.status,
                      child: Text('By Status'),
                    ),
                  ],
                  onChanged: (SortType? value) {
                    if (value != null) store.setSortType(value);
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
                          return CharacterCard(
                            character: favorites[index],
                            isFavorite: true,
                            onFavorite:
                                () => store.toggleFavorite(favorites[index].id),
                          );
                        },
                      ),
            ),
          ],
        );
      },
    );
  }
}
