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

    // If no special rules, don't show anything
    if (regiment.specialRules.isEmpty) {
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
      if (regiment.hasSpecialRule('cleave')) {
        chips.add(FilterChip(
          label: const Text('Cleave'),
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
    } else {
      // Defender special rules
      if (regiment.hasSpecialRule('shield')) {
        chips.add(FilterChip(
          label: const Text('Shield'),
          selected: combatState.specialRulesInEffect['shield'] ?? true,
          onSelected: (bool selected) =>
              combatNotifier.toggleSpecialRule('shield', selected),
        ));
      }

      // Add other defender-specific special rules here
    }

    return chips;
  }
}
