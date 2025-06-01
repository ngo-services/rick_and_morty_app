import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
  brightness: Brightness.light,
  useMaterial3: true,
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
  brightness: Brightness.dark,
  useMaterial3: true,
);
