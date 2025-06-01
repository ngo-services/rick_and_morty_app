import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx/character_controller.dart' as controller;
import 'state_switch.dart';
import 'utils/theme.dart' as theme;
import 'package:rick_and_morty_app/shared/state_manager_type.dart' as smt;


class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  ThemeMode _themeMode = ThemeMode.light;
  smt.StateManagerType _mode = smt.StateManagerType.provider;

  @override
  void initState() {
    super.initState();
    Get.put(controller.CharacterController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: _themeMode,
      home: StateSwitchScreen(
        key: ValueKey(_mode),
        themeMode: _themeMode,
        stateType: _mode,
        onThemeChanged: (newMode) => setState(() => _themeMode = newMode),
        onStateTypeChanged: (type) => setState(() => _mode = type),
      ),
    );
  }
}
