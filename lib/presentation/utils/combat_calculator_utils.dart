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

  /// Calculate expected wounds from impact attacks (including morale wounds)
  static double calculateExpectedImpactWounds(CombatState state) {
    if (state.attacker == null || !state.isImpact || state.defender == null)
      return 0.0;

    // Calculate expected hits
    double expectedHits = calculateExpectedImpactHits(state);

    // Get base defense target
    int defenseTarget =
        math.max(state.defender!.defense, state.defender!.evasion);

    // IMPROVED: Robust Shield detection
    bool hasShield = state.defender!.shield ||
        state.defender!.hasSpecialRule('shield') ||
        state.specialRulesInEffect['shield'] == true;

    // Only apply shield bonus for front attacks
    if (!state.isFlank && !state.isRear && hasShield) {
      defenseTarget += 1;
    }

    // Apply brutal impact if present
    if (state.attacker!.getBrutalImpact() > 0 ||
        state.specialRulesInEffect['brutalImpact'] == true) {
      int brutalImpactValue = state.specialRuleValues['brutalImpactValue'] ??
          state.attacker!.getBrutalImpact();
      defenseTarget = math.max(defenseTarget - brutalImpactValue, 0);
    }

    // Calculate defense success rate (target/6)
    double defenseSuccessRate = defenseTarget / 6.0;

    // Calculate direct wounds
    double expectedDirectWounds = expectedHits * (1 - defenseSuccessRate);

    // Calculate morale wounds - which we DO want included as per correction
    int resolveTarget = state.defender!.getResolve();
    double moraleFailRate = (6 - resolveTarget) / 6.0;
    double expectedMoraleWounds = expectedDirectWounds * moraleFailRate;

    // Return total expected wounds (direct + morale)
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

  /// Calculate expected wounds from regular attacks (including morale wounds)
  static double calculateExpectedWounds(CombatState state) {
    if (state.attacker == null || state.defender == null) return 0.0;

    // Get expected hits
    double expectedHits = calculateExpectedHits(state);

    // Get base defense target
    int defenseTarget =
        math.max(state.defender!.defense, state.defender!.evasion);

    // Apply Shield bonus for front attacks
    bool hasShield = state.defender!.shield ||
        state.defender!.hasSpecialRule('shield') ||
        state.specialRulesInEffect['shield'] == true;

    if (!state.isFlank && !state.isRear && hasShield) {
      defenseTarget += 1;
    }

    // Apply armor piercing for volleys if attacker has it
    if (state.isVolley && state.attacker!.hasArmorPiercing()) {
      defenseTarget =
          math.max(defenseTarget - state.attacker!.getArmorPiercingValue(), 0);
    }
    // Apply armor piercing as a separate rule for non-volley attacks
    else if (!state.isVolley &&
        state.specialRulesInEffect['armorPiercing'] == true) {
      int armorPiercingValue = state.specialRuleValues['armorPiercingValue'] ??
          state.attacker!.getArmorPiercingValue();
      defenseTarget = math.max(defenseTarget - armorPiercingValue, 0);
    }
    // Apply cleave for melee attacks
    else if (!state.isVolley &&
        (state.attacker!.getCleave() > 0 ||
            state.specialRulesInEffect['cleave'] == true)) {
      int cleaveValue =
          state.specialRuleValues['cleaveValue'] ?? state.attacker!.getCleave();
      defenseTarget = math.max(defenseTarget - cleaveValue, 0);
    }

    // Calculate defense success rate (target/6)
    double defenseSuccessRate = defenseTarget / 6.0;

    // Calculate direct wounds
    double expectedDirectWounds = expectedHits * (1 - defenseSuccessRate);

    // Calculate morale wounds
    int resolveTarget = state.defender!.getResolve();

    // Check for Animate Vessel (auto-pass resolve tests)
    bool hasAnimateVessel = state.defender!.hasSpecialRule('animate vessel');
    if (hasAnimateVessel) {
      return expectedDirectWounds; // No morale wounds for Animate Vessel
    }

    // Adjust resolve for flank/rear attacks (re-roll successful tests)
    if (state.isFlank || state.isRear) {
      // Units attacked from flank/rear must re-roll successful resolve tests
      // Simulate re-rolls by reducing the target
      resolveTarget = math.max(resolveTarget - 1, 0);
    }

    // Apply Indomitable effect
    int indomitableValue = state.defender!.getIndomitable();
    if (indomitableValue > 0) {
      // Indomitable prevents a number of failed morale tests equal to its value
      expectedDirectWounds =
          math.max(0, expectedDirectWounds - indomitableValue);
    }

    double moraleFailRate = (6 - resolveTarget) / 6.0;
    double expectedMoraleWounds = expectedDirectWounds * moraleFailRate;

    // Return total expected wounds (direct + morale)
    return expectedDirectWounds + expectedMoraleWounds;
  }
}
