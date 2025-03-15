// lib/presentation/widgets/unit_selection_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import 'unit_selection/combatant_selection_card.dart';
import 'unit_selection/duel_mode_toggle.dart';

class UnitSelectionPanel extends ConsumerWidget {
  const UnitSelectionPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Combat Setup title with Duel mode checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Combat Setup',
                    style: Theme.of(context).textTheme.titleLarge),
                const DuelModeToggle(),
              ],
            ),
            const SizedBox(height: 12),

            // Character vs Character mode indicator
            if (combatState.isDuelMode ||
                combatState.attacker?.isCharacter() == true)
              const CharacterModeIndicator(),

            // Attacker selection
            const CombatantSelectionCard(isAttacker: true),

            const SizedBox(height: 16),

            // Defender selection
            const CombatantSelectionCard(isAttacker: false),
          ],
        ),
      ),
    );
  }
}
