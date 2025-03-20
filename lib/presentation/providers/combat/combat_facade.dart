// lib/presentation/providers/combat/combat_facade.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/regiment.dart';
import 'models/combat_state.dart';
import 'notifiers/combat_notifier.dart';
import 'providers.dart';

/// Provides a simplified interface to combat functionality
class CombatFacade {
  final Ref _ref;

  CombatFacade(this._ref);

  // Get the current state
  CombatState get state => _ref.read(combatProvider);

  // Get the notifier for direct access when needed
  CombatNotifier get notifier => _ref.read(combatProvider.notifier);

  // Common operations
  void calculateCombat() => notifier.calculateCombat();

  // Combatant operations
  void updateAttacker(Regiment? regiment) => notifier.updateAttacker(regiment);
  void updateDefender(Regiment? regiment) => notifier.updateDefender(regiment);
  void updateAttackerStands(int stands) =>
      notifier.updateAttackerStands(stands);
  void updateDefenderStands(int stands) =>
      notifier.updateDefenderStands(stands);
  void attachCharacterToAttacker(Regiment character) =>
      notifier.attachCharacterToAttacker(character);
  void attachCharacterToDefender(Regiment character) =>
      notifier.attachCharacterToDefender(character);
  void detachCharacterFromAttacker() => notifier.detachCharacterFromAttacker();
  void detachCharacterFromDefender() => notifier.detachCharacterFromDefender();
  void setAttackerFaction(String? faction) =>
      notifier.setAttackerFaction(faction);
  void setDefenderFaction(String? faction) =>
      notifier.setDefenderFaction(faction);
  void swapAttackerAndDefender() => notifier.swapAttackerAndDefender();

  // Combat mode operations
  void setCombatMode(CombatMode mode) => notifier.setCombatMode(mode);
  void toggleDuelMode(bool value) => notifier.toggleDuelMode(value);

  // Combat modifier operations
  void toggleCharge(bool value) => notifier.toggleCharge(value);
  void toggleImpact(bool value) => notifier.toggleImpact(value);
  void toggleFlank(bool value) => notifier.toggleFlank(value);
  void toggleRear(bool value) => notifier.toggleRear(value);
  void toggleVolley(bool value) => notifier.toggleVolley(value);
  void toggleWithinEffectiveRange(bool value) =>
      notifier.toggleWithinEffectiveRange(value);
  void toggleArmorPiercing(bool value) => notifier.toggleArmorPiercing(value);
  void updateArmorPiercingValue(int value) =>
      notifier.updateArmorPiercingValue(value);
  void toggleCombatModifier(String rule, bool value) =>
      notifier.toggleCombatModifier(rule, value);
  void updateCombatModifierValue(String rule, int value) =>
      notifier.updateCombatModifierValue(rule, value);

  // Saved calculation operations
  void toggleCumulativeDistribution(bool value) =>
      notifier.toggleCumulativeDistribution(value);
  void saveCurrentCalculation(String name) =>
      notifier.saveCurrentCalculation(name);
  void toggleSavedCalculationVisibility(int index) =>
      notifier.toggleSavedCalculationVisibility(index);
  void deleteSavedCalculation(int index) =>
      notifier.deleteSavedCalculation(index);
}

/// Provider for the combat facade
final combatFacadeProvider = Provider((ref) => CombatFacade(ref));
