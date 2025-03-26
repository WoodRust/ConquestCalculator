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
                          // Clash checkbox with info icon
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: const Text('Clash'),
                                  value: combatState.isCharge,
                                  activeColor: AppTheme.claudePrimary,
                                  onChanged:
                                      combatState.combatMode == CombatMode.melee
                                          ? (value) => combatNotifier
                                              .toggleCharge(value ?? false)
                                          : null,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                              if (combatState.combatMode == CombatMode.melee)
                                IconButton(
                                  icon:
                                      const Icon(Icons.info_outline, size: 18),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  tooltip: 'Clash Attack Info',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Clash'),
                                        content: const Text(
                                            'Standard melee attack.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              const SizedBox(width: 12),
                            ],
                          ),
                          // Inspired checkbox with info icon
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: const Text('Inspired'),
                                  value:
                                      combatState.attackerSpecialRulesInEffect[
                                              'inspired'] ??
                                          false,
                                  activeColor: AppTheme.claudePrimary,
                                  onChanged:
                                      combatState.combatMode == CombatMode.melee
                                          ? (value) => combatNotifier
                                              .toggleAttackerCombatModifier(
                                                  'inspired', value ?? false)
                                          : null,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                              if (combatState.combatMode == CombatMode.melee)
                                IconButton(
                                  icon:
                                      const Icon(Icons.info_outline, size: 18),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  tooltip: 'Inspired Info',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Inspired'),
                                        content: const Text(
                                            '+1 to Clash characteristic'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              const SizedBox(width: 12),
                            ],
                          ),
                          // Impact checkbox
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: const Text('Impact'),
                                  value: combatState.isImpact,
                                  activeColor: AppTheme.claudePrimary,
                                  onChanged: combatState.combatMode ==
                                              CombatMode.melee &&
                                          (combatState.attacker?.hasImpact() ??
                                              false)
                                      ? (value) => combatNotifier
                                          .toggleImpact(value ?? false)
                                      : null,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                              if (combatState.combatMode == CombatMode.melee &&
                                  (combatState.attacker?.hasImpact() ?? false))
                                IconButton(
                                  icon:
                                      const Icon(Icons.info_outline, size: 18),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  tooltip: 'Impact Attack Info',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Impact'),
                                        content: const Text(
                                            'Extra attacks made before standard clash attacks.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              const SizedBox(width: 12),
                            ],
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
                          // Volley checkbox with info icon
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: const Text('Volley'),
                                  value: combatState.isVolley,
                                  activeColor: AppTheme.claudePrimary,
                                  onChanged:
                                      (combatState.attacker?.hasBarrage() ??
                                                  false) &&
                                              combatState.combatMode ==
                                                  CombatMode.ranged
                                          ? (value) {
                                              combatNotifier
                                                  .toggleVolley(value ?? false);
                                            }
                                          : null,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                              if (combatState.combatMode == CombatMode.ranged &&
                                  (combatState.attacker?.hasBarrage() ?? false))
                                IconButton(
                                  icon:
                                      const Icon(Icons.info_outline, size: 18),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  tooltip: 'Volley Info',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Volley'),
                                        content: const Text(
                                            'Ranged attack using Volley characteristic.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              const SizedBox(width: 12),
                            ],
                          ),
                          // Aimed checkbox with info icon
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: const Text('Aimed'),
                                  value:
                                      combatState.attackerSpecialRulesInEffect[
                                              'aimed'] ??
                                          false,
                                  activeColor: AppTheme.claudePrimary,
                                  onChanged: combatState.combatMode ==
                                              CombatMode.ranged &&
                                          combatState.isVolley &&
                                          (combatState.attacker?.hasBarrage() ??
                                              false)
                                      ? (value) => combatNotifier
                                          .toggleAttackerCombatModifier(
                                              'aimed', value ?? false)
                                      : null,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                              if (combatState.combatMode == CombatMode.ranged &&
                                  combatState.isVolley &&
                                  (combatState.attacker?.hasBarrage() ?? false))
                                IconButton(
                                  icon:
                                      const Icon(Icons.info_outline, size: 18),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  tooltip: 'Aimed Info',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Aimed'),
                                        content: const Text(
                                            '+1 to Volley characteristic'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              const SizedBox(width: 12),
                            ],
                          ),
                          // Effective Range checkbox with info icon
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: const Text('Effective Range'),
                                  value: combatState.isWithinEffectiveRange,
                                  activeColor: AppTheme.claudePrimary,
                                  onChanged: combatState.combatMode ==
                                              CombatMode.ranged &&
                                          combatState.isVolley &&
                                          (combatState.attacker?.hasBarrage() ??
                                              false)
                                      ? (value) => combatNotifier
                                          .toggleWithinEffectiveRange(
                                              value ?? false)
                                      : null,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                              if (combatState.combatMode == CombatMode.ranged &&
                                  combatState.isVolley &&
                                  (combatState.attacker?.hasBarrage() ?? false))
                                IconButton(
                                  icon:
                                      const Icon(Icons.info_outline, size: 18),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  tooltip: 'Effective Range Info',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Effective Range'),
                                        content: const Text(
                                            '+1 to Barrage Characteristic, per stand'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              const SizedBox(width: 12),
                            ],
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

                    // Flank/Rear Attack checkbox with info icon
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
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
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline, size: 18),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Flank/Rear Attack'),
                                content: const Text(
                                    'Defender Re-rolls successful resolve checks.'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),

                    // Defender Broken checkbox with info icon
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            title: const Text('Defender Broken'),
                            value: combatState.isDefenderBroken,
                            activeColor: AppTheme.claudePrimary,
                            onChanged: (value) => combatNotifier
                                .toggleDefenderBroken(value ?? false),
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline, size: 18),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Defender Broken'),
                                content: const Text(
                                    'Uses lowest Resolve with no bonuses'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                      ],
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
