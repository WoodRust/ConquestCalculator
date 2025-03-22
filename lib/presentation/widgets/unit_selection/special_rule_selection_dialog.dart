// lib/presentation/widgets/unit_selection/special_rule_selection_dialog.dart
import 'package:flutter/material.dart';
import '../../../data/sources/local/special_rules_service.dart';
import '../../themes/app_theme.dart';

class SpecialRuleSelectionDialog extends StatefulWidget {
  final List<String> currentRules;
  final Function(String) onRuleSelected;

  const SpecialRuleSelectionDialog({
    super.key,
    required this.currentRules,
    required this.onRuleSelected,
  });

  @override
  State<SpecialRuleSelectionDialog> createState() =>
      _SpecialRuleSelectionDialogState();
}

class _SpecialRuleSelectionDialogState
    extends State<SpecialRuleSelectionDialog> {
  final SpecialRulesService _specialRulesService = SpecialRulesService();
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get all special rules from the service
    final allRules = _specialRulesService.getAllSpecialRules();

    // Filter rules based on search query and exclude already selected rules
    final filteredRules = allRules.where((rule) {
      // Check if the rule is not already in the current rules (case-insensitive)
      bool ruleNotAlreadySelected = true;
      for (final currentRule in widget.currentRules) {
        if (currentRule.toLowerCase() == rule.name.toLowerCase() ||
            currentRule
                .toLowerCase()
                .startsWith(rule.name.toLowerCase() + ' (')) {
          ruleNotAlreadySelected = false;
          break;
        }
      }

      // Check if it matches the search query
      final matchesSearch =
          rule.name.toLowerCase().contains(_searchQuery.toLowerCase());

      return ruleNotAlreadySelected && matchesSearch;
    }).toList()
      ..sort((a, b) => a.name.compareTo(b.name)); // Sort alphabetically

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: AppTheme.claudeSurface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Add Special Rule',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.claudePrimary,
                        ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  color: AppTheme.claudeSubtleText,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Search box
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search special rules...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // Rule list
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.claudeBorder),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: filteredRules.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'No special rules found',
                            style: TextStyle(color: AppTheme.claudeSubtleText),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredRules.length,
                        itemBuilder: (context, index) {
                          final rule = filteredRules[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Text(rule.name),
                                subtitle: Text(
                                  rule.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  widget.onRuleSelected(rule.name);
                                  Navigator.of(context).pop();
                                },
                              ),
                              if (index < filteredRules.length - 1)
                                const Divider(height: 1),
                            ],
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.claudePrimary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
