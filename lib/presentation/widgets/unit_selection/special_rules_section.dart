// lib/presentation/widgets/unit_selection/special_rules_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/regiment.dart';
import '../../providers/combat_provider.dart';

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
    final combatNotifier = ref.read(combatProvider.notifier);

    // Check if we have any special rules, barrage, or armor piercing to display
    final bool hasAnyRules = regiment.specialRules.isNotEmpty ||
        regiment.hasBarrage() ||
        regiment.hasArmorPiercing() ||
        regiment.hasImpact() ||
        regiment.shield ||
        regiment.getCleave() > 0;

    // If no special rules, don't show anything
    if (!hasAnyRules) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text('Special Rules', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: _buildSpecialRuleChips(combatState, combatNotifier),
        ),
      ],
    );
  }

  List<Widget> _buildSpecialRuleChips(
      CombatState combatState, CombatNotifier combatNotifier) {
    final List<Widget> chips = [];

    // Add chips based on regiment's special rules
    if (isAttacker) {
      // Handle barrage separately
      if (regiment.hasBarrage()) {
        final barrageText = regiment.barrageRange != null &&
                regiment.barrageRange! > 0
            ? "Barrage (${regiment.getBarrage()}) (${regiment.getBarrageRange()}\")"
            : "Barrage (${regiment.getBarrage()})";

        chips.add(FilterChip(
          label: Text(barrageText),
          selected: combatState.specialRulesInEffect['barrage'] ?? true,
          onSelected: (bool selected) =>
              combatNotifier.toggleSpecialRule('barrage', selected),
        ));
      }

      // Handle armor piercing separately
      if (regiment.hasArmorPiercing()) {
        chips.add(FilterChip(
          label: Text('Armor Piercing (${regiment.getArmorPiercingValue()})'),
          selected: combatState.specialRulesInEffect['armorPiercing'] ?? true,
          onSelected: (bool selected) =>
              combatNotifier.toggleSpecialRule('armorPiercing', selected),
        ));
      }

      // Handle impact as a separate rule
      if (regiment.hasImpact()) {
        chips.add(FilterChip(
          label: Text('Impact (${regiment.getImpact()})'),
          selected: combatState.isImpact,
          onSelected: (bool selected) => combatNotifier.toggleImpact(selected),
        ));
      }

      if (regiment.getCleave() > 0 || regiment.hasSpecialRule('cleave')) {
        chips.add(FilterChip(
          label: Text('Cleave (${regiment.getCleave()})'),
          selected: combatState.specialRulesInEffect['cleave'] ?? true,
          onSelected: (bool selected) =>
              combatNotifier.toggleSpecialRule('cleave', selected),
        ));
      }

      if (regiment.hasSpecialRule('flurry')) {
        chips.add(FilterChip(
          label: const Text('Flurry'),
          selected: combatState.specialRulesInEffect['flurry'] ?? true,
          onSelected: (bool selected) =>
              combatNotifier.toggleSpecialRule('flurry', selected),
        ));
      }

      if (regiment.hasSpecialRule('phalanx')) {
        chips.add(FilterChip(
          label: const Text('Phalanx'),
          selected: combatState.specialRulesInEffect['phalanx'] ?? true,
          onSelected: (bool selected) =>
              combatNotifier.toggleSpecialRule('phalanx', selected),
        ));
      }

      // Add any other special rules not already handled
      for (final rule in regiment.specialRules) {
        // Skip rules that we've already added
        if (rule.contains('Barrage') && regiment.hasBarrage() ||
            rule.contains('Armor Piercing') && regiment.hasArmorPiercing() ||
            rule.contains('Impact') && regiment.hasImpact() ||
            rule.contains('Cleave') && regiment.getCleave() > 0 ||
            rule.contains('Flurry') ||
            rule.contains('Phalanx')) {
          continue;
        }

        // Add other special rules that might be toggleable
        // This could be expanded with more rules
        final String ruleName = rule;
        if (ruleName.isNotEmpty) {
          final String ruleKey = ruleName.toLowerCase().replaceAll(' ', '_');
          chips.add(FilterChip(
            label: Text(ruleName),
            selected: combatState.specialRulesInEffect[ruleKey] ?? true,
            onSelected: (bool selected) =>
                combatNotifier.toggleSpecialRule(ruleKey, selected),
          ));
        }
      }
    } else {
      // Defender special rules
      if (regiment.shield || regiment.hasSpecialRule('shield')) {
        chips.add(FilterChip(
          label: const Text('Shield'),
          selected: combatState.specialRulesInEffect['shield'] ?? true,
          onSelected: (bool selected) =>
              combatNotifier.toggleSpecialRule('shield', selected),
        ));
      }

      // Add any other defender-specific special rules here
      // For example, you might want to handle Armor Piercing for defenders too
      if (regiment.hasArmorPiercing()) {
        chips.add(FilterChip(
          label: Text('Armor Piercing (${regiment.getArmorPiercingValue()})'),
          tooltip:
              'Reduces attacker\'s Defense by ${regiment.getArmorPiercingValue()}',
          selected:
              false, // For defenders, this is informational, not toggleable
          onSelected: null, // Not toggleable for defenders
        ));
      }

      // Add other defender special rules here...
    }

    return chips;
  }
}
