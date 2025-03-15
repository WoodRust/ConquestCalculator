// lib/presentation/widgets/unit_selection/duel_mode_toggle.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/combat_provider.dart';
import '../../themes/app_theme.dart';

/// Toggles between normal and duel mode with appropriate feedback
class DuelModeToggle extends ConsumerWidget {
  const DuelModeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    return Row(
      children: [
        Text(
          'Duel',
          style: TextStyle(
            color: combatState.isDuelMode
                ? AppTheme.claudePrimary
                : AppTheme.claudeSubtleText,
            fontWeight:
                combatState.isDuelMode ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        const SizedBox(width: 4),
        Switch(
          value: combatState.isDuelMode,
          onChanged: (value) {
            combatNotifier.toggleDuelMode(value);
            _showDuelModeToggleMessage(context, value);
          },
          activeColor: AppTheme.claudePrimary,
          trackColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return AppTheme.claudePrimary
                  .withAlpha(128); // Using withAlpha instead of withOpacity
            }
            return Colors.grey.shade300;
          }),
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
        backgroundColor:
            isDuelMode ? AppTheme.claudePrimary : Colors.grey.shade700,
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
      decoration: BoxDecoration(
        color: AppTheme.claudeSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.claudeBorder,
        ),
      ),
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(
            Icons.person,
            size: 16,
            color: AppTheme.claudePrimary,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Character vs Character Mode',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.claudePrimary,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.info_outline,
              size: 16,
              color: AppTheme.claudeSubtleText,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
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
                  backgroundColor: AppTheme.claudeCardSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: AppTheme.claudeBorder),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.claudePrimary,
                      ),
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
