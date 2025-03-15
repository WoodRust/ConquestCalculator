// lib/presentation/widgets/unit_selection/faction_selection.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/combat_provider.dart';
import '../../screens/unit_selection_screen.dart';
import '../faction_grid_dialog.dart';

/// Shows the dialog for faction selection
void showFactionSelectionDialog({
  required BuildContext context,
  required WidgetRef ref,
  required bool isAttacker,
  Function(String)? onFactionSelected,
}) {
  showDialog(
    context: context,
    builder: (context) => FactionGridDialog(
      onFactionSelected: (faction) {
        // Dismiss the dialog first
        Navigator.of(context).pop();

        // Use a microtask to ensure the dialog dismissal is processed
        // before continuing with navigation
        Future.microtask(() {
          // If callback is provided, use it
          if (onFactionSelected != null) {
            onFactionSelected(faction);
          } else {
            // Otherwise update the provider directly
            final combatNotifier = ref.read(combatProvider.notifier);
            if (isAttacker) {
              combatNotifier.setAttackerFaction(faction);
            } else {
              combatNotifier.setDefenderFaction(faction);
            }
          }
        });
      },
    ),
  );
}

/// Navigate directly to unit selection with the specified faction
void navigateToUnitSelection({
  required BuildContext context,
  required WidgetRef ref,
  required String faction,
  required bool isAttacker,
  UnitFilter initialFilter = UnitFilter.all,
  Set<UnitFilter> allowedFilters = const {
    UnitFilter.all,
    UnitFilter.regimentsOnly,
    UnitFilter.charactersOnly
  },
}) {
  final combatState = ref.read(combatProvider);
  final combatNotifier = ref.read(combatProvider.notifier);

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UnitSelectionScreen(
        faction: faction,
        initialFilter: initialFilter,
        allowedFilters: allowedFilters,
        title: 'Select Unit',
        isDuelMode: combatState.isDuelMode, // Pass the duel mode state
        onUnitSelected: (regiment) {
          // Ensure selected unit matches the required type
          if (combatState.isDuelMode && !regiment.isCharacter()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('In duel mode, only character units can be selected'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          } else if (!combatState.isDuelMode && regiment.isCharacter()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Characters must be attached to regiments in normal mode'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          if (isAttacker) {
            combatNotifier.updateAttacker(regiment);
          } else {
            combatNotifier.updateDefender(regiment);
          }
          Navigator.pop(context);
        },
      ),
    ),
  );
}
