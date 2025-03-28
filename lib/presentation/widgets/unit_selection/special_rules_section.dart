// lib/presentation/widgets/unit_selection/special_rules_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/regiment.dart';
import '../../providers/combat_provider.dart';
import 'special_rule_chip.dart';
import 'special_rule_selection_dialog.dart';
import '../../themes/app_theme.dart';

/// Displays and manages special rules for a regiment
class SpecialRulesSection extends ConsumerWidget {
  final Regiment regiment;
  final bool isAttacker;

  const SpecialRulesSection({
    super.key,
    required this.regiment,
    required this.isAttacker,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatFacade = ref.read(combatFacadeProvider);

    // Filter combat modifiers that shouldn't be shown as special rules
    final Set<String> combatModifiers = {
      'inspired',
      'aimed',
      'inspiredReroll',
      'aimedReroll'
    };

    // Get the list of built-in rules from the regiment
    final builtInRules = regiment.specialRules;

    // Get the appropriate special rules map based on whether this is attacker or defender
    final Map<String, bool> specialRulesMap = isAttacker
        ? combatState.attackerSpecialRulesInEffect
        : combatState.defenderSpecialRulesInEffect;

    // Get the keys of all optional rules that are active for this unit
    final allActiveRuleKeys = specialRulesMap.entries
        .where((entry) => !combatModifiers.contains(entry.key))
        .map((entry) => entry.key)
        .toList();

    // Filter out built-in rules to get just the optional ones
    final optionalRules = allActiveRuleKeys.where((key) {
      final ruleName = key.replaceAll('_', ' ');
      // Check if this rule is NOT a built-in rule
      return !builtInRules.any((builtIn) =>
          builtIn.toLowerCase() == ruleName.toLowerCase() ||
          builtIn.toLowerCase().startsWith(ruleName.toLowerCase() + ' ('));
    }).toList();

    // If no special rules and no optional rules, don't show anything
    if (builtInRules.isEmpty && optionalRules.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Special Rules',
                style: Theme.of(context).textTheme.titleSmall),
            // Add Special Rule button
            TextButton.icon(
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Rule'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                minimumSize: const Size(0, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () => _showSpecialRuleSelectionDialog(
                context,
                combatState,
                combatFacade,
                builtInRules,
                optionalRules,
                isAttacker,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            // Built-in special rule chips (now toggleable)
            ...builtInRules.map((rule) {
              return SpecialRuleChip(
                ruleName: rule,
                isAttacker: isAttacker,
                isOptional: false,
              );
            }),

            // Optional special rule chips (with remove option)
            ...optionalRules.map((ruleKey) {
              final ruleName = ruleKey.replaceAll('_', ' ');
              return SpecialRuleChip(
                ruleName: _capitalizeWords(ruleName),
                isAttacker: isAttacker,
                isOptional: true,
                isRemovable: true,
                onRemove: () {
                  // Use the new facade methods to remove the rule completely
                  if (isAttacker) {
                    combatFacade.removeAttackerSpecialRule(ruleKey);
                  } else {
                    combatFacade.removeDefenderSpecialRule(ruleKey);
                  }
                },
              );
            }).toList(),
          ],
        ),
      ],
    );
  }

  // Helper method to capitalize words for display
  String _capitalizeWords(String text) {
    return text
        .split(' ')
        .map((word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
  }

  // Show dialog to select a special rule
  void _showSpecialRuleSelectionDialog(
    BuildContext context,
    CombatState combatState,
    CombatFacade combatFacade,
    List<String> builtInRules,
    List<String> optionalRules,
    bool isAttacker,
  ) {
    // Combine built-in and already-added optional rules for exclusion
    final currentRules = [
      ...builtInRules,
      ...optionalRules.map((key) => _capitalizeWords(key.replaceAll('_', ' ')))
    ];

    showDialog(
      context: context,
      builder: (context) => SpecialRuleSelectionDialog(
        currentRules: currentRules,
        onRuleSelected: (rule) {
          // Convert rule name to a key by replacing spaces with underscores and making lowercase
          final ruleKey = rule.toLowerCase().replaceAll(' ', '_');

          // Use the correct method based on whether this is for attacker or defender
          if (isAttacker) {
            combatFacade.toggleAttackerCombatModifier(ruleKey, true);
          } else {
            combatFacade.toggleDefenderCombatModifier(ruleKey, true);
          }
        },
      ),
    );
  }
}
