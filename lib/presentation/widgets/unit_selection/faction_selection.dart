// lib/presentation/widgets/unit_selection/faction_selection.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/combat_provider.dart';
import '../../screens/unit_selection_screen.dart';
import '../../screens/unit_selection_screen.dart';

/// Displays the bottom sheet for faction selection
class FactionSelectionBottomSheet extends ConsumerWidget {
  final bool isAttacker;

  const FactionSelectionBottomSheet({super.key, required this.isAttacker});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.read(combatProvider);

    // In duel mode, only allow character selection
    final UnitFilter initialFilter = combatState.isDuelMode
        ? UnitFilter.charactersOnly
        : UnitFilter.regimentsOnly;

    final Set<UnitFilter> allowedFilters = combatState.isDuelMode
        ? {UnitFilter.charactersOnly} // Only show characters in duel mode
        : {
            UnitFilter.all,
            UnitFilter.regimentsOnly,
            UnitFilter.charactersOnly
          }; // Show all normally

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.shield),
          title: const Text('Dweghom'),
          onTap: () {
            Navigator.pop(context);
            _navigateToUnitSelection(context, ref, 'dweghom', initialFilter,
                allowedFilters, isAttacker);
          },
        ),
        ListTile(
          leading: const Icon(Icons.castle),
          title: const Text('Hundred Kingdoms'),
          onTap: () {
            Navigator.pop(context);
            _navigateToUnitSelection(context, ref, 'hundred_kingdoms',
                initialFilter, allowedFilters, isAttacker);
          },
        ),
        ListTile(
          leading: const Icon(Icons.nordic_walking),
          title: const Text('Nords'),
          onTap: () {
            Navigator.pop(context);
            _navigateToUnitSelection(context, ref, 'nords', initialFilter,
                allowedFilters, isAttacker);
          },
        ),
        ListTile(
          leading: const Icon(Icons.more_horiz),
          title: const Text('More Factions...'),
          onTap: () {
            Navigator.pop(context);
            _showMoreFactions(context, ref, isAttacker);
          },
        ),
      ],
    );
  }

  void _navigateToUnitSelection(
      BuildContext context,
      WidgetRef ref,
      String faction,
      UnitFilter initialFilter,
      Set<UnitFilter> allowedFilters,
      bool isAttacker) {
    final combatState = ref.read(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UnitSelectionScreen(
          faction: faction,
          initialFilter: initialFilter,
          allowedFilters: allowedFilters,
          title:
              'Select $faction ${combatState.isDuelMode ? "Character" : "Regiment"}',
          onUnitSelected: (regiment) {
            // Ensure selected unit matches the required type
            if (combatState.isDuelMode && !regiment.isCharacter()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'In duel mode, only character units can be selected'),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (!combatState.isDuelMode && regiment.isCharacter()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Characters must be attached to regiments in normal mode'),
                  backgroundColor: Colors.red,
                ),
              );
            } else {
              if (isAttacker) {
                combatNotifier.updateAttacker(regiment);
              } else {
                combatNotifier.updateDefender(regiment);
              }
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}

/// Shows the dialog for additional faction selection
void showFactionSelectionDialog(
    {required BuildContext context,
    required WidgetRef ref,
    required bool isAttacker}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => FactionSelectionBottomSheet(isAttacker: isAttacker),
  );
}

/// Shows the dialog for additional (more) factions selection
void _showMoreFactions(BuildContext context, WidgetRef ref, bool isAttacker) {
  final combatState = ref.read(combatProvider);

  // In duel mode, only allow character selection
  final UnitFilter initialFilter = combatState.isDuelMode
      ? UnitFilter.charactersOnly
      : UnitFilter.regimentsOnly;

  final Set<UnitFilter> allowedFilters = combatState.isDuelMode
      ? {UnitFilter.charactersOnly} // Only show characters in duel mode
      : {
          UnitFilter.all,
          UnitFilter.regimentsOnly,
          UnitFilter.charactersOnly
        }; // Show all normally

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Select Faction'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Old Dominion'),
              onTap: () {
                Navigator.pop(context);
                _navigateToMoreFactionSelection(context, ref, 'old_dominion',
                    initialFilter, allowedFilters, isAttacker);
              },
            ),
            ListTile(
              title: const Text('Spires'),
              onTap: () {
                Navigator.pop(context);
                _navigateToMoreFactionSelection(context, ref, 'spires',
                    initialFilter, allowedFilters, isAttacker);
              },
            ),
            // Additional factions can be added here
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}

void _navigateToMoreFactionSelection(
    BuildContext context,
    WidgetRef ref,
    String faction,
    UnitFilter initialFilter,
    Set<UnitFilter> allowedFilters,
    bool isAttacker) {
  final combatState = ref.read(combatProvider);
  final combatNotifier = ref.read(combatProvider.notifier);

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UnitSelectionScreen(
        faction: faction,
        initialFilter: initialFilter,
        allowedFilters: allowedFilters,
        title:
            'Select $faction ${combatState.isDuelMode ? "Character" : "Regiment"}',
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
