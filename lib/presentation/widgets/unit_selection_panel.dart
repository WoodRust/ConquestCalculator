// lib/presentation/widgets/unit_selection_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import 'unit_selection/combatant_selection_card.dart';
import 'unit_selection/duel_mode_toggle.dart';
import '../themes/app_theme.dart';

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
    final combatNotifier = ref.read(combatProvider.notifier);

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
            if (combatState.isDuelMode ||
                combatState.attacker?.isCharacter() == true)
              const CharacterModeIndicator(),

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
                              // Use the setAttackerFaction method instead
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
                              // Use the setDefenderFaction method instead
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

            // Combat Mode Selection (Radio buttons) - don't show for character vs character
            if (!isCharacterVsCharacterMode)
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.claudeSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.claudeBorder),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        'Combat Mode',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.claudeText,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<CombatMode>(
                            title: const Text('Melee Combat'),
                            groupValue: combatState.combatMode,
                            value: CombatMode.melee,
                            activeColor: AppTheme.claudePrimary,
                            onChanged: (CombatMode? value) {
                              if (value != null) {
                                combatNotifier.setCombatMode(value);
                              }
                            },
                            dense: true,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<CombatMode>(
                            title: const Text('Ranged Combat'),
                            groupValue: combatState.combatMode,
                            value: CombatMode.ranged,
                            activeColor: AppTheme.claudePrimary,
                            onChanged:
                                (combatState.attacker?.hasBarrage() ?? false)
                                    ? (CombatMode? value) {
                                        if (value != null) {
                                          combatNotifier.setCombatMode(value);
                                        }
                                      }
                                    : null,
                            dense: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Divide combat modifiers into two clear sections - don't show for character vs character
            if (!isCharacterVsCharacterMode)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Melee combat section
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: combatState.combatMode == CombatMode.melee
                            ? AppTheme.claudeSurface
                            : const Color(
                                0xFFF2F2F2), // Even lighter when inactive
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: combatState.combatMode == CombatMode.melee
                              ? AppTheme.claudeDarkerBorder
                              : AppTheme.claudeBorder,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16, right: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Melee Options',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color:
                                    combatState.combatMode == CombatMode.melee
                                        ? AppTheme.claudeText
                                        : AppTheme.claudeSubtleText,
                              )),
                          CheckboxListTile(
                            title: const Text('Clash'),
                            value: combatState.isCharge,
                            activeColor: AppTheme.claudePrimary,
                            onChanged: combatState.combatMode ==
                                    CombatMode.melee
                                ? (value) =>
                                    combatNotifier.toggleCharge(value ?? false)
                                : null,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: const Text('Inspired'),
                            value:
                                combatState.specialRulesInEffect['inspired'] ??
                                    false,
                            activeColor: AppTheme.claudePrimary,
                            onChanged: combatState.combatMode ==
                                    CombatMode.melee
                                ? (value) => combatNotifier.toggleSpecialRule(
                                    'inspired', value ?? false)
                                : null,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: const Text('Impact'),
                            value: combatState.isImpact,
                            activeColor: AppTheme.claudePrimary,
                            onChanged: combatState.combatMode ==
                                        CombatMode.melee &&
                                    (combatState.attacker?.hasImpact() ?? false)
                                ? (value) =>
                                    combatNotifier.toggleImpact(value ?? false)
                                : null,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Ranged combat section
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: combatState.combatMode == CombatMode.ranged
                            ? AppTheme.claudeSurface
                            : const Color(
                                0xFFF2F2F2), // Even lighter when inactive
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: combatState.combatMode == CombatMode.ranged
                              ? AppTheme.claudeDarkerBorder
                              : AppTheme.claudeBorder,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16, left: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ranged Options',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color:
                                    combatState.combatMode == CombatMode.ranged
                                        ? AppTheme.claudeText
                                        : AppTheme.claudeSubtleText,
                              )),
                          CheckboxListTile(
                            title: const Text('Volley'),
                            value: combatState.isVolley,
                            activeColor: AppTheme.claudePrimary,
                            onChanged: (combatState.attacker?.hasBarrage() ??
                                        false) &&
                                    combatState.combatMode == CombatMode.ranged
                                ? (value) {
                                    combatNotifier.toggleVolley(value ?? false);
                                  }
                                : null,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: const Text('Aimed'),
                            value: combatState.specialRulesInEffect['aimed'] ??
                                false,
                            activeColor: AppTheme.claudePrimary,
                            onChanged: combatState.combatMode ==
                                        CombatMode.ranged &&
                                    combatState.isVolley &&
                                    (combatState.attacker?.hasBarrage() ??
                                        false)
                                ? (value) => combatNotifier.toggleSpecialRule(
                                    'aimed', value ?? false)
                                : null,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: const Text('Effective Range'),
                            value: combatState.isWithinEffectiveRange,
                            activeColor: AppTheme.claudePrimary,
                            onChanged: combatState.combatMode ==
                                        CombatMode.ranged &&
                                    combatState.isVolley &&
                                    (combatState.attacker?.hasBarrage() ??
                                        false)
                                ? (value) => combatNotifier
                                    .toggleWithinEffectiveRange(value ?? false)
                                : null,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            // Flank/Rear modifier (applies to both melee and ranged) - don't show for character vs character
            if (!isCharacterVsCharacterMode)
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.claudeSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.claudeBorder),
                ),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Position Modifiers',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.claudeText,
                        )),
                    CheckboxListTile(
                      title: const Text('Flank/Rear Attack'),
                      value: combatState.isFlank || combatState.isRear,
                      activeColor: AppTheme.claudePrimary,
                      onChanged: (value) {
                        if (value != null) {
                          if (value) {
                            // Enable flank, disable rear
                            combatNotifier.toggleFlank(true);
                            combatNotifier.toggleRear(false);
                          } else {
                            // Disable both
                            combatNotifier.toggleFlank(false);
                            combatNotifier.toggleRear(false);
                          }
                        }
                      },
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
