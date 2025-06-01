import 'package:flutter/material.dart';
import 'state_manager_dropdown.dart' as smd;
import 'package:rick_and_morty_app/shared/state_manager_type.dart' as smt;

class MainScaffold extends StatelessWidget {
  final ThemeMode themeMode;
  final smt.StateManagerType stateType;
  final ValueChanged<ThemeMode> onThemeChanged;
  final ValueChanged<smt.StateManagerType> onStateTypeChanged;
  final int tabIndex;
  final ValueChanged<int> onTabChanged;
  final List<Widget> screens;

  const MainScaffold({
    super.key,
    required this.themeMode,
    required this.stateType,
    required this.onThemeChanged,
    required this.onStateTypeChanged,
    required this.tabIndex,
    required this.onTabChanged,
    required this.screens,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rick & Morty (${stateType.name.toUpperCase()})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          smd.StateManagerDropdown(
            value: stateType,
            onChanged: onStateTypeChanged,
          ),
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.wb_sunny : Icons.nightlight,
            ),
            tooltip: themeMode == ThemeMode.dark ? 'Light Theme' : 'Dark Theme',
            onPressed:
                () => onThemeChanged(
                  themeMode == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark,
                ),
          ),
        ],
      ),
      body: IndexedStack(index: tabIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: onTabChanged,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Characters'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
