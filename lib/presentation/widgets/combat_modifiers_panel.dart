// lib/presentation/widgets/combat_modifiers_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import '../themes/app_theme.dart';

class CombatModifiersPanel extends ConsumerWidget {
  const CombatModifiersPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    // Don't show for character vs character
    final bool isCharacterVsCharacterMode = combatState.isDuelMode ||
        (combatState.attacker?.isCharacter() ?? false);

    return Card(
      color: AppTheme.claudeCardSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppTheme.claudeBorder, width: 1),
      ),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Combat Modifiers',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),

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
                child: Row(
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
                        onChanged: (combatState.attacker?.hasBarrage() ?? false)
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
                            // Only enable this checkbox if attacker has impacts
                            onChanged: combatState.combatMode ==
                                        CombatMode.melee &&
                                    (combatState.attacker?.hasImpact() ?? false)
                                ? (value) =>
                                    combatNotifier.toggleImpact(value ?? false)
                                : null,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          // Add Armor Piercing in melee section too for units that have it
                          if (combatState.attacker?.hasArmorPiercing() ?? false)
                            CheckboxListTile(
                              title: const Text('Armor Piercing'),
                              value: combatState
                                      .specialRulesInEffect['armorPiercing'] ??
                                  false,
                              activeColor: AppTheme.claudePrimary,
                              onChanged: combatState.combatMode ==
                                      CombatMode.melee
                                  ? (value) => combatNotifier.toggleSpecialRule(
                                      'armorPiercing', value ?? false)
                                  : null,
                              dense: true,
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
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
                          // Separate armor piercing option
                          if (combatState.attacker?.hasArmorPiercing() ?? false)
                            CheckboxListTile(
                              title: const Text('Armor Piercing'),
                              value: combatState
                                      .specialRulesInEffect['armorPiercing'] ??
                                  false,
                              activeColor: AppTheme.claudePrimary,
                              onChanged: combatState.combatMode ==
                                          CombatMode.ranged &&
                                      combatState.isVolley
                                  ? (value) => combatNotifier.toggleSpecialRule(
                                      'armorPiercing', value ?? false)
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

            const SizedBox(height: 16),

            // Flank/Rear modifier (applies to both melee and ranged) - don't show for character vs character
            if (!isCharacterVsCharacterMode)
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.claudeSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.claudeBorder),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Position Modifiers',
                        style: Theme.of(context).textTheme.titleSmall),
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
