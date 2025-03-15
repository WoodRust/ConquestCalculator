// lib/presentation/widgets/combat_modifiers_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';

class CombatModifiersPanel extends ConsumerWidget {
  const CombatModifiersPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    // Don't show for character vs character
    final bool isCharacterVsCharacterMode = combatState.isDuelMode ||
        (combatState.attacker?.isCharacter() ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Combat Modifiers',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),

        // Combat Mode Selection (Radio buttons) - don't show for character vs character
        if (!isCharacterVsCharacterMode)
          Row(
            children: [
              Expanded(
                child: RadioListTile<CombatMode>(
                  title: const Text('Melee Combat'),
                  groupValue: combatState.combatMode,
                  value: CombatMode.melee,
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

        // Divide combat modifiers into two clear sections - don't show for character vs character
        if (!isCharacterVsCharacterMode)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Melee combat section
              Expanded(
                child: Card(
                  elevation: 1,
                  color: combatState.combatMode == CombatMode.melee
                      ? Theme.of(context).cardColor
                      : Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Melee Options',
                            style: Theme.of(context).textTheme.titleSmall),
                        const SizedBox(height: 4),
                        CheckboxListTile(
                          title: const Text('Clash'),
                          value: combatState.isCharge,
                          onChanged: combatState.combatMode == CombatMode.melee
                              ? (value) =>
                                  combatNotifier.toggleCharge(value ?? false)
                              : null,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          title: const Text('Inspired'),
                          value: combatState.specialRulesInEffect['inspired'] ??
                              false,
                          onChanged: combatState.combatMode == CombatMode.melee
                              ? (value) => combatNotifier.toggleSpecialRule(
                                  'inspired', value ?? false)
                              : null,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          title: const Text('Impact'),
                          value: combatState.isImpact,
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
              ),
              const SizedBox(width: 8),
              // Ranged combat section
              Expanded(
                child: Card(
                  elevation: 1,
                  color: combatState.combatMode == CombatMode.ranged
                      ? Theme.of(context).cardColor
                      : Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ranged Options',
                            style: Theme.of(context).textTheme.titleSmall),
                        const SizedBox(height: 4),
                        CheckboxListTile(
                          title: const Text('Volley'),
                          value: combatState.isVolley,
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
                          onChanged: combatState.combatMode ==
                                      CombatMode.ranged &&
                                  combatState.isVolley &&
                                  (combatState.attacker?.hasBarrage() ?? false)
                              ? (value) => combatNotifier.toggleSpecialRule(
                                  'aimed', value ?? false)
                              : null,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          title: const Text('Effective Range'),
                          value: combatState.isWithinEffectiveRange,
                          onChanged: combatState.combatMode ==
                                      CombatMode.ranged &&
                                  combatState.isVolley &&
                                  (combatState.attacker?.hasBarrage() ?? false)
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
              ),
            ],
          ),

        const SizedBox(height: 8),

        // Flank/Rear modifier (applies to both melee and ranged) - don't show for character vs character
        if (!isCharacterVsCharacterMode)
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Position Modifiers',
                      style: Theme.of(context).textTheme.titleSmall),
                  CheckboxListTile(
                    title: const Text('Flank/Rear Attack'),
                    value: combatState.isFlank || combatState.isRear,
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
          ),
      ],
    );
  }
}
