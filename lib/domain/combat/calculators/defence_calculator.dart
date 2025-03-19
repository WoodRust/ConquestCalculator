// lib/domain/combat/calculators/defense_calculator.dart
import 'dart:math' as math;
import '../models/combat_input.dart';
import '../models/phase_result.dart';
import 'base_combat_calculator.dart';

class DefenseCalculator extends BaseCombatCalculator {
  // Calculate effective defense target
  int calculateEffectiveDefense(
      CombatInput input, bool isImpact, bool isVolley) {
    if (input.defender == null) return 0;

    // Get the higher of defense or evasion
    int defenseTarget =
        math.max(input.defender!.defense, input.defender!.evasion);

    // Apply defensive rules
    return applyDefensiveRules(defenseTarget, input, isImpact, isVolley);
  }

  // Apply special rules like Shield, Cleave, etc.
  int applyDefensiveRules(
      int defenseTarget, CombatInput input, bool isImpact, bool isVolley) {
    if (input.defender == null || input.attacker == null) return defenseTarget;

    // Apply Shield bonus for front attacks
    bool hasShield = input.defender!.shield ||
        input.hasDefenderRule('shield') ||
        input.specialRulesInEffect['shield'] == true;

    if (!input.isFlank && !input.isRear && hasShield) {
      defenseTarget += 1;
    }

    // Apply armor piercing for volleys
    if (isVolley && input.attacker!.hasArmorPiercing()) {
      defenseTarget =
          math.max(defenseTarget - input.attacker!.getArmorPiercingValue(), 0);
    }
    // Apply armor piercing as a separate rule for non-volley attacks
    else if (!isVolley && input.specialRulesInEffect['armorPiercing'] == true) {
      int armorPiercingValue = input.specialRuleValues['armorPiercingValue'] ??
          input.attacker!.getArmorPiercingValue();
      defenseTarget = math.max(defenseTarget - armorPiercingValue, 0);
    }
    // Apply cleave for melee attacks
    else if (!isVolley &&
        !isImpact &&
        (input.attacker!.getCleave() > 0 ||
            input.specialRulesInEffect['cleave'] == true)) {
      int cleaveValue =
          input.specialRuleValues['cleaveValue'] ?? input.attacker!.getCleave();
      defenseTarget = math.max(defenseTarget - cleaveValue, 0);
    }
    // Apply brutal impact for impact attacks
    else if (isImpact &&
        (input.attacker!.getBrutalImpact() > 0 ||
            input.specialRulesInEffect['brutalImpact'] == true)) {
      int brutalImpactValue = input.specialRuleValues['brutalImpactValue'] ??
          input.attacker!.getBrutalImpact();
      defenseTarget = math.max(defenseTarget - brutalImpactValue, 0);
    }

    return defenseTarget;
  }

  // Calculate defense phase from attack results
  PhaseResult calculateDefensePhase(
      CombatInput input, PhaseResult attackResult, bool isImpact) {
    if (input.defender == null || attackResult.diceCount <= 0) {
      return PhaseResult.empty();
    }

    // Calculate effective defense
    int defenseTarget =
        calculateEffectiveDefense(input, isImpact, input.isVolley);

    // For defense roll failures, we need to roll higher than the defense target
    // E.g., if defense is 2, rolls of 3, 4, 5, 6 are failures (target is 4)
    int failureTarget = 6 - defenseTarget;

    // Use binomial distribution for failures
    return createPhaseResult(
        attackResult.expectedSuccesses.round(), failureTarget);
  }
}
