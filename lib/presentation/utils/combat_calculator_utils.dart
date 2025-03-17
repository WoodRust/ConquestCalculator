// lib/presentation/utils/combat_calculator_utils.dart
import 'dart:math' as math;
import '../../domain/models/regiment.dart';
import '../providers/combat_provider.dart';

/// Utility class for combat calculations that can be used by both
/// the UI components and tests
class CombatCalculatorUtils {
  /// Calculate total impacts to determine impact attack count
  static int calculateTotalImpacts(CombatState state) {
    if (state.attacker == null || !state.isImpact) return 0;

    // Get the impact value from the attacker
    int impactValue = state.attacker!.getImpact();
    if (impactValue == 0) {
      // Try to get from special rule values if not on the unit
      impactValue = state.specialRuleValues['impactValue'] ?? 0;
    }

    // Calculate total impact attacks: impact value × number of stands
    int totalImpacts = impactValue * state.numAttackerStands;

    // Add character impact attacks if present
    if (state.attackerCharacter != null &&
        state.attackerCharacter!.hasImpact()) {
      totalImpacts += state.attackerCharacter!.getImpact();
    }

    return totalImpacts;
  }

  /// Calculate expected hits from impact attacks
  static double calculateExpectedImpactHits(CombatState state) {
    if (state.attacker == null || !state.isImpact) return 0.0;

    // Get total impacts
    int totalImpacts = calculateTotalImpacts(state);

    // Get the hit target (clash value for impacts)
    int hitTarget = state.attacker!.clash;

    // Apply Glorious Charge bonus when charging
    if (state.isCharge && state.attacker!.hasSpecialRule('glorious charge')) {
      hitTarget += 1;
    }

    // Calculate the base hit probability
    double hitProbability = hitTarget / 6.0;

    // Calculate expected hits
    return totalImpacts * hitProbability;
  }

  /// Calculate expected wounds from impact attacks
  static double calculateExpectedImpactWounds(CombatState state) {
    if (state.attacker == null || !state.isImpact || state.defender == null)
      return 0.0;

    // Calculate expected hits
    double expectedHits = calculateExpectedImpactHits(state);

    // Get defense target
    int defenseTarget =
        math.max(state.defender!.defense, state.defender!.evasion);

    // Apply brutal impact if present
    if (state.attacker!.getBrutalImpact() > 0 ||
        state.specialRulesInEffect['brutalImpact'] == true) {
      int brutalImpactValue = state.specialRuleValues['brutalImpactValue'] ??
          state.attacker!.getBrutalImpact();
      defenseTarget = math.max(defenseTarget - brutalImpactValue, 0);
    }

    // Adjust for flanking/rear attack - ignore shield
    if (state.isFlank || state.isRear) {
      if (state.defender!.hasSpecialRule('shield') || state.defender!.shield) {
        defenseTarget = math.max(defenseTarget - 1, 0);
      }
    }

    // Calculate defense success rate (target/6)
    double defenseSuccessRate = defenseTarget / 6.0;

    // Calculate expected wounds (hits * (1 - defense success rate))
    double expectedDirectWounds = expectedHits * (1 - defenseSuccessRate);

    // Calculate expected morale wounds (simplified - approx 30% of direct wounds)
    // This is a rough approximation - the actual calculation would be more complex
    double expectedMoraleWounds = expectedDirectWounds * 0.3;

    return expectedDirectWounds + expectedMoraleWounds;
  }

  /// Calculate total attacks to determine realistic maximum wounds
  static int calculateTotalAttacks(CombatState state) {
    if (state.attacker == null) return 0;

    // For a character, just use its attacks value
    if (state.attacker!.isCharacter()) {
      return state.attacker!.attacks;
    }

    // For regular regiments, calculate total attacks based on stands and support
    int baseAttacks = state.attacker!.attacks * state.numAttackerStands;

    // Add character attacks if present
    if (state.attackerCharacter != null) {
      baseAttacks += state.attackerCharacter!.attacks;
    }

    // Add +1 for Leader special rule if present
    if (state.attacker!.hasSpecialRule('leader')) {
      baseAttacks += 1;
    }

    return baseAttacks;
  }

  /// Calculate the expected number of hits properly accounting for rerolls
  static double calculateExpectedHits(CombatState state) {
    if (state.attacker == null) return 0.0;

    // Get the total attacks
    int totalAttacks = calculateTotalAttacks(state);

    // Get the hit target (clash value or volley value)
    int hitTarget =
        state.isVolley ? state.attacker!.volley : state.attacker!.clash;

    // Apply any modifiers to the hit target
    // Inspired adds +1 to Clash
    if (state.specialRulesInEffect['inspired'] == true && !state.isVolley) {
      hitTarget += 1;
      // If Inspired would raise Clash to 5+, use re-roll instead (no bonus)
      if (hitTarget >= 5) {
        hitTarget = state.attacker!.clash;
      }
    }

    // Apply Shock bonus when charging
    if (state.isCharge &&
        state.attacker!.hasSpecialRule('shock') &&
        !state.isVolley) {
      hitTarget += 1;
    }

    // Calculate the base hit probability
    double hitProbability = hitTarget / 6.0;

    // Check if rerolls apply
    bool hasRerolls = state.specialRulesInEffect['flurry'] == true ||
        state.specialRulesInEffect['aimedReroll'] == true ||
        state.specialRulesInEffect['inspiredReroll'] == true ||
        (state.attacker!.hasSpecialRule('opportunists') &&
            (state.isFlank || state.isRear) &&
            !state.isImpact);

    // Adjust hit probability for rerolls
    double adjustedHitProbability = hitProbability;
    if (hasRerolls) {
      // Probability with rerolls = original + (missed * original)
      adjustedHitProbability =
          hitProbability + ((1 - hitProbability) * hitProbability);
    }

    // Calculate expected hits
    return totalAttacks * adjustedHitProbability;
  }
}
