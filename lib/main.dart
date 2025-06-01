import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart' as h;
import 'models/character.dart' as mcharacter;
import 'app_root.dart' as root;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await h.Hive.initFlutter();
  h.Hive.registerAdapter(mcharacter.CharacterAdapter());
  await h.Hive.openBox('characters');
  await h.Hive.openBox('favorites');
  runApp(const root.AppRoot());
}
