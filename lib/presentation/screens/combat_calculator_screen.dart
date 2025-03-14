// lib/presentation/screens/combat_calculator_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import '../widgets/probability_distribution_chart.dart' as chart;
import '../widgets/target_selector.dart';
import 'regiment_selection_screen.dart';

class CombatCalculatorScreen extends ConsumerWidget {
  const CombatCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Combat Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: combatState.simulation != null
                ? () => _showSaveDialog(context, combatNotifier)
                : null,
            tooltip: 'Save calculation',
          ),
          IconButton(
            icon: Icon(combatState.showCumulativeDistribution
                ? Icons.show_chart
                : Icons.bar_chart),
            onPressed: () => combatNotifier.toggleCumulativeDistribution(
                !combatState.showCumulativeDistribution),
            tooltip: combatState.showCumulativeDistribution
                ? 'Show probability mass function'
                : 'Show cumulative distribution',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Combat setup section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Combat Setup',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 12),

                      // Attacker selection
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Attacker: ${combatState.attacker?.name ?? 'Select a regiment'}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (combatState.attacker != null)
                            TargetSelector(
                              selectionLimit: 10,
                              initialValue: combatState.numAttackerStands,
                              onChanged: (value) =>
                                  combatNotifier.updateAttackerStands(value),
                            ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => _selectAttacker(context, ref),
                            child: const Text('Select'),
                          ),
                        ],
                      ),

                      if (combatState.attacker != null) ...[
                        // Attacker special rules section
                        if (combatState.attacker!.specialRules.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text('Special Rules',
                              style: Theme.of(context).textTheme.titleSmall),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 8,
                            children: [
                              if (combatState.attacker!
                                  .hasSpecialRule('cleave'))
                                FilterChip(
                                  label: const Text('Cleave'),
                                  selected: combatState
                                          .specialRulesInEffect['cleave'] ??
                                      true,
                                  onSelected: (bool selected) => combatNotifier
                                      .toggleSpecialRule('cleave', selected),
                                ),
                              if (combatState.attacker!
                                  .hasSpecialRule('flurry'))
                                FilterChip(
                                  label: const Text('Flurry'),
                                  selected: combatState
                                          .specialRulesInEffect['flurry'] ??
                                      true,
                                  onSelected: (bool selected) => combatNotifier
                                      .toggleSpecialRule('flurry', selected),
                                ),
                              if (combatState.attacker!
                                  .hasSpecialRule('phalanx'))
                                FilterChip(
                                  label: const Text('Phalanx'),
                                  selected: combatState
                                          .specialRulesInEffect['phalanx'] ??
                                      true,
                                  onSelected: (bool selected) => combatNotifier
                                      .toggleSpecialRule('phalanx', selected),
                                ),
                            ],
                          ),
                        ],
                      ],

                      const SizedBox(height: 16),

                      // Defender selection
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Defender: ${combatState.defender?.name ?? 'Select a regiment'}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (combatState.defender != null)
                            TargetSelector(
                              selectionLimit: 10,
                              initialValue: combatState.numDefenderStands,
                              onChanged: (value) =>
                                  combatNotifier.updateDefenderStands(value),
                            ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => _selectDefender(context, ref),
                            child: const Text('Select'),
                          ),
                        ],
                      ),

                      if (combatState.defender != null) ...[
                        // Defender special rules section
                        if (combatState.defender!.specialRules.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text('Special Rules',
                              style: Theme.of(context).textTheme.titleSmall),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 8,
                            children: [
                              if (combatState.defender!
                                  .hasSpecialRule('shield'))
                                FilterChip(
                                  label: const Text('Shield'),
                                  selected: combatState
                                          .specialRulesInEffect['shield'] ??
                                      true,
                                  onSelected: (bool selected) => combatNotifier
                                      .toggleSpecialRule('shield', selected),
                                ),
                              // Add other defender-specific special rules here
                            ],
                          ),
                        ],
                      ],

                      const SizedBox(height: 16),

                      // Combat modifiers section title
                      Text('Combat Modifiers',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),

                      // New Combat Mode Selection (Radio buttons)
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<CombatMode>(
                              title: const Text('Melee Combat'),
                              groupValue: combatState.combatMode,
                              value: CombatMode.melee,
                              onChanged: (CombatMode? value) {
                                if (value != null) {
                                  combatNotifier.setCombatMode(value);
                                }
                              },
                              dense: true,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<CombatMode>(
                              title: const Text('Ranged Combat'),
                              groupValue: combatState.combatMode,
                              value: CombatMode.ranged,
                              onChanged:
                                  (combatState.attacker?.hasBarrage() ?? false)
                                      ? (CombatMode? value) {
                                          if (value != null) {
                                            combatNotifier.setCombatMode(value);
                                          }
                                        }
                                      : null,
                              dense: true,
                            ),
                          ),
                        ],
                      ),

                      // Divide combat modifiers into two clear sections
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Melee combat section
                          Expanded(
                            child: Card(
                              elevation: 1,
                              color: combatState.combatMode == CombatMode.melee
                                  ? Theme.of(context).cardColor
                                  : Colors.grey.shade300,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Melee Options',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    const SizedBox(height: 4),
                                    CheckboxListTile(
                                      title: const Text('Clash'),
                                      value: combatState.isCharge,
                                      onChanged: combatState.combatMode ==
                                              CombatMode.melee
                                          ? (value) => combatNotifier
                                              .toggleCharge(value ?? false)
                                          : null,
                                      dense: true,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                    CheckboxListTile(
                                      title: const Text('Inspired'),
                                      value: combatState.specialRulesInEffect[
                                              'inspired'] ??
                                          false,
                                      onChanged: combatState.combatMode ==
                                              CombatMode.melee
                                          ? (value) =>
                                              combatNotifier.toggleSpecialRule(
                                                  'inspired', value ?? false)
                                          : null,
                                      dense: true,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                    CheckboxListTile(
                                      title: const Text('Impact'),
                                      value: combatState.isImpact,
                                      onChanged: combatState.combatMode ==
                                                  CombatMode.melee &&
                                              (combatState.attacker
                                                      ?.hasImpact() ??
                                                  false)
                                          ? (value) => combatNotifier
                                              .toggleImpact(value ?? false)
                                          : null,
                                      dense: true,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Ranged combat section
                          Expanded(
                            child: Card(
                              elevation: 1,
                              color: combatState.combatMode == CombatMode.ranged
                                  ? Theme.of(context).cardColor
                                  : Colors.grey.shade300,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Ranged Options',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    const SizedBox(height: 4),
                                    CheckboxListTile(
                                      title: const Text('Volley'),
                                      value: combatState.isVolley,
                                      onChanged: (combatState.attacker
                                                      ?.hasBarrage() ??
                                                  false) &&
                                              combatState.combatMode ==
                                                  CombatMode.ranged
                                          ? (value) {
                                              combatNotifier
                                                  .toggleVolley(value ?? false);
                                            }
                                          : null,
                                      dense: true,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                    CheckboxListTile(
                                      title: const Text('Aimed'),
                                      value: combatState
                                              .specialRulesInEffect['aimed'] ??
                                          false,
                                      onChanged: combatState.combatMode ==
                                                  CombatMode.ranged &&
                                              combatState.isVolley &&
                                              (combatState.attacker
                                                      ?.hasBarrage() ??
                                                  false)
                                          ? (value) =>
                                              combatNotifier.toggleSpecialRule(
                                                  'aimed', value ?? false)
                                          : null,
                                      dense: true,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                    CheckboxListTile(
                                      title: const Text('Effective Range'),
                                      value: combatState.isWithinEffectiveRange,
                                      onChanged: combatState.combatMode ==
                                                  CombatMode.ranged &&
                                              combatState.isVolley &&
                                              (combatState.attacker
                                                      ?.hasBarrage() ??
                                                  false)
                                          ? (value) => combatNotifier
                                              .toggleWithinEffectiveRange(
                                                  value ?? false)
                                          : null,
                                      dense: true,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Flank/Rear modifier (applies to both melee and ranged)
                      Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Position Modifiers',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              CheckboxListTile(
                                title: const Text('Flank/Rear Attack'),
                                value:
                                    combatState.isFlank || combatState.isRear,
                                onChanged: (value) {
                                  if (value != null) {
                                    if (value) {
                                      // Enable flank, disable rear
                                      combatNotifier.toggleFlank(true);
                                      combatNotifier.toggleRear(false);
                                    } else {
                                      // Disable both
                                      combatNotifier.toggleFlank(false);
                                      combatNotifier.toggleRear(false);
                                    }
                                  }
                                },
                                dense: true,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // If we don't have a simulation yet, show a placeholder
              if (combatState.simulation == null ||
                  combatState.simulation!.totalDamageDistribution == null) ...[
                const Center(
                  child: Text(
                      'Select units and configure combat to calculate probabilities'),
                ),
              ] else ...[
                // Combat results
                Text('Combat Results',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),

                // Total damage distribution chart
                chart.ProbabilityDistributionChart(
                  distribution:
                      combatState.simulation!.totalDamageDistribution!,
                  title: 'Wound Distribution',
                  width: MediaQuery.of(context).size.width - 32,
                  height: 250,
                  showCumulative: combatState.showCumulativeDistribution,
                  thresholds: [
                    // Stand loss threshold
                    chart.Threshold(
                      value: combatState.defender!.wounds,
                      label: '1 Stand',
                      color: Colors.orange,
                    ),
                    // Breaking threshold
                    chart.Threshold(
                      value: combatState.simulation!.standsToBreak *
                          combatState.defender!.wounds,
                      label: 'Breaking',
                      color: Colors.red,
                    ),
                    // Total destruction
                    chart.Threshold(
                      value: combatState.numDefenderStands *
                          combatState.defender!.wounds,
                      label: 'Destroyed',
                      color: Colors.deepPurple,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Hit & wound distribution charts in a row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hit distribution chart
                    Expanded(
                      child: chart.ProbabilityDistributionChart(
                        distribution: combatState.simulation!.hitDistribution!,
                        title: 'Hit Distribution',
                        height: 180,
                        showCumulative: combatState.showCumulativeDistribution,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Wound distribution from defense rolls
                    Expanded(
                      child: chart.ProbabilityDistributionChart(
                        distribution:
                            combatState.simulation!.woundDistribution!,
                        title: 'After Defense',
                        height: 180,
                        showCumulative: combatState.showCumulativeDistribution,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Results summary
                Card(
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Combat Summary',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          context,
                          'Expected Wounds:',
                          combatState.simulation!
                              .getExpectedWounds()
                              .toString(),
                        ),
                        _buildSummaryRow(
                          context,
                          'Expected Stands Lost:',
                          combatState.simulation!
                              .getExpectedStandsLost()
                              .toString(),
                        ),
                        _buildSummaryRow(
                          context,
                          'Breaking Probability:',
                          '${(combatState.simulation!.breakingProbability * 100).toStringAsFixed(1)}%',
                          color: _getBreakingProbabilityColor(
                              combatState.simulation!.breakingProbability),
                        ),
                        _buildSummaryRow(
                          context,
                          'Destruction Probability:',
                          '${(combatState.simulation!.getProbabilityOfLosingAtLeast(combatState.numDefenderStands) * 100).toStringAsFixed(1)}%',
                        ),
                      ],
                    ),
                  ),
                ),

                // Saved calculations section
                if (combatState.savedCalculations.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text('Saved Calculations',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: combatState.savedCalculations.length,
                    itemBuilder: (context, index) {
                      final calculation = combatState.savedCalculations[index];
                      return ListTile(
                        title: Text(calculation.name),
                        subtitle: Text(
                          '${calculation.simulation.attacker.name} vs ${calculation.simulation.defender.name}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                calculation.isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () => combatNotifier
                                  .toggleSavedCalculationVisibility(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  combatNotifier.deleteSavedCalculation(index),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value,
      {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getBreakingProbabilityColor(double probability) {
    if (probability < 0.25) return Colors.green;
    if (probability < 0.5) return Colors.orange;
    if (probability < 0.75) return Colors.deepOrange;
    return Colors.red;
  }

  void _showSaveDialog(BuildContext context, CombatNotifier notifier) {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Calculation'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'Enter a name for this calculation',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                notifier.saveCurrentCalculation(textController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _selectAttacker(BuildContext context, WidgetRef ref) async {
    final combatNotifier = ref.read(combatProvider.notifier);

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.shield),
            title: const Text('Dweghom'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegimentSelectionScreen(
                    faction: 'dweghom',
                    onRegimentSelected: (regiment) {
                      combatNotifier.updateAttacker(regiment);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.castle),
            title: const Text('Hundred Kingdoms'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegimentSelectionScreen(
                    faction: 'hundred_kingdoms',
                    onRegimentSelected: (regiment) {
                      combatNotifier.updateAttacker(regiment);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.nordic_walking),
            title: const Text('Nords'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegimentSelectionScreen(
                    faction: 'nords',
                    onRegimentSelected: (regiment) {
                      combatNotifier.updateAttacker(regiment);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
          // Add more factions here as you create their JSON files
          ListTile(
            leading: const Icon(Icons.more_horiz),
            title: const Text('More Factions...'),
            onTap: () {
              Navigator.pop(context);
              _showMoreFactions(context, ref, true);
            },
          ),
        ],
      ),
    );
  }

  void _selectDefender(BuildContext context, WidgetRef ref) async {
    final combatNotifier = ref.read(combatProvider.notifier);

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.shield),
            title: const Text('Dweghom'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegimentSelectionScreen(
                    faction: 'dweghom',
                    onRegimentSelected: (regiment) {
                      combatNotifier.updateDefender(regiment);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.castle),
            title: const Text('Hundred Kingdoms'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegimentSelectionScreen(
                    faction: 'hundred_kingdoms',
                    onRegimentSelected: (regiment) {
                      combatNotifier.updateDefender(regiment);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.nordic_walking),
            title: const Text('Nords'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegimentSelectionScreen(
                    faction: 'nords',
                    onRegimentSelected: (regiment) {
                      combatNotifier.updateDefender(regiment);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
          // Add more factions here as you create their JSON files
          ListTile(
            leading: const Icon(Icons.more_horiz),
            title: const Text('More Factions...'),
            onTap: () {
              Navigator.pop(context);
              _showMoreFactions(context, ref, false);
            },
          ),
        ],
      ),
    );
  }

  void _showMoreFactions(BuildContext context, WidgetRef ref, bool isAttacker) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Faction'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Old Dominion'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegimentSelectionScreen(
                        faction: 'old_dominion',
                        onRegimentSelected: (regiment) {
                          if (isAttacker) {
                            ref
                                .read(combatProvider.notifier)
                                .updateAttacker(regiment);
                          } else {
                            ref
                                .read(combatProvider.notifier)
                                .updateDefender(regiment);
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),
              // Additional factions...
              ListTile(
                title: const Text('Spires'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegimentSelectionScreen(
                        faction: 'spires',
                        onRegimentSelected: (regiment) {
                          if (isAttacker) {
                            ref
                                .read(combatProvider.notifier)
                                .updateAttacker(regiment);
                          } else {
                            ref
                                .read(combatProvider.notifier)
                                .updateDefender(regiment);
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),
              // More factions...
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
