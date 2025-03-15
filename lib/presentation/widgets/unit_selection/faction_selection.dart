// lib/presentation/widgets/unit_selection/faction_selection.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/combat_provider.dart';
import '../../screens/unit_selection_screen.dart';

/// Displays the bottom sheet for faction selection
class FactionSelectionBottomSheet extends ConsumerWidget {
  final bool isAttacker;
  final Function(String)? onFactionSelected;

  const FactionSelectionBottomSheet({
    super.key,
    required this.isAttacker,
    this.onFactionSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.read(combatProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Select Faction',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.shield),
          title: const Text('Dweghom'),
          onTap: () {
            Navigator.pop(context);
            _handleFactionSelection('Dweghom', context, ref);
          },
        ),
        ListTile(
          leading: const Icon(Icons.castle),
          title: const Text('Hundred Kingdoms'),
          onTap: () {
            Navigator.pop(context);
            _handleFactionSelection('Hundred Kingdoms', context, ref);
          },
        ),
        ListTile(
          leading: const Icon(Icons.nordic_walking),
          title: const Text('Nords'),
          onTap: () {
            Navigator.pop(context);
            _handleFactionSelection('Nords', context, ref);
          },
        ),
        ListTile(
          leading: const Icon(Icons.more_horiz),
          title: const Text('More Factions...'),
          onTap: () {
            Navigator.pop(context);
            _showMoreFactions(context, ref);
          },
        ),
      ],
    );
  }

  void _handleFactionSelection(
      String faction, BuildContext context, WidgetRef ref) {
    // If callback is provided, use it
    if (onFactionSelected != null) {
      onFactionSelected!(faction);
    } else {
      // Otherwise use the legacy flow (direct navigation to unit selection)
      final combatState = ref.read(combatProvider);

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

      final String factionPath = faction.toLowerCase().replaceAll(' ', '_');
      _navigateToUnitSelection(
          context, ref, factionPath, initialFilter, allowedFilters);
    }
  }

  void _navigateToUnitSelection(
      BuildContext context,
      WidgetRef ref,
      String faction,
      UnitFilter initialFilter,
      Set<UnitFilter> allowedFilters) {
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

  /// Shows the dialog for additional factions
  void _showMoreFactions(BuildContext context, WidgetRef ref) {
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
                  _handleFactionSelection('Old Dominion', context, ref);
                },
              ),
              ListTile(
                title: const Text('Spires'),
                onTap: () {
                  Navigator.pop(context);
                  _handleFactionSelection('Spires', context, ref);
                },
              ),
              ListTile(
                title: const Text('Wadrhun'),
                onTap: () {
                  Navigator.pop(context);
                  _handleFactionSelection('Wadrhun', context, ref);
                },
              ),
              ListTile(
                title: const Text('City States'),
                onTap: () {
                  Navigator.pop(context);
                  _handleFactionSelection('City States', context, ref);
                },
              ),
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
}

/// Shows the dialog for faction selection
void showFactionSelectionDialog({
  required BuildContext context,
  required WidgetRef ref,
  required bool isAttacker,
  Function(String)? onFactionSelected,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => FactionSelectionBottomSheet(
      isAttacker: isAttacker,
      onFactionSelected: onFactionSelected,
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
