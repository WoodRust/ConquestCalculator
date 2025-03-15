// lib/presentation/widgets/unit_selection/combatant_selection_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/regiment.dart';
import '../../providers/combat_provider.dart';
import '../target_selector.dart';
import 'character_attachment_row.dart';
import 'special_rules_section.dart';
import 'faction_selection.dart';
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
        // Faction selection row
        Row(
          children: [
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
          ],
        ),

        const SizedBox(height: 12),

        // Regiment selection row
        Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: combatState.selectionResetDueToModeChange
                      ? Theme.of(context)
                          .colorScheme
                          .errorContainer
                          .withOpacity(0.3)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  // Remove prefix and just show selected regiment or prompt
                  regiment?.name ?? "Select a regiment",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: combatState.selectionResetDueToModeChange
                        ? Theme.of(context).colorScheme.error
                        : null,
                  ),
                ),
              ),
            ),
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

        // Special rules section if a regiment is selected
        if (regiment != null)
          SpecialRulesSection(
            regiment: regiment,
            isAttacker: isAttacker,
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
