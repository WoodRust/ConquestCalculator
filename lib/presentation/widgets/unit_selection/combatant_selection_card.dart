// lib/presentation/widgets/unit_selection/combatant_selection_card.dart
import 'package:conquest_calculator/presentation/widgets/unit_selection/faction_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/regiment.dart';
import '../../providers/combat_provider.dart';
import '../target_selector.dart';
import 'character_attachment_row.dart';
import '../unit_card.dart';
import '../../themes/app_theme.dart';
import '../faction_grid_dialog.dart';
import '../../screens/unit_selection_screen.dart';

/// A reusable component for selecting either an attacker or defender regiment
class CombatantSelectionCard extends ConsumerWidget {
  final bool isAttacker;

  const CombatantSelectionCard({
    super.key,
    required this.isAttacker,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    // Get the appropriate regiment, faction, and stands count
    final regiment = isAttacker ? combatState.attacker : combatState.defender;
    final faction =
        isAttacker ? combatState.attackerFaction : combatState.defenderFaction;
    final stands = isAttacker
        ? combatState.numAttackerStands
        : combatState.numDefenderStands;
    final character = isAttacker
        ? combatState.attackerCharacter
        : combatState.defenderCharacter;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Combined row with faction selection, stands, and buttons
        Row(
          children: [
            // Faction selection
            Expanded(
              child: InkWell(
                onTap: () => showFactionSelectionDialog(
                  context: context,
                  ref: ref,
                  isAttacker: isAttacker,
                  onFactionSelected: (selectedFaction) {
                    if (isAttacker) {
                      combatNotifier.setAttackerFaction(selectedFaction);
                    } else {
                      combatNotifier.setDefenderFaction(selectedFaction);
                    }
                  },
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Faction: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          faction ?? "Select Faction",
                          style: TextStyle(
                            fontStyle: faction == null
                                ? FontStyle.italic
                                : FontStyle.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Only show stand selector if regiment is selected and not a character
            if (regiment != null &&
                !regiment.isCharacter() &&
                !combatState.isDuelMode)
              TargetSelector(
                selectionLimit: 10,
                initialValue: stands,
                onChanged: (value) {
                  if (isAttacker) {
                    combatNotifier.updateAttackerStands(value);
                  } else {
                    combatNotifier.updateDefenderStands(value);
                  }
                },
              ),

            const SizedBox(width: 8),

            // Select regiment button
            ElevatedButton(
              onPressed: () => _navigateToUnitSelection(
                context: context,
                ref: ref,
                isAttacker: isAttacker,
              ),
              child: const Text('Select'),
            ),

            // Character attachment button - show if appropriate
            if (regiment != null &&
                !regiment.isCharacter() &&
                !combatState.isDuelMode &&
                ((isAttacker && combatState.canAttachCharacterToAttacker()) ||
                    (!isAttacker &&
                        combatState.canAttachCharacterToDefender())))
              IconButton(
                icon: const Icon(Icons.person_add),
                tooltip: character == null
                    ? 'Add character stand'
                    : 'Change character stand',
                onPressed: () => selectCharacterForAttachment(
                  context: context,
                  ref: ref,
                  isAttacker: isAttacker,
                ),
              ),
          ],
        ),

        // Character attachment info if a character is attached
        if (character != null)
          CharacterAttachmentRow(
            character: character,
            isAttacker: isAttacker,
          ),

        // Display unit card
        if (regiment != null)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Container(
              width: double.infinity,
              // Use a container with padding to ensure content doesn't get cut off
              constraints: const BoxConstraints(minWidth: 300),
              child: UnitCard(
                regiment: regiment,
                isCompact: true,
                // Add sufficient padding to prevent content from being cut off
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
            ),
          ),
      ],
    );
  }

  // Navigate to unit selection, using the current faction if available
  void _navigateToUnitSelection({
    required BuildContext context,
    required WidgetRef ref,
    required bool isAttacker,
  }) {
    final combatState = ref.read(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    // Get the current faction if set, otherwise show faction selector first
    final String? currentFaction =
        isAttacker ? combatState.attackerFaction : combatState.defenderFaction;

    if (currentFaction != null) {
      // If faction is already selected, go directly to unit selection
      final String factionPath = CombatState.factionToPath(currentFaction) ??
          currentFaction.toLowerCase().replaceAll(' ', '_');

      navigateToUnitSelection(
        context: context,
        ref: ref,
        faction: factionPath,
        isAttacker: isAttacker,
        initialFilter: combatState.isDuelMode
            ? UnitFilter.charactersOnly
            : UnitFilter.regimentsOnly,
        allowedFilters: combatState.isDuelMode
            ? {UnitFilter.charactersOnly}
            : {
                UnitFilter.all,
                UnitFilter.regimentsOnly,
                UnitFilter.charactersOnly
              },
      );
    } else {
      // If faction is not selected yet, show faction selection dialog first
      showFactionSelectionDialog(
        context: context,
        ref: ref,
        isAttacker: isAttacker,
        onFactionSelected: (selectedFaction) {
          // Update the faction in state
          if (isAttacker) {
            combatNotifier.setAttackerFaction(selectedFaction);
          } else {
            combatNotifier.setDefenderFaction(selectedFaction);
          }

          // Then navigate to unit selection
          final String factionPath =
              CombatState.factionToPath(selectedFaction) ??
                  selectedFaction.toLowerCase().replaceAll(' ', '_');

          navigateToUnitSelection(
            context: context,
            ref: ref,
            faction: factionPath,
            isAttacker: isAttacker,
            initialFilter: combatState.isDuelMode
                ? UnitFilter.charactersOnly
                : UnitFilter.regimentsOnly,
            allowedFilters: combatState.isDuelMode
                ? {UnitFilter.charactersOnly}
                : {
                    UnitFilter.all,
                    UnitFilter.regimentsOnly,
                    UnitFilter.charactersOnly
                  },
          );
        },
      );
    }
  }
}
