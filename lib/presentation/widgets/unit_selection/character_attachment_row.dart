// lib/presentation/widgets/unit_selection/character_attachment_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/regiment.dart';
import '../../providers/combat_provider.dart';
import '../../screens/unit_selection_screen.dart';
import '../unit_card.dart';

/// Displays information about an attached character with an option to remove it
class CharacterAttachmentRow extends ConsumerWidget {
  final Regiment character;
  final bool isAttacker;

  const CharacterAttachmentRow({
    super.key,
    required this.character,
    required this.isAttacker,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatNotifier = ref.read(combatProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Character header with remove button
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
            child: Row(
              children: [
                const Icon(Icons.person, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Attached Character',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                // Remove button
                IconButton(
                  icon: const Icon(Icons.person_remove, size: 18),
                  tooltip: 'Remove character stand',
                  onPressed: () {
                    if (isAttacker) {
                      combatNotifier.detachCharacterFromAttacker();
                    } else {
                      combatNotifier.detachCharacterFromDefender();
                    }
                  },
                ),
              ],
            ),
          ),
          // Use the full UnitCard for better visualization
          UnitCard(
            regiment: character,
            isCompact: true,
            padding: const EdgeInsets.all(12.0),
            showSpecialRules: true,
            showDrawEvents: false, // Simplify by hiding draw events
          ),
        ],
      ),
    );
  }
}

/// Utility function to navigate to character selection using the current faction
void selectCharacterForAttachment({
  required BuildContext context,
  required WidgetRef ref,
  required bool isAttacker,
}) {
  final combatState = ref.read(combatProvider);
  final combatNotifier = ref.read(combatProvider.notifier);

  if (isAttacker && combatState.attacker == null) return;
  if (!isAttacker && combatState.defender == null) return;

  // Don't allow character attachment in duel mode
  if (combatState.isDuelMode) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Characters cannot be attached in duel mode'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  // Get the faction of the currently selected regiment
  final faction =
      isAttacker ? combatState.attackerFaction : combatState.defenderFaction;

  if (faction == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select a faction first'),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }

  // Convert to lowercase and replace spaces with underscores for file path
  final String factionPath = CombatState.factionToPath(faction) ??
      faction.toLowerCase().replaceAll(' ', '_');

  // Navigate directly to the unified selection screen with character filter
  // and restrict available filters to characters only
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UnitSelectionScreen(
        faction: factionPath,
        initialFilter: UnitFilter.charactersOnly,
        allowedFilters: {
          UnitFilter.charactersOnly
        }, // Only allow character selection
        title: 'Select $faction Character',
        isDuelMode:
            false, // We know this is not duel mode for character attachment
        onUnitSelected: (character) {
          if (character.isCharacter()) {
            if (isAttacker) {
              combatNotifier.attachCharacterToAttacker(character);
            } else {
              combatNotifier.attachCharacterToDefender(character);
            }
            Navigator.pop(context);
          } else {
            // Show error if somehow a non-character is selected
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('Only character stands can be attached to regiments'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    ),
  );
}
