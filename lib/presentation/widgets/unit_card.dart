// lib/presentation/widgets/unit_card.dart
import 'package:flutter/material.dart';
import '../../domain/models/regiment.dart';
import 'unit_selection/special_rule_chip.dart';
import 'unit_selection/special_rules_section.dart';

/// A reusable widget for displaying a regiment's stats and special rules in a card format
class UnitCard extends StatelessWidget {
  final Regiment regiment;
  final bool isCompact;
  final bool showSpecialRules;
  final bool showDrawEvents;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool isAttacker; // Which side this unit is on
  final bool
      inSelectionScreen; // Whether this card is shown in the unit selection screen

  const UnitCard({
    super.key,
    required this.regiment,
    this.isCompact = false,
    this.showSpecialRules = true,
    this.showDrawEvents = true,
    this.padding = const EdgeInsets.all(12.0),
    this.onTap,
    this.isAttacker = true,
    this.inSelectionScreen =
        false, // Default is false (used in combat calculator)
  });

  @override
  Widget build(BuildContext context) {
    final bool isCharacter = regiment.isCharacter();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      // For characters, use a slightly different card color
      color: isCharacter
          ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2)
          : null,
      shape: isCharacter
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
            )
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with unit name and character indicator
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Character badge or unit type icon
                  Badge(
                    isLabelVisible: isCharacter,
                    label: const Text('C'),
                    backgroundColor: isCharacter
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    child: Icon(
                      isCharacter
                          ? Icons.person
                          : _getRegimentTypeIcon(regiment.type),
                      color: isCharacter
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Unit name
                  Expanded(
                    child: Text(
                      regiment.name,
                      style: TextStyle(
                        fontWeight:
                            isCharacter ? FontWeight.bold : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  // Type and class indicators in top right
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          regiment.type.toString().split('.').last,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          regiment.regimentClass.toString().split('.').last,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Stats grid - making it more responsive
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Build stats grid that uses the full width
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _buildStatColumns(context, regiment),
                    );
                  },
                ),
              ),

              // Special rules section
              if (showSpecialRules)
                inSelectionScreen
                    ? _buildReadOnlySpecialRules(context)
                    : SpecialRulesSection(
                        regiment: regiment,
                        isAttacker: isAttacker,
                      ),

              // Draw events section
              if (showDrawEvents && regiment.drawEvents.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Draw Events',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    alignment: WrapAlignment.start,
                    children: regiment.drawEvents.map((event) {
                      return SpecialRuleChip(
                        ruleName: event,
                        readOnly: true, // Always read-only for draw events
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Build read-only special rules section for unit selection screen
  Widget _buildReadOnlySpecialRules(BuildContext context) {
    if (regiment.specialRules.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          'Special Rules',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: regiment.specialRules.map((rule) {
            return SpecialRuleChip(
              ruleName: rule,
              isAttacker: isAttacker,
              readOnly: true, // Force read-only mode in selection screen
            );
          }).toList(),
        ),
      ],
    );
  }

  // Helper method to build stat columns
  List<Widget> _buildStatColumns(BuildContext context, Regiment regiment) {
    final labels = ['M', 'V', 'C', 'A', 'W', 'R', 'D', 'E'];
    final values = [
      regiment.march?.toString() ?? '-',
      regiment.volley.toString(),
      regiment.clash.toString(),
      regiment.attacks.toString(),
      regiment.wounds.toString(),
      regiment.resolve?.toString() ?? '-',
      regiment.defense.toString(),
      regiment.evasion.toString(),
    ];

    return List.generate(labels.length, (index) {
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Stat label
            Container(
              padding: const EdgeInsets.all(4),
              child: Text(
                labels[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Stat value
            Container(
              padding: const EdgeInsets.all(4),
              child: Text(
                values[index],
                style: const TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    });
  }

  IconData _getRegimentTypeIcon(RegimentType type) {
    switch (type) {
      case RegimentType.infantry:
        return Icons.people;
      case RegimentType.cavalry:
        return Icons.sports_handball;
      case RegimentType.brute:
        return Icons.fitness_center;
      case RegimentType.monster:
        return Icons.pets;
      case RegimentType.chariot:
        return Icons.directions_car;
      default:
        return Icons.group;
    }
  }
}
