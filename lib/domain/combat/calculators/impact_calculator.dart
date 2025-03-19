// lib/domain/combat/calculators/impact_calculator.dart
import 'package:conquest_calculator/domain/combat/calculators/base_combat_calculator.dart';
import 'package:conquest_calculator/domain/combat/models/combat_input.dart';
import 'package:conquest_calculator/domain/combat/models/phase_result.dart';

/// Calculator for the Impact phase of combat
class ImpactCalculator extends BaseCombatCalculator {
  /// Calculate the total number of impact attacks
  int calculateTotalImpacts(CombatInput input) {
    if (!input.isImpact || !input.attacker.hasImpact()) {
      return 0;
    }

    // Get base impact value from the regiment
    int impactValue = input.attacker.getImpact();

    // Calculate impact attacks from regiment stands
    int totalImpacts = impactValue * input.attackerStands;

    // Add character impact attacks if present
    if (input.attackerCharacter != null &&
        input.attackerCharacter!.hasImpact()) {
      totalImpacts += input.attackerCharacter!.getImpact();
    }

    return totalImpacts;
  }

  /// Calculate the target value for impact hits
  int calculateImpactTarget(CombatInput input) {
    // For impact attacks, use the clash value
    int hitTarget = input.attacker.clash;

    // Apply Glorious Charge bonus when charging
    if (input.isCharge && input.hasAttackerRule('glorious charge')) {
      hitTarget += 1;
    }

    return hitTarget;
  }

  /// Calculate the impact phase result
  PhaseResult calculateImpactPhase(CombatInput input) {
    if (!input.isImpact || !input.attacker.hasImpact()) {
      return PhaseResult.empty();
    }

    // Calculate total impact attacks
    final totalImpacts = calculateTotalImpacts(input);
    if (totalImpacts <= 0) {
      return PhaseResult.empty();
    }

    // Determine hit target value
    final hitTarget = calculateImpactTarget(input);

    // Create the phase result
    return createPhaseResult(totalImpacts, hitTarget);
  }
}
