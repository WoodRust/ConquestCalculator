// lib/presentation/providers/combat/selectors/combat_selectors.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/regiment.dart';
import '../../../../domain/models/combat_simulation.dart';
import '../models/combat_state.dart';
import '../providers.dart';

/// Selector providers for optimized UI rebuilds

// Selector for combat simulation result
final combatResultProvider = Provider<CombatSimulation?>((ref) {
  return ref.watch(combatProvider).simulation;
});

// Selector for attacker regiment
final attackerProvider = Provider<Regiment?>((ref) {
  return ref.watch(combatProvider).attacker;
});

// Selector for defender regiment
final defenderProvider = Provider<Regiment?>((ref) {
  return ref.watch(combatProvider).defender;
});

// Selector for combat mode
final combatModeProvider = Provider<CombatMode>((ref) {
  return ref.watch(combatProvider).combatMode;
});

// Selector for duel mode
final duelModeProvider = Provider<bool>((ref) {
  return ref.watch(combatProvider).isDuelMode;
});

// Selector for attacker faction
final attackerFactionProvider = Provider<String?>((ref) {
  return ref.watch(combatProvider).attackerFaction;
});

// Selector for defender faction
final defenderFactionProvider = Provider<String?>((ref) {
  return ref.watch(combatProvider).defenderFaction;
});

// Selector for cumulative distribution toggle
final cumulativeDistributionProvider = Provider<bool>((ref) {
  return ref.watch(combatProvider).showCumulativeDistribution;
});

// Selector for saved calculations
final savedCalculationsProvider = Provider((ref) {
  return ref.watch(combatProvider).savedCalculations;
});
