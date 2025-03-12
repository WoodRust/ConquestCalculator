// lib/presentation/screens/combat_calculator_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import '../widgets/wave_slider.dart';
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
      ),
      body: Padding(
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectAttacker(context, ref),
                          child: const Text('Select'),
                        ),
                      ],
                    ),

                    if (combatState.attacker != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Number of Attacking Stands: '),
                          TargetSelector(
                            selectionLimit: 10,
                            initialValue: combatState.numAttackerStands,
                            onChanged: (value) =>
                                combatNotifier.updateAttackerStands(value),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 16),

                    // Defender selection
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Defender: ${combatState.defender?.name ?? 'Select a regiment'}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDefender(context, ref),
                          child: const Text('Select'),
                        ),
                      ],
                    ),

                    if (combatState.defender != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Number of Defending Stands: '),
                          TargetSelector(
                            selectionLimit: 10,
                            initialValue: combatState.numDefenderStands,
                            onChanged: (value) =>
                                combatNotifier.updateDefenderStands(value),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 16),

                    // Combat modifiers
                    Text('Combat Modifiers',
                        style: Theme.of(context).textTheme.titleMedium),

                    CheckboxListTile(
                      title: const Text('Charge'),
                      value: combatState.isCharge,
                      onChanged: (value) =>
                          combatNotifier.toggleCharge(value ?? false),
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),

                    CheckboxListTile(
                      title: const Text('Impact'),
                      value: combatState.isImpact,
                      onChanged: (value) =>
                          combatNotifier.toggleImpact(value ?? false),
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),

                    CheckboxListTile(
                      title: const Text('Flank Attack'),
                      value: combatState.isFlank,
                      onChanged: (value) =>
                          combatNotifier.toggleFlank(value ?? false),
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),

                    CheckboxListTile(
                      title: const Text('Rear Attack'),
                      value: combatState.isRear,
                      onChanged: (value) =>
                          combatNotifier.toggleRear(value ?? false),
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // If we don't have a simulation yet, show a placeholder
            if (combatState.simulation == null) ...[
              const Center(
                child: Text(
                    'Select units and configure combat to calculate probabilities'),
              ),
            ] else ...[
              // Combat results
              Text('Combat Results',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),

              // Hit roll wave slider
              Text('Hit Roll', style: Theme.of(context).textTheme.titleMedium),
              WaveSlider(
                width: MediaQuery.of(context).size.width - 32,
                height: 80,
                dragPercentage: 0.0,
                expectedSuccessPercentage:
                    combatState.simulation!.hitRoll.successes /
                        combatState.simulation!.hitRoll.total,
                numDice: combatState.simulation!.hitRoll.total,
                expectedSuccesses:
                    combatState.simulation!.hitRoll.successes.toDouble(),
                onChanged: (value) {}, // We're using it for display only
              ),

              const SizedBox(height: 16),

              // Defense roll wave slider
              Text('Defense Roll',
                  style: Theme.of(context).textTheme.titleMedium),
              WaveSlider(
                width: MediaQuery.of(context).size.width - 32,
                height: 80,
                dragPercentage: 0.0,
                expectedSuccessPercentage:
                    combatState.simulation!.defenseRoll.successes /
                        combatState.simulation!.defenseRoll.total,
                numDice: combatState.simulation!.defenseRoll.total,
                expectedSuccesses:
                    combatState.simulation!.defenseRoll.successes.toDouble(),
                onChanged: (value) {}, // We're using it for display only
              ),

              const SizedBox(height: 16),

              // Resolve roll wave slider
              Text('Resolve Roll',
                  style: Theme.of(context).textTheme.titleMedium),
              WaveSlider(
                width: MediaQuery.of(context).size.width - 32,
                height: 80,
                dragPercentage: 0.0,
                expectedSuccessPercentage:
                    combatState.simulation!.resolveRoll.successes /
                        combatState.simulation!.resolveRoll.total,
                numDice: combatState.simulation!.resolveRoll.total,
                expectedSuccesses:
                    combatState.simulation!.resolveRoll.successes.toDouble(),
                onChanged: (value) {}, // We're using it for display only
              ),

              const SizedBox(height: 24),

              // Results summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expected Wounds: ${combatState.simulation!.defenseRoll.failures + combatState.simulation!.resolveRoll.failures}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Probability of Breaking: ${_calculateBreakProbability(combatState)}%',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
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
              ListTile(
                title: const Text('Sorcerer Kings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegimentSelectionScreen(
                        faction: 'sorcerer_kings',
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
              ListTile(
                title: const Text('W\'adrhun'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegimentSelectionScreen(
                        faction: 'wadrhun',
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
              ListTile(
                title: const Text('Yoroni'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegimentSelectionScreen(
                        faction: 'yoroni',
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
              ListTile(
                title: const Text('City States'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegimentSelectionScreen(
                        faction: 'city_states',
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

  double _calculateBreakProbability(CombatState state) {
    if (state.simulation == null) return 0.0;

    final simulation = state.simulation!;
    final totalWounds =
        simulation.defenseRoll.failures + simulation.resolveRoll.failures;
    final standsLost = totalWounds ~/ state.defender!.wounds;

    // Simplified breaking calculation
    final standsRequired = (state.numDefenderStands / 2).ceil();
    if (standsLost >= standsRequired) {
      return 100.0;
    } else {
      // This is very simplified - a real implementation would use probability distributions
      return (standsLost / standsRequired * 100).clamp(0.0, 100.0);
    }
  }
}
