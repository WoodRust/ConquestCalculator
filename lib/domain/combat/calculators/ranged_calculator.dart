// lib/domain/combat/calculators/ranged_calculator.dart
import '../models/combat_input.dart';
import '../models/phase_result.dart';
import 'base_combat_calculator.dart';

class RangedCalculator extends BaseCombatCalculator {
  // Calculate total volleys (barrage attacks)
  int calculateTotalVolleys(CombatInput input) {
    if (input.attacker == null || !input.attacker!.hasBarrage()) {
      return 0; // No barrage capability
    }

    int totalVolleys = input.attacker!.getBarrage() * input.attackerStands;

    // Add character's barrage if present
    if (input.attackerCharacter != null &&
        input.attackerCharacter!.hasBarrage()) {
      totalVolleys += input.attackerCharacter!.getBarrage();
    }

    // Apply special rules for volleys
    if (input.hasAttackerRule('rapid volley') ||
        input.specialRulesInEffect['rapidVolley'] == true) {
      // Rapid volley grants an additional hit on rolls of 1
      // Simulate by increasing expected hits by 1/6 of the total shots
      double rapidVolleyBonus = totalVolleys * (1.0 / 6.0);
      totalVolleys += rapidVolleyBonus.round();
    }

    // Add +1 barrage if regiment has leader special rule
    if (input.hasAttackerRule('leader')) {
      totalVolleys += 1;
    }

    // Penalize for being outside effective range - halved shots
    if (!input.isWithinEffectiveRange) {
      totalVolleys = (totalVolleys * 0.5).round();
    }

    return totalVolleys;
  }

  // Calculate volley target with modifiers (like Aimed)
  int calculateVolleyTarget(CombatInput input) {
    if (input.attacker == null) return 0;

    // Get base hit target (volley value)
    int hitTarget = input.attacker!.volley;

    // Apply Aimed modifier
    if (input.specialRulesInEffect['aimed'] == true ||
        input.hasAttackerRule('deadshots')) {
      hitTarget += 1;

      // If Aimed would raise Volley to 5+, use re-roll instead
      if (hitTarget >= 5) {
        hitTarget = input.attacker!.volley; // Reset to base value
        input.specialRulesInEffect['aimedReroll'] = true;
      }
    }

    return hitTarget;
  }

  // Does the unit get aimed rerolls?
  bool hasRerolls(CombatInput input) {
    return input.specialRulesInEffect['aimedReroll'] == true;
  }

  // Calculate the ranged phase
  PhaseResult calculateRangedPhase(CombatInput input) {
    if (input.attacker == null || !input.isVolley) {
      return PhaseResult.empty();
    }

    // Calculate total volleys
    int totalVolleys = calculateTotalVolleys(input);
    if (totalVolleys <= 0) {
      return PhaseResult.empty();
    }

    // Get hit target
    int hitTarget = calculateVolleyTarget(input);

    // Check for rerolls
    bool useRerolls = hasRerolls(input);

    // Create the appropriate phase result
    if (useRerolls) {
      return createPhaseResultWithRerolls(totalVolleys, hitTarget,
          rerollFails: true);
    } else {
      return createPhaseResult(totalVolleys, hitTarget);
    }
  }
}
