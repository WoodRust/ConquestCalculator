// lib/domain/usecases/calculate_combat.dart
import 'dart:math';
import '../models/regiment.dart';
import '../models/combat_simulation.dart';

class CalculateCombat {
  final Random _random = Random();

  // Calculate expected result based on probabilities
  CombatSimulation calculateExpectedResult({
    required Regiment attacker,
    required int numAttackerStands,
    required Regiment defender,
    required int numDefenderStands,
    bool isCharge = false,
    bool isImpact = false,
    bool isFlank = false,
    bool isRear = false,
    Map<String, bool> specialRulesInEffect = const {},
  }) {
    // 1. Calculate total attacks
    int totalAttacks = _calculateTotalAttacks(
      attacker: attacker,
      numAttackerStands: numAttackerStands,
      isCharge: isCharge,
      isImpact: isImpact,
      specialRulesInEffect: specialRulesInEffect,
    );

    // 2. Calculate hit probability based on clash or impact
    int hitTarget;
    if (isImpact) {
      // For impact attacks, use the attacker's clash value
      hitTarget = attacker.clash;
    } else {
      // For clash attacks, use the base clash value
      // Also check if unit is inspired (which adds +1 to clash)
      hitTarget =
          attacker.clash + (specialRulesInEffect['inspired'] == true ? 1 : 0);
    }

    // Adjust for special rules
    if (specialRulesInEffect['cleave'] == true) {
      // Apply cleave effect (doesn't change hit target, but affects defense later)
    }

    // 3. Calculate expected hits
    DiceResult hitRoll = DiceResult.fromRoll(
      dice: totalAttacks,
      target: hitTarget,
    );

    // 4. Calculate defense roll
    int defenseTarget = max(defender.defense, defender.evasion);

    // Adjust for flanking and special rules
    if (isFlank || isRear) {
      // Flanking ignores shields - simulate by reducing defense
      if (specialRulesInEffect['shield'] == true) {
        defenseTarget = max(defenseTarget - 1, 0);
      }
    }

    DiceResult defenseRoll = DiceResult.fromRoll(
      dice: hitRoll.successes,
      target: defenseTarget,
    );

    // 5. Calculate morale/resolve roll
    int resolveTarget = defender.resolve;

    // Adjust for flanking
    if (isFlank || isRear) {
      // Units attacked from flank/rear must re-roll successful resolve tests
      // This effectively reduces their resolve
      resolveTarget =
          max(resolveTarget - 1, 0); // Simulate re-rolls by reducing target
    }

    DiceResult resolveRoll = DiceResult.fromRoll(
      dice: defenseRoll.failures,
      target: resolveTarget,
    );

    // 6. Return complete simulation
    return CombatSimulation(
      attacker: attacker,
      numAttackerStands: numAttackerStands,
      defender: defender,
      numDefenderStands: numDefenderStands,
      isCharge: isCharge,
      isImpact: isImpact,
      isFlank: isFlank,
      isRear: isRear,
      specialRulesInEffect: specialRulesInEffect,
      hitRoll: hitRoll,
      defenseRoll: defenseRoll,
      resolveRoll: resolveRoll,
    );
  }

  int _calculateTotalAttacks({
    required Regiment attacker,
    required int numAttackerStands,
    required bool isCharge,
    required bool isImpact,
    required Map<String, bool> specialRulesInEffect,
  }) {
    int totalAttacks;

    if (isImpact) {
      // For impact attacks, we need to know the Impact(X) value
      // Let's assume it's stored in specialRulesInEffect['impactValue']
      int impactValue = specialRulesInEffect['impactValue'] as int? ?? 0;
      totalAttacks = impactValue * numAttackerStands;
    } else {
      // For regular clash, use the attacks characteristic
      totalAttacks = attacker.attacks * numAttackerStands;

      // Add support attacks from unengaged stands
      // In a simplified model, we can assume half of stands provide support
      int supportAttacks = (numAttackerStands / 2).floor();

      // If the unit has Support(X) special rule, adjust support attacks
      int supportValue = specialRulesInEffect['supportValue'] as int? ?? 1;
      supportAttacks *= supportValue;

      totalAttacks += supportAttacks;
    }

    // Apply special rules modifications
    if (specialRulesInEffect['flurry'] == true) {
      // Flurry allows re-rolling failed hits
      // We can simulate this by increasing the effective number of attacks
      // For a clash value of 3, re-rolling failures increases success by roughly 50%
      double flurryMultiplier = 1 + ((6 - attacker.clash) / 6);
      totalAttacks = (totalAttacks * flurryMultiplier).round();
    }

    return totalAttacks;
  }
}
