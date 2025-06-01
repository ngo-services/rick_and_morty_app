import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/shared/state_manager_type.dart' as smt;

class StateManagerDropdown extends StatelessWidget {
  final smt.StateManagerType value;
  final ValueChanged<smt.StateManagerType> onChanged;

  const StateManagerDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<smt.StateManagerType>(
      value: value,
      underline: const SizedBox(),
      onChanged: (type) {
        if (type != null) onChanged(type);
      },
      items:
          smt.StateManagerType.values
              .map(
                (m) => DropdownMenuItem(
                  value: m,
                  child: Text(_getStateManagerName(m)),
                ),
              )
              .toList(),
      style: Theme.of(context).textTheme.bodyMedium,
      dropdownColor: Theme.of(context).appBarTheme.backgroundColor,
      icon: const Icon(Icons.arrow_drop_down),
    );
  }

  String _getStateManagerName(smt.StateManagerType type) {
    switch (type) {
      case smt.StateManagerType.provider:
        return 'Provider';
      case smt.StateManagerType.mobx:
        return 'MobX';
      case smt.StateManagerType.getx:
        return 'GetX';
    }
  }
}
