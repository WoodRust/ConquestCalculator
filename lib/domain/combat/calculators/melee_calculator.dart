// lib/domain/combat/calculators/melee_calculator.dart

import '../models/combat_input.dart';
import '../models/phase_result.dart';
import 'base_combat_calculator.dart';

class MeleeCalculator extends BaseCombatCalculator {
  /// Calculate total attacks for melee combat
  int calculateTotalAttacks(CombatInput input) {
    if (input.attacker == null) return 0;

    // For a character, just use its attacks value
    if (input.attacker!.isCharacter()) {
      return input.attacker!.attacks;
    }

    // For regular regiments, calculate based on stands and support
    int baseAttacks = input.attacker!.attacks * input.attackerStands;

    // Add character attacks if present
    if (input.attackerCharacter != null) {
      baseAttacks += input.attackerCharacter!.attacks;
    }

    // Add +1 for Leader special rule if present
    if (input.hasAttackerRule('leader')) {
      baseAttacks += 1;
    }

    return baseAttacks;
  }

  /// Calculate the hit target value (including modifiers)
  int calculateHitTarget(CombatInput input) {
    if (input.attacker == null) return 0;

    // Base hit target is the clash value
    int hitTarget = input.attacker!.clash;

    // Apply Inspired bonus to Clash
    if (input.hasAttackerRule('inspired')) {
      hitTarget += 1;

      // If Inspired would raise Clash to 5+, reset and use re-roll instead
      if (hitTarget >= 5) {
        hitTarget = input.attacker!.clash;
        input.specialRulesInEffect['inspiredReroll'] = true;
      }
    }

    // Apply Shock bonus when charging
    if (input.isCharge && input.hasAttackerRule('shock')) {
      hitTarget += 1;
    }

    // Apply Glorious Charge bonus when charging
    if (input.isCharge && input.hasAttackerRule('glorious charge')) {
      hitTarget += 1;
    }

    return hitTarget;
  }

  /// Determine if attacker gets to reroll hits
  bool hasRerolls(CombatInput input) {
    // Check if any reroll-granting special rules are active
    return input.hasAttackerRule('flurry') ||
        input.specialRulesInEffect['inspiredReroll'] == true ||
        (input.hasAttackerRule('opportunists') &&
            (input.isFlank || input.isRear));
  }

  /// Calculate the complete melee phase
  PhaseResult calculateMeleePhase(CombatInput input) {
    if (input.attacker == null) {
      return PhaseResult.empty();
    }

    // Calculate total attacks
    final int totalAttacks = calculateTotalAttacks(input);

    // Calculate hit target with all modifiers
    final int hitTarget = calculateHitTarget(input);

    // Determine if attacker has rerolls
    final bool useRerolls = hasRerolls(input);

    // Use the appropriate method based on whether rerolls apply
    if (useRerolls) {
      // Using positional parameters to match the base class method signature
      return createPhaseResultWithRerolls(
        totalAttacks,
        hitTarget,
        rerollFails: true,
      );
    } else {
      // Using positional parameters to match the base class method signature
      return createPhaseResult(totalAttacks, hitTarget);
    }
  }
}
