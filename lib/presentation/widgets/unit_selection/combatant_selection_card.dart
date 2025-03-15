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

    // Get the appropriate regiment and stands count
    final regiment = isAttacker ? combatState.attacker : combatState.defender;
    final stands = isAttacker
        ? combatState.numAttackerStands
        : combatState.numDefenderStands;
    final character = isAttacker
        ? combatState.attackerCharacter
        : combatState.defenderCharacter;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Regiment selection row
        Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: combatState.selectionResetDueToModeChange
                      ? Theme.of(context).colorScheme.errorContainer.withAlpha(
                          77) // Using withAlpha instead of withOpacity
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
              onPressed: () => showFactionSelectionDialog(
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
}
