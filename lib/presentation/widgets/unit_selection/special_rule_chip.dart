import 'package:flutter/material.dart';
import '../../../data/sources/local/special_rules_service.dart';

/// A reusable widget for displaying special rules with tooltips and detailed info on tap
class SpecialRuleChip extends StatelessWidget {
  final String ruleName;
  final bool isSelected;
  final Color? backgroundColor;
  final Color? borderColor;
  final Function(bool)? onSelected;
  final SpecialRulesService _specialRulesService = SpecialRulesService();

  SpecialRuleChip({
    super.key,
    required this.ruleName,
    this.isSelected = false,
    this.backgroundColor,
    this.borderColor,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Determine whether this is a special rule or draw event
    bool isSpecialRule = _specialRulesService.hasSpecialRule(ruleName);
    bool isDrawEvent = _specialRulesService.hasDrawEvent(ruleName);

    // Get the appropriate description
    String description = isSpecialRule
        ? _specialRulesService.getSpecialRuleDescription(ruleName)
        : isDrawEvent
            ? _specialRulesService.getDrawEventDescription(ruleName)
            : 'No description available.';

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
        borderRadius: BorderRadius.circular(12),
        child: onSelected != null
            ? FilterChip(
                label: Text(
                  ruleName,
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                selected: isSelected,
                onSelected: onSelected,
                backgroundColor: backgroundColor ??
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                side: BorderSide(
                  color: borderColor ??
                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  width: 1,
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: backgroundColor ??
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: borderColor ??
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  ruleName,
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
      ),
    );
  }
}
