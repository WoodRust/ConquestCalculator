// lib/presentation/widgets/unit_selection/special_rule_chip.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/sources/local/special_rules_service.dart';
import '../../../presentation/providers/combat_provider.dart';
import '../../themes/app_theme.dart';

/// A reusable widget for displaying special rules with toggleable behavior
class SpecialRuleChip extends ConsumerWidget {
  final String ruleName;
  final bool isOptional;
  final bool isAttacker;
  final bool isRemovable;

  // Whether the chip is read-only (not toggleable)
  final bool readOnly;

  // These are optional and will override the standard behavior if provided
  final bool? isSelected;
  final Function(bool)? onSelected;
  final VoidCallback? onRemove;

  // Internal services
  final SpecialRulesService _specialRulesService = SpecialRulesService();

  SpecialRuleChip({
    super.key,
    required this.ruleName,
    this.isOptional = false,
    this.isAttacker = true,
    this.isRemovable = false,
    this.readOnly = false,
    this.isSelected,
    this.onSelected,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatFacade = ref.read(combatFacadeProvider);

    // Determine whether this is a special rule or draw event
    bool isSpecialRule = _specialRulesService.hasSpecialRule(ruleName);
    bool isDrawEvent = _specialRulesService.hasDrawEvent(ruleName);

    // Get the appropriate description
    String description = isSpecialRule
        ? _specialRulesService.getSpecialRuleDescription(ruleName)
        : isDrawEvent
            ? _specialRulesService.getDrawEventDescription(ruleName)
            : 'No description available.';

    // Get the rule key by transforming the rule name to lowercase with underscores
    final ruleKey = ruleName.toLowerCase().replaceAll(' ', '_');

    // Get the appropriate special rules map based on whether this is for attacker or defender
    final Map<String, bool> specialRulesMap = isAttacker
        ? combatState.attackerSpecialRulesInEffect
        : combatState.defenderSpecialRulesInEffect;

    // Determine if the rule is active - default to true if not found in the map
    final isActive = isSelected ?? (specialRulesMap[ruleKey] ?? true);

    // Set up the toggle function
    void toggleRule(bool value) {
      if (onSelected != null) {
        onSelected!(value);
      } else {
        // Use the correct method based on attacker/defender
        if (isAttacker) {
          combatFacade.toggleAttackerCombatModifier(ruleKey, value);
        } else {
          combatFacade.toggleDefenderCombatModifier(ruleKey, value);
        }
      }
    }

    // Determine colors based on rule type and state
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    Widget? avatar;

    if (isActive) {
      if (isOptional) {
        // Active optional rule - green theme
        backgroundColor = Colors.green.withOpacity(0.15);
        borderColor = Colors.green.withOpacity(0.5);
        textColor = Colors.green.shade800;
        avatar = const Icon(Icons.check_circle, size: 14, color: Colors.green);
      } else {
        // Active non-optional rule - primary theme
        backgroundColor = AppTheme.claudePrimary.withOpacity(0.1);
        borderColor = AppTheme.claudePrimary.withOpacity(0.3);
        textColor = AppTheme.claudePrimary;
        avatar = null;
      }
    } else {
      if (isOptional) {
        // Inactive optional rule - red theme
        backgroundColor = Colors.red.withOpacity(0.1);
        borderColor = Colors.red.withOpacity(0.3);
        textColor = Colors.red.shade800;
        avatar = const Icon(Icons.cancel, size: 14, color: Colors.red);
      } else {
        // Inactive non-optional rule - grey theme
        backgroundColor = Colors.grey.withOpacity(0.1);
        borderColor = Colors.grey.withOpacity(0.3);
        textColor = Colors.grey.shade700;
        avatar = null;
      }
    }

    return Tooltip(
      message: description,
      preferBelow: false,
      textStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: () {
          // Show dialog with more detailed information
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(ruleName),
              content: Text(description),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        onLongPress: () {
          // Show dialog with more detailed information
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(ruleName),
              content: Text(description),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: isRemovable
            ? Chip(
                label: Text(
                  ruleName,
                  style: TextStyle(
                    fontSize: 11,
                    color: textColor,
                  ),
                ),
                backgroundColor: backgroundColor,
                side: BorderSide(
                  color: borderColor,
                  width: 1,
                ),
                avatar: avatar ?? const Icon(Icons.add_circle, size: 14),
                deleteIcon: const Icon(Icons.close, size: 14),
                onDeleted: onRemove,
              )
            : readOnly
                ? Chip(
                    // Simple non-toggleable chip for read-only mode
                    label: Text(
                      ruleName,
                      style: TextStyle(
                        fontSize: 11,
                        color: textColor,
                      ),
                    ),
                    backgroundColor: backgroundColor,
                    side: BorderSide(
                      color: borderColor,
                      width: 1,
                    ),
                    avatar: avatar,
                  )
                : FilterChip(
                    // Toggleable chip for interactive mode
                    label: Text(
                      ruleName,
                      style: TextStyle(
                        fontSize: 11,
                        color: textColor,
                      ),
                    ),
                    selected: isActive,
                    onSelected: toggleRule,
                    backgroundColor: backgroundColor,
                    selectedColor: backgroundColor,
                    checkmarkColor: textColor,
                    showCheckmark: isActive,
                    avatar: avatar,
                    side: BorderSide(
                      color: borderColor,
                      width: 1,
                    ),
                  ),
      ),
    );
  }
}
