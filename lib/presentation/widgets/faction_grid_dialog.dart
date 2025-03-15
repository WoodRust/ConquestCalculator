// lib/presentation/widgets/faction_grid_dialog.dart
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

/// A dialog that displays all factions in a grid layout for easy selection.
class FactionGridDialog extends StatelessWidget {
  /// Called when a faction is selected.
  final Function(String) onFactionSelected;

  const FactionGridDialog({
    super.key,
    required this.onFactionSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Define all available factions with their icons
    final factions = [
      {"name": "Dweghom", "icon": Icons.shield},
      {"name": "Hundred Kingdoms", "icon": Icons.castle},
      {"name": "Nords", "icon": Icons.nordic_walking},
      {"name": "Old Dominion", "icon": Icons.architecture},
      {"name": "Spires", "icon": Icons.location_city},
      {"name": "Wadrhun", "icon": Icons.forest},
      {"name": "Sorcerer Kings", "icon": Icons.auto_fix_high},
      {"name": "City States", "icon": Icons.business},
      {"name": "Yoroni", "icon": Icons.emoji_flags},
    ];

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: AppTheme.claudeSurface,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dialog title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Faction',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.claudePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  color: AppTheme.claudeSubtleText,
                  tooltip: 'Close',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Faction grid
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85, // Slightly taller than wide for better text display
              physics: const NeverScrollableScrollPhysics(),
              children: factions.map((faction) {
                return InkWell(
                  onTap: () {
                    onFactionSelected(faction['name'] as String);
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: AppTheme.claudeCardSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.claudeBorder),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Faction icon
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.claudePrimary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            faction['icon'] as IconData,
                            color: AppTheme.claudePrimary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Faction name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            faction['name'] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}