import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as pro;
import 'package:rick_and_morty_app/providers/character_provider.dart'
    as cprovider;
import 'package:rick_and_morty_app/stores/character_store.dart' as cstore;
import 'mobx/all_characters_mobx.dart' as acm;
import 'mobx/favorites_mobx.dart' as favm;
import 'getx/all_characters_getx.dart' as acg;
import 'getx/favorites_getx.dart' as favget;
import 'providers/all_characters_provider.dart' as acp;
import 'providers/favorites_provider.dart' as fp;
import 'main_scaffold.dart' as mains;
import 'package:rick_and_morty_app/shared/state_manager_type.dart' as smt;

class StateSwitchScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final smt.StateManagerType stateType;
  final ValueChanged<ThemeMode> onThemeChanged;
  final ValueChanged<smt.StateManagerType> onStateTypeChanged;

  const StateSwitchScreen({
    super.key,
    required this.themeMode,
    required this.stateType,
    required this.onThemeChanged,
    required this.onStateTypeChanged,
  });

  @override
  State<StateSwitchScreen> createState() => _StateSwitchScreenState();
}

class _StateSwitchScreenState extends State<StateSwitchScreen> {
  int _tabIndex = 0;

  @override
  void didUpdateWidget(covariant StateSwitchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stateType != oldWidget.stateType) {
      setState(() => _tabIndex = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.stateType) {
      case smt.StateManagerType.provider:
        return pro.MultiProvider(
          providers: [
            pro.ChangeNotifierProvider(
              create: (_) => cprovider.CharacterProvider(),
            ),
          ],
          child: mains.MainScaffold(
            key: const ValueKey('provider'),
            themeMode: widget.themeMode,
            stateType: widget.stateType,
            onThemeChanged: widget.onThemeChanged,
            onStateTypeChanged: widget.onStateTypeChanged,
            tabIndex: _tabIndex,
            onTabChanged: (i) => setState(() => _tabIndex = i),
            screens: const [
              acp.AllCharactersProviderScreen(),
              fp.FavoritesProviderScreen(),
            ],
          ),
        );
      case smt.StateManagerType.mobx:
        return pro.Provider<cstore.CharacterStore>(
          create: (_) => cstore.CharacterStore(),
          child: mains.MainScaffold(
            key: const ValueKey('mobx'),
            themeMode: widget.themeMode,
            stateType: widget.stateType,
            onThemeChanged: widget.onThemeChanged,
            onStateTypeChanged: widget.onStateTypeChanged,
            tabIndex: _tabIndex,
            onTabChanged: (i) => setState(() => _tabIndex = i),
            screens: [
              const acm.AllCharactersMobxScreen(),
              favm.FavoritesMobxScreen(),
            ],
          ),
        );
      case smt.StateManagerType.getx:
        return mains.MainScaffold(
          key: const ValueKey('getx'),
          themeMode: widget.themeMode,
          stateType: widget.stateType,
          onThemeChanged: widget.onThemeChanged,
          onStateTypeChanged: widget.onStateTypeChanged,
          tabIndex: _tabIndex,
          onTabChanged: (i) => setState(() => _tabIndex = i),
          screens: [
            const acg.AllCharactersGetxScreen(),
            favget.FavoritesGetxScreen(),
          ],
        );
    }
  }
}
