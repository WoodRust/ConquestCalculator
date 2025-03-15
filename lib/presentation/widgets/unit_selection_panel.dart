// lib/presentation/widgets/unit_selection_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import 'unit_selection/combatant_selection_card.dart';
import 'unit_selection/duel_mode_toggle.dart';
import '../themes/app_theme.dart';
import 'combat_modifiers_panel.dart';

// Custom SwapButton widget
class SwapButton extends ConsumerWidget {
  const SwapButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    final bool hasSelections = combatState.attackerFaction != null ||
        combatState.defenderFaction != null;

    return IconButton(
      icon: const Icon(Icons.swap_horiz),
      tooltip: 'Swap attacker and defender',
      onPressed: hasSelections
          ? () {
              combatNotifier.swapAttackerAndDefender();

              // Show a snackbar to confirm the swap
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.swap_horiz, color: Colors.white),
                      const SizedBox(width: 12),
                      const Text('Attacker and defender swapped'),
                    ],
                  ),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }
          : null, // Disable if no factions selected
      style: IconButton.styleFrom(
        foregroundColor: hasSelections ? AppTheme.claudePrimary : Colors.grey,
        backgroundColor: AppTheme.claudeSurface,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: hasSelections ? AppTheme.claudeBorder : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}

class UnitSelectionPanel extends ConsumerWidget {
  const UnitSelectionPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);

    // Don't show combat modifiers for character vs character
    final bool isCharacterVsCharacterMode = combatState.isDuelMode ||
        (combatState.attacker?.isCharacter() ?? false);

    return Card(
      elevation: 0,
      color: AppTheme.claudeCardSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppTheme.claudeBorder, width: 1),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Combat Setup title with Duel mode checkbox and swap button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Combat Setup',
                    style: Theme.of(context).textTheme.titleLarge),
                Row(
                  children: [
                    // Swap button
                    const SwapButton(),
                    const SizedBox(width: 12),
                    const DuelModeToggle(),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Character vs Character mode indicator
            if (isCharacterVsCharacterMode) const CharacterModeIndicator(),

            // Attacker section
            Container(
              decoration: BoxDecoration(
                color: AppTheme.claudeSurface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.claudeBorder),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: const BoxDecoration(
                            color: AppTheme.claudeAttackerAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          'Attacker',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.claudeAttackerAccent,
                          ),
                        ),
                        const Spacer(),
                        // Clear faction button
                        if (combatState.attackerFaction != null)
                          TextButton.icon(
                            icon: const Icon(Icons.clear, size: 16),
                            label: const Text('Clear Faction'),
                            style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              minimumSize: const Size(0, 36),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              // Clear attacker faction
                              final combatNotifier =
                                  ref.read(combatProvider.notifier);
                              combatNotifier.setAttackerFaction(null);
                            },
                          ),
                      ],
                    ),
                  ),
                  const CombatantSelectionCard(isAttacker: true),
                ],
              ),
            ),

            // Defender section
            Container(
              decoration: BoxDecoration(
                color: AppTheme.claudeSurface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.claudeBorder),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: const BoxDecoration(
                            color: AppTheme.claudeDefenderAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          'Defender',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.claudeDefenderAccent,
                          ),
                        ),
                        const Spacer(),
                        // Clear faction button
                        if (combatState.defenderFaction != null)
                          TextButton.icon(
                            icon: const Icon(Icons.clear, size: 16),
                            label: const Text('Clear Faction'),
                            style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              minimumSize: const Size(0, 36),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              // Clear defender faction
                              final combatNotifier =
                                  ref.read(combatProvider.notifier);
                              combatNotifier.setDefenderFaction(null);
                            },
                          ),
                      ],
                    ),
                  ),
                  const CombatantSelectionCard(isAttacker: false),
                ],
              ),
            ),

            // Combat modifiers panel
            if (!isCharacterVsCharacterMode) const CombatModifiersPanel(),
          ],
        ),
      ),
    );
  }
}
