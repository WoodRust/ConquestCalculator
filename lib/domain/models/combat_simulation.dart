// lib/domain/models/combat_simulation.dart
import 'package:conquest_calculator/domain/models/regiment.dart';
import 'package:conquest_calculator/domain/models/probability_distribution.dart';

/// Represents the outcome of a simple dice roll with success and failure count
class DiceResult {
  final int successes;
  final int failures;
  final int total;

  DiceResult({
    required this.successes,
    required this.failures,
    required this.total,
  });

  factory DiceResult.fromRoll({required int dice, required int target}) {
    // Calculate expected successes for a given number of dice and target
    final double successRate = target / 6.0;
    final int expectedSuccesses = (dice * successRate).round();
    return DiceResult(
      successes: expectedSuccesses,
      failures: dice - expectedSuccesses,
      total: dice,
    );
  }
}

/// Represents a full combat simulation with probability distributions
// Update the CombatSimulation class constructor to handle character stands properly

class CombatSimulation {
  // Attacker
  final Regiment attacker;
  final int numAttackerStands;

  // Defender
  final Regiment defender;
  final int numDefenderStands;

  // Modifiers
  final bool isCharge;
  final bool isImpact;
  final bool isFlank;
  final bool isRear;
  final bool isVolley;
  final bool isWithinEffectiveRange;
  final Map<String, bool> specialRulesInEffect;

  // Basic results (legacy)
  final DiceResult hitRoll;
  final DiceResult defenseRoll;
  final DiceResult resolveRoll;

  // Probability distributions
  final ProbabilityDistribution? hitDistribution;
  final ProbabilityDistribution? woundDistribution;
  final ProbabilityDistribution? resolveDistribution;
  final ProbabilityDistribution? totalDamageDistribution;

  // Critical thresholds
  final int standsToBreak;
  final double breakingProbability;

  CombatSimulation({
    required this.attacker,
    required this.numAttackerStands,
    required this.defender,
    required this.numDefenderStands,
    this.isCharge = false,
    this.isImpact = false,
    this.isFlank = false,
    this.isRear = false,
    this.isVolley = false,
    this.isWithinEffectiveRange = true,
    this.specialRulesInEffect = const {},
    required this.hitRoll,
    required this.defenseRoll,
    required this.resolveRoll,
    this.hitDistribution,
    this.woundDistribution,
    this.resolveDistribution,
    this.totalDamageDistribution,
    required this.standsToBreak, // Now passed in to account for character stands
  }) : breakingProbability = _calculateBreakingProbability(
            numDefenderStands,
            defender.wounds,
            defenseRoll.failures + resolveRoll.failures,
            totalDamageDistribution,
            standsToBreak); // Pass in standsToBreak

  // Helper methods to get meaningful results
  int getExpectedWounds() {
    if (totalDamageDistribution != null) {
      return totalDamageDistribution!.mean.round();
    }
    return defenseRoll.failures + resolveRoll.failures;
  }

  int getExpectedStandsLost() {
    return getExpectedWounds() ~/ defender.wounds;
  }

  bool willLikelyBreak() {
    // A regiment is likely to break if it loses half or more of its stands
    return getExpectedStandsLost() >= standsToBreak;
  }

  // Get probability of losing exactly n stands
  double getProbabilityOfLosing(int stands) {
    if (totalDamageDistribution == null) {
      return 0.0;
    }

    int minWounds = stands * defender.wounds;
    int maxWounds = minWounds + defender.wounds - 1;

    double probability = 0.0;
    for (int wounds = minWounds; wounds <= maxWounds; wounds++) {
      if (wounds < totalDamageDistribution!.probabilities.length) {
        probability += totalDamageDistribution!.probabilities[wounds];
      }
    }

    return probability;
  }

  // Get probability of losing at least n stands
  double getProbabilityOfLosingAtLeast(int stands) {
    if (totalDamageDistribution == null) {
      return 0.0;
    }

    int minWounds = stands * defender.wounds;
    return totalDamageDistribution!.getProbabilityOfExceeding(minWounds - 1);
  }

  // Calculate probability of breaking - updated to use the passed-in standsToBreak value
  static double _calculateBreakingProbability(
      int numDefenderStands,
      int woundsPerStand,
      int expectedTotalWounds,
      ProbabilityDistribution? distribution,
      int standsToBreak) {
    // Use standsToBreak value instead of calculating it
    final woundsRequired = standsToBreak * woundsPerStand;

    // Use probability distribution if available
    if (distribution != null) {
      return distribution.getProbabilityOfExceeding(woundsRequired - 1);
    }

    // Fall back to simplified calculation
    final standsLost = expectedTotalWounds ~/ woundsPerStand;
    if (standsLost >= standsToBreak) {
      return 1.0;
    } else {
      // This is simplified - real implementation would use probability distributions
      return (standsLost / standsToBreak).clamp(0.0, 1.0);
    }
  }
}
