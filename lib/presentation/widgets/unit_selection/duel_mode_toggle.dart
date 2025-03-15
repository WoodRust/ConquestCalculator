// lib/presentation/widgets/unit_selection/duel_mode_toggle.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/combat_provider.dart';

/// Toggles between normal and duel mode with appropriate feedback
class DuelModeToggle extends ConsumerWidget {
  const DuelModeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    return Row(
      children: [
        const Text('Duel'),
        const SizedBox(width: 4),
        Switch(
          value: combatState.isDuelMode,
          onChanged: (value) {
            combatNotifier.toggleDuelMode(value);
            _showDuelModeToggleMessage(context, value);
          },
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  void _showDuelModeToggleMessage(BuildContext context, bool isDuelMode) {
    ScaffoldMessenger.of(context)
        .clearSnackBars(); // Clear any existing messages
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(isDuelMode ? Icons.person : Icons.people, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isDuelMode
                    ? 'Switched to Duel Mode. All selections have been reset.'
                    : 'Exited Duel Mode. All selections have been reset.',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: isDuelMode
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

/// Displays information about character vs character mode
class CharacterModeIndicator extends StatelessWidget {
  const CharacterModeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, size: 16),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Character vs Character Mode',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, size: 16),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Character vs Character Combat'),
                  content: const Text(
                      'In character vs character mode, combat is resolved differently:\n\n'
                      '• Only characters can fight other characters\n'
                      '• No stand count selection is needed\n'
                      '• Characters cannot have other characters attached to them'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
