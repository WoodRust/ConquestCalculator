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
    bool isVolley = false, // New parameter for volley attacks
    bool isWithinEffectiveRange = true, // New parameter for range
    Map<String, bool> specialRulesInEffect = const {},
    Map<String, int> impactValues = const {},
  }) {
    // 1. Calculate total attacks
    int totalAttacks;

    if (isVolley) {
      // For volley actions, use barrage value
      totalAttacks = _calculateTotalVolleys(
        attacker: attacker,
        numAttackerStands: numAttackerStands,
        isWithinEffectiveRange: isWithinEffectiveRange,
        specialRulesInEffect: specialRulesInEffect,
      );
    } else {
      // For melee actions, use existing method
      totalAttacks = _calculateTotalAttacks(
        attacker: attacker,
        numAttackerStands: numAttackerStands,
        isCharge: isCharge,
        isImpact: isImpact,
        specialRulesInEffect: specialRulesInEffect,
        impactValues: impactValues,
      );
    }

    // 2. Calculate hit probability based on action type
    int hitTarget;
    if (isVolley) {
      // For volley attacks, use the volley characteristic
      hitTarget = attacker.volley;
    } else if (isImpact) {
      // For impact attacks, use the clash value
      hitTarget = attacker.clash;
    } else {
      // For clash attacks, use the base clash value
      // Check if unit is inspired (which adds +1 to clash)
      hitTarget =
          attacker.clash + (specialRulesInEffect['inspired'] == true ? 1 : 0);
    }

    // 3. Calculate expected hits
    DiceResult hitRoll = DiceResult.fromRoll(
      dice: totalAttacks,
      target: hitTarget,
    );

    // 4. Calculate defense roll
    int defenseTarget = max(defender.defense, defender.evasion);

    // Adjust for armor piercing
    int effectiveDefense = defenseTarget;
    if (isVolley && attacker.armorPiercing) {
      effectiveDefense = max(defenseTarget - attacker.armorPiercingValue, 0);
    } else if (specialRulesInEffect['cleave'] == true) {
      // Apply cleave effect, reducing effective defense
      int cleaveValue = specialRulesInEffect['cleaveValue'] as int? ?? 1;
      effectiveDefense = max(defenseTarget - cleaveValue, 0);
    }

    // Adjust for flanking and special rules
    if (isFlank || isRear) {
      // Flanking ignores shields - simulate by reducing defense
      if (defender.hasSpecialRule('shield')) {
        effectiveDefense = max(effectiveDefense - 1, 0);
      }
    }

    DiceResult defenseRoll = DiceResult.fromRoll(
      dice: hitRoll.successes,
      target: effectiveDefense,
    );

    // 5. Calculate morale/resolve roll
    // Safely handle null resolve values
    int resolveTarget = defender.getResolve();

    // Check if unit is animate vessel or has a special rule affecting resolve
    bool hasAnimateVessel = defender.hasSpecialRule('animate vessel');

    if (hasAnimateVessel) {
      // Animate Vessel units auto-pass resolve tests
      resolveTarget = 6; // Will always succeed
    }

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
      isVolley: isVolley,
      isWithinEffectiveRange: isWithinEffectiveRange,
      specialRulesInEffect: specialRulesInEffect,
      hitRoll: hitRoll,
      defenseRoll: defenseRoll,
      resolveRoll: resolveRoll,
    );
  }

  int _calculateTotalVolleys({
    required Regiment attacker,
    required int numAttackerStands,
    required bool isWithinEffectiveRange,
    required Map<String, bool> specialRulesInEffect,
  }) {
    if (!attacker.hasBarrage()) {
      return 0; // No barrage capability
    }

    int totalVolleys = attacker.getBarrage() * numAttackerStands;

    // Apply special rules for volleys
    if (attacker.hasSpecialRule('rapid volley')) {
      // Rapid volley allows re-rolling failed hits
      double rapidVolleyMultiplier = 1 + ((6 - attacker.volley) / 6);
      totalVolleys = (totalVolleys * rapidVolleyMultiplier).round();
    }

    if (attacker.hasSpecialRule('torrential fire')) {
      // Torrential fire allows every hit to generate another attack
      double torrentialFireMultiplier =
          1 + (attacker.volley / 6); // Approximate effect
      totalVolleys = (totalVolleys * torrentialFireMultiplier).round();
    }

    // Penalize for being outside effective range
    if (!isWithinEffectiveRange) {
      totalVolleys = (totalVolleys * 0.5)
          .round(); // Half effectiveness outside effective range
    }

    return totalVolleys;
  }

  int _calculateTotalAttacks({
    required Regiment attacker,
    required int numAttackerStands,
    required bool isCharge,
    required bool isImpact,
    required Map<String, bool> specialRulesInEffect,
    required Map<String, int> impactValues,
  }) {
    int totalAttacks;

    if (isImpact) {
      // For impact attacks, get the impact value
      int impactValue = impactValues['impactValue'] ?? 0;

      // Check if the regiment has Impact special rule
      for (final rule in attacker.specialRules) {
        if (rule.contains('Impact (')) {
          // Extract the impact value from the special rule
          final match = RegExp(r'Impact \((\d+)\)').firstMatch(rule);
          if (match != null && match.groupCount >= 1) {
            impactValue = int.parse(match.group(1)!);
            break;
          }
        }
      }

      totalAttacks = impactValue * numAttackerStands;
    } else {
      // For regular clash, use the attacks characteristic
      totalAttacks = attacker.attacks * numAttackerStands;

      // Add support attacks from unengaged stands
      // In a simplified model, we can assume half of stands provide support
      int supportAttacks = (numAttackerStands / 2).floor();

      // If the unit has Support(X) special rule, adjust support attacks
      int supportValue = 1;

      // Extract Support value from special rules
      for (final rule in attacker.specialRules) {
        if (rule.contains('Support (')) {
          // Extract the support value from the special rule
          final match = RegExp(r'Support \((\d+)\)').firstMatch(rule);
          if (match != null && match.groupCount >= 1) {
            supportValue = int.parse(match.group(1)!);
            break;
          }
        }
      }

      supportAttacks *= supportValue;
      totalAttacks += supportAttacks;
    }

    // Apply special rules modifications
    if (attacker.hasSpecialRule('flurry')) {
      // Flurry allows re-rolling failed hits
      // We can simulate this by increasing the effective number of attacks
      // For a clash value of 3, re-rolling failures increases success by roughly 50%
      double flurryMultiplier = 1 + ((6 - attacker.clash) / 6);
      totalAttacks = (totalAttacks * flurryMultiplier).round();
    }

    return totalAttacks;
  }
}
