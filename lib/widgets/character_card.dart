import 'package:flutter/material.dart';
import '../models/character.dart' as mcharacter;

class CharacterCard extends StatelessWidget {
  final mcharacter.Character character;
  final bool isFavorite;
  final VoidCallback onFavorite;

  const CharacterCard({
    super.key,
    required this.character,
    required this.isFavorite,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(character.image),
          radius: 30,
        ),
        title: Text(
          character.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${character.status} • ${character.species}\nLocation: ${character.location}',
        ),
        isThreeLine: true,
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder:
              (child, anim) => ScaleTransition(scale: anim, child: child),
          child: IconButton(
            key: ValueKey(isFavorite),
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.amber : null,
            ),
            onPressed: onFavorite,
          ),
        ),
      ),
    );
  }
}
