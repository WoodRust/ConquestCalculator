// lib/presentation/providers/combat/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/usecases/calculate_combat.dart';
import 'models/combat_state.dart';
import 'notifiers/combat_notifier.dart';

// Core providers

// Provider for the CalculateCombat use case
final calculateCombatProvider = Provider((ref) => CalculateCombat());

// Main provider for combat state
final combatProvider =
    StateNotifierProvider<CombatNotifier, CombatState>((ref) {
  final calculateCombat = ref.watch(calculateCombatProvider);
  return CombatNotifier(calculateCombat);
});
