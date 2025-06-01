import 'package:flutter/material.dart';

void showFavoriteSnackBar(
  BuildContext context,
  String characterName,
  bool isFavorite, {
  String stateManager = "",
}) {
  final action = isFavorite ? 'Добавлен в избранное' : 'Удалён из избранного';
  final managerText = stateManager.isNotEmpty ? ' ($stateManager)' : '';
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$characterName: $action$managerText'),
      duration: const Duration(milliseconds: 1200),
    ),
  );
}
