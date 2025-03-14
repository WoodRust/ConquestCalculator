// lib/presentation/screens/combat_calculator_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import '../widgets/probability_distribution_chart.dart' as chart;
import '../widgets/target_selector.dart';
import 'unit_selection_screen.dart';

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
                      // Combat Setup title with Duel mode checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Combat Setup',
                              style: Theme.of(context).textTheme.titleLarge),
                          Row(
                            children: [
                              const Text('Duel'),
                              const SizedBox(width: 4),
                              Checkbox(
                                value: combatState.isDuelMode,
                                onChanged: (value) {
                                  if (value != null) {
                                    combatNotifier.toggleDuelMode(value);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Character vs Character mode indicator
                      if (combatState.isDuelMode ||
                          combatState.attacker?.isCharacter() == true)
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(bottom: 12.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5),
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
                                      title: const Text(
                                          'Character vs Character Combat'),
                                      content: const Text(
                                          'In character vs character mode, combat is resolved differently:\n\n'
                                          '• Only characters can fight other characters\n'
                                          '• No stand count selection is needed\n'
                                          '• Characters cannot have other characters attached to them'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

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
                          if (combatState.attacker != null &&
                              !combatState.attacker!.isCharacter() &&
                              !combatState.isDuelMode)
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
                          if (combatState.attacker != null &&
                              !combatState.attacker!.isCharacter() &&
                              combatState.canAttachCharacterToAttacker() &&
                              !combatState.isDuelMode)
                            IconButton(
                              icon: const Icon(Icons.person_add),
                              tooltip: combatState.attackerCharacter == null
                                  ? 'Add character stand'
                                  : 'Change character stand',
                              onPressed: () =>
                                  _selectAttackerCharacter(context, ref),
                            ),
                        ],
                      ),

                      // Display attached character info with remove button
                      if (combatState.attackerCharacter != null) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                          child: Row(
                            children: [
                              const Icon(Icons.person, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Character: ${combatState.attackerCharacter!.name}',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                              // Move the remove button here next to character info
                              IconButton(
                                icon: const Icon(Icons.person_remove, size: 18),
                                tooltip: 'Remove character stand',
                                onPressed: () => ref
                                    .read(combatProvider.notifier)
                                    .detachCharacterFromAttacker(),
                              ),
                            ],
                          ),
                        ),
                      ],

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
                          if (combatState.defender != null &&
                              !combatState.defender!.isCharacter() &&
                              !combatState.isDuelMode)
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
                          if (combatState.defender != null &&
                              !combatState.defender!.isCharacter() &&
                              combatState.canAttachCharacterToDefender() &&
                              !combatState.isDuelMode)
                            IconButton(
                              icon: const Icon(Icons.person_add),
                              tooltip: combatState.defenderCharacter == null
                                  ? 'Add character stand'
                                  : 'Change character stand',
                              onPressed: () =>
                                  _selectDefenderCharacter(context, ref),
                            ),
                        ],
                      ),

                      // Display attached character info with remove button
                      if (combatState.defenderCharacter != null) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                          child: Row(
                            children: [
                              const Icon(Icons.person, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Character: ${combatState.defenderCharacter!.name}',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                              // Move the remove button here next to character info
                              IconButton(
                                icon: const Icon(Icons.person_remove, size: 18),
                                tooltip: 'Remove character stand',
                                onPressed: () => ref
                                    .read(combatProvider.notifier)
                                    .detachCharacterFromDefender(),
                              ),
                            ],
                          ),
                        ),
                      ],

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

                      // Combat Mode Selection (Radio buttons)
                      if (!(combatState.isDuelMode ||
                          (combatState.attacker?.isCharacter() ??
                              false))) // Don't show for character vs character
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
                                onChanged: (combatState.attacker
                                            ?.hasBarrage() ??
                                        false)
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
                      if (!(combatState.isDuelMode ||
                          (combatState.attacker?.isCharacter() ??
                              false))) // Don't show for character vs character
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Melee combat section
                            Expanded(
                              child: Card(
                                elevation: 1,
                                color:
                                    combatState.combatMode == CombatMode.melee
                                        ? Theme.of(context).cardColor
                                        : Colors.grey.shade300,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            ? (value) => combatNotifier
                                                .toggleSpecialRule(
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
                                color:
                                    combatState.combatMode == CombatMode.ranged
                                        ? Theme.of(context).cardColor
                                        : Colors.grey.shade300,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                combatNotifier.toggleVolley(
                                                    value ?? false);
                                              }
                                            : null,
                                        dense: true,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      ),
                                      CheckboxListTile(
                                        title: const Text('Aimed'),
                                        value: combatState.specialRulesInEffect[
                                                'aimed'] ??
                                            false,
                                        onChanged: combatState.combatMode ==
                                                    CombatMode.ranged &&
                                                combatState.isVolley &&
                                                (combatState.attacker
                                                        ?.hasBarrage() ??
                                                    false)
                                            ? (value) => combatNotifier
                                                .toggleSpecialRule(
                                                    'aimed', value ?? false)
                                            : null,
                                        dense: true,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      ),
                                      CheckboxListTile(
                                        title: const Text('Effective Range'),
                                        value:
                                            combatState.isWithinEffectiveRange,
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
                      if (!(combatState.isDuelMode ||
                          (combatState.attacker?.isCharacter() ??
                              false))) // Don't show for character vs character
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
                      value: (combatState.defender!.isCharacter()
                              ? 1
                              : combatState.numDefenderStands) *
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
                          '${(combatState.simulation!.getProbabilityOfLosingAtLeast(combatState.defender!.isCharacter() ? 1 : combatState.numDefenderStands) * 100).toStringAsFixed(1)}%',
                        ),
                        // Show effective stand counts when characters are attached
                        if (combatState.attackerCharacter != null ||
                            combatState.defenderCharacter != null ||
                            combatState.attacker?.isCharacter() == true ||
                            combatState.defender?.isCharacter() == true) ...[
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          Text(
                            'Stand Counts (including characters)',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 4),
                          _buildSummaryRow(
                            context,
                            'Attacker Effective Stands:',
                            combatState.effectiveAttackerStands.toString(),
                          ),
                          _buildSummaryRow(
                            context,
                            'Defender Effective Stands:',
                            combatState.effectiveDefenderStands.toString(),
                          ),
                          _buildSummaryRow(
                            context,
                            'Defender Stands to Break:',
                            combatState.simulation!.standsToBreak.toString(),
                          ),
                        ],
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
    final combatState = ref.read(combatProvider);

    // In duel mode, only allow character selection
    final UnitFilter initialFilter = combatState.isDuelMode
        ? UnitFilter.charactersOnly
        : UnitFilter.regimentsOnly;
    final Set<UnitFilter> allowedFilters = combatState.isDuelMode
        ? {UnitFilter.charactersOnly} // Only show characters in duel mode
        : {
            UnitFilter.all,
            UnitFilter.regimentsOnly,
            UnitFilter.charactersOnly
          }; // Show all normally

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
                  builder: (context) => UnitSelectionScreen(
                    faction: 'dweghom',
                    initialFilter: initialFilter,
                    allowedFilters: allowedFilters,
                    title:
                        'Select Dweghom ${combatState.isDuelMode ? "Character" : "Regiment"}',
                    onUnitSelected: (regiment) {
                      // Ensure selected unit matches the required type
                      if (combatState.isDuelMode && !regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'In duel mode, only character units can be selected'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!combatState.isDuelMode &&
                          regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Characters must be attached to regiments in normal mode'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        combatNotifier.updateAttacker(regiment);
                        Navigator.pop(context);
                      }
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
                  builder: (context) => UnitSelectionScreen(
                    faction: 'hundred_kingdoms',
                    initialFilter: initialFilter,
                    allowedFilters: allowedFilters,
                    title:
                        'Select Hundred Kingdoms ${combatState.isDuelMode ? "Character" : "Regiment"}',
                    onUnitSelected: (regiment) {
                      // Ensure selected unit matches the required type
                      if (combatState.isDuelMode && !regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'In duel mode, only character units can be selected'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!combatState.isDuelMode &&
                          regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Characters must be attached to regiments in normal mode'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        combatNotifier.updateAttacker(regiment);
                        Navigator.pop(context);
                      }
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
                  builder: (context) => UnitSelectionScreen(
                    faction: 'nords',
                    initialFilter: initialFilter,
                    allowedFilters: allowedFilters,
                    title:
                        'Select Nords ${combatState.isDuelMode ? "Character" : "Regiment"}',
                    onUnitSelected: (regiment) {
                      // Ensure selected unit matches the required type
                      if (combatState.isDuelMode && !regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'In duel mode, only character units can be selected'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!combatState.isDuelMode &&
                          regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Characters must be attached to regiments in normal mode'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        combatNotifier.updateAttacker(regiment);
                        Navigator.pop(context);
                      }
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

  // Updated method to use the unified UnitSelectionScreen for character selection
  void _selectAttackerCharacter(BuildContext context, WidgetRef ref) async {
    final combatNotifier = ref.read(combatProvider.notifier);
    final combatState = ref.read(combatProvider);

    if (combatState.attacker == null) return;

    // Don't allow character attachment in duel mode
    if (combatState.isDuelMode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Characters cannot be attached in duel mode'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Get the faction of the currently selected attacker regiment
    // Convert to lowercase and replace spaces with underscores for file path
    final String attackerFaction =
        combatState.attacker!.faction.toLowerCase().replaceAll(' ', '_');

    // Navigate directly to the unified selection screen with character filter
    // and restrict available filters to characters only
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UnitSelectionScreen(
          faction: attackerFaction,
          initialFilter: UnitFilter.charactersOnly,
          allowedFilters: {
            UnitFilter.charactersOnly
          }, // Only allow character selection
          title: 'Select ${combatState.attacker!.faction} Character',
          onUnitSelected: (character) {
            if (character.isCharacter()) {
              combatNotifier.attachCharacterToAttacker(character);
              Navigator.pop(context);
            } else {
              // Show error if somehow a non-character is selected
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Only character stands can be attached to regiments'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _selectDefender(BuildContext context, WidgetRef ref) async {
    final combatNotifier = ref.read(combatProvider.notifier);
    final combatState = ref.read(combatProvider);

    // In duel mode, only allow character selection
    final UnitFilter initialFilter = combatState.isDuelMode
        ? UnitFilter.charactersOnly
        : UnitFilter.regimentsOnly;
    final Set<UnitFilter> allowedFilters = combatState.isDuelMode
        ? {UnitFilter.charactersOnly} // Only show characters in duel mode
        : {
            UnitFilter.all,
            UnitFilter.regimentsOnly,
            UnitFilter.charactersOnly
          }; // Show all normally

    // If attacker is a character in non-duel mode, restrict defender to characters too
    final bool characterVsCharacterMode = !combatState.isDuelMode &&
        (combatState.attacker?.isCharacter() ?? false);

    if (characterVsCharacterMode) {
      showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Notice'),
              subtitle: const Text(
                  'When attacker is a character in normal mode, defender must also be a character. Consider using Duel Mode for character vs character combat.'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

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
                  builder: (context) => UnitSelectionScreen(
                    faction: 'dweghom',
                    initialFilter: initialFilter,
                    allowedFilters: allowedFilters,
                    title:
                        'Select Dweghom ${combatState.isDuelMode ? "Character" : "Regiment"}',
                    onUnitSelected: (regiment) {
                      // Ensure selected unit matches the required type
                      if (combatState.isDuelMode && !regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'In duel mode, only character units can be selected'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!combatState.isDuelMode &&
                          regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Characters must be attached to regiments in normal mode'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        combatNotifier.updateDefender(regiment);
                        Navigator.pop(context);
                      }
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
                  builder: (context) => UnitSelectionScreen(
                    faction: 'hundred_kingdoms',
                    initialFilter: initialFilter,
                    allowedFilters: allowedFilters,
                    title:
                        'Select Hundred Kingdoms ${combatState.isDuelMode ? "Character" : "Regiment"}',
                    onUnitSelected: (regiment) {
                      // Ensure selected unit matches the required type
                      if (combatState.isDuelMode && !regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'In duel mode, only character units can be selected'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!combatState.isDuelMode &&
                          regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Characters must be attached to regiments in normal mode'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        combatNotifier.updateDefender(regiment);
                        Navigator.pop(context);
                      }
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
                  builder: (context) => UnitSelectionScreen(
                    faction: 'nords',
                    initialFilter: initialFilter,
                    allowedFilters: allowedFilters,
                    title:
                        'Select Nords ${combatState.isDuelMode ? "Character" : "Regiment"}',
                    onUnitSelected: (regiment) {
                      // Ensure selected unit matches the required type
                      if (combatState.isDuelMode && !regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'In duel mode, only character units can be selected'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!combatState.isDuelMode &&
                          regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Characters must be attached to regiments in normal mode'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        combatNotifier.updateDefender(regiment);
                        Navigator.pop(context);
                      }
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

  // Updated method to use the unified UnitSelectionScreen for character selection
  void _selectDefenderCharacter(BuildContext context, WidgetRef ref) async {
    final combatNotifier = ref.read(combatProvider.notifier);
    final combatState = ref.read(combatProvider);

    if (combatState.defender == null) return;

    // Don't allow character attachment in duel mode
    if (combatState.isDuelMode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Characters cannot be attached in duel mode'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Get the faction of the currently selected defender regiment
    // Convert to lowercase and replace spaces with underscores for file path
    final String defenderFaction =
        combatState.defender!.faction.toLowerCase().replaceAll(' ', '_');

    // Navigate directly to the unified selection screen with character filter
    // and restrict available filters to characters only
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UnitSelectionScreen(
          faction: defenderFaction,
          initialFilter: UnitFilter.charactersOnly,
          allowedFilters: {
            UnitFilter.charactersOnly
          }, // Only allow character selection
          title: 'Select ${combatState.defender!.faction} Character',
          onUnitSelected: (character) {
            if (character.isCharacter()) {
              combatNotifier.attachCharacterToDefender(character);
              Navigator.pop(context);
            } else {
              // Show error if somehow a non-character is selected
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Only character stands can be attached to regiments'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _showMoreFactions(BuildContext context, WidgetRef ref, bool isAttacker) {
    final combatState = ref.read(combatProvider);

    // In duel mode, only allow character selection
    final UnitFilter initialFilter = combatState.isDuelMode
        ? UnitFilter.charactersOnly
        : UnitFilter.regimentsOnly;
    final Set<UnitFilter> allowedFilters = combatState.isDuelMode
        ? {UnitFilter.charactersOnly} // Only show characters in duel mode
        : {
            UnitFilter.all,
            UnitFilter.regimentsOnly,
            UnitFilter.charactersOnly
          }; // Show all normally

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
                      builder: (context) => UnitSelectionScreen(
                        faction: 'old_dominion',
                        initialFilter: initialFilter,
                        allowedFilters: allowedFilters,
                        title:
                            'Select Old Dominion ${combatState.isDuelMode ? "Character" : "Regiment"}',
                        onUnitSelected: (regiment) {
                          // Ensure selected unit matches the required type
                          if (combatState.isDuelMode &&
                              !regiment.isCharacter()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'In duel mode, only character units can be selected'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          } else if (!combatState.isDuelMode &&
                              regiment.isCharacter()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Characters must be attached to regiments in normal mode'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

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
                      builder: (context) => UnitSelectionScreen(
                        faction: 'spires',
                        initialFilter: initialFilter,
                        allowedFilters: allowedFilters,
                        title:
                            'Select Spires ${combatState.isDuelMode ? "Character" : "Regiment"}',
                        onUnitSelected: (regiment) {
                          // Ensure selected unit matches the required type
                          if (combatState.isDuelMode &&
                              !regiment.isCharacter()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'In duel mode, only character units can be selected'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          } else if (!combatState.isDuelMode &&
                              regiment.isCharacter()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Characters must be attached to regiments in normal mode'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

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
