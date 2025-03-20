// lib/domain/usecases/calculate_combat.dart
import 'dart:math' as math;
import '../models/regiment.dart';
import '../models/combat_simulation.dart';
import '../models/probability_distribution.dart';

/// Main class for calculating combat results
class CalculateCombat {
  final math.Random _random = math.Random();
  final ProbabilityCalculator _probabilityCalculator = ProbabilityCalculator();

  /// Calculates the expected result of a combat between two regiments
  CombatSimulation calculateExpectedResult({
    required Regiment attacker,
    required int numAttackerStands,
    Regiment? attackerCharacter,
    required Regiment defender,
    required int numDefenderStands,
    Regiment? defenderCharacter,
    bool isCharge = false,
    bool isImpact = false,
    bool isFlank = false,
    bool isRear = false,
    bool isVolley = false,
    bool isWithinEffectiveRange = false,
    Map<String, bool> specialRulesInEffect = const {},
    Map<String, int> impactValues = const {},
  }) {
    // Create combat context with all parameters
    final context = CombatContext(
      attacker: attacker,
      numAttackerStands: numAttackerStands,
      attackerCharacter: attackerCharacter,
      defender: defender,
      numDefenderStands: numDefenderStands,
      defenderCharacter: defenderCharacter,
      isCharge: isCharge,
      isImpact: isImpact,
      isFlank: isFlank,
      isRear: isRear,
      isVolley: isVolley,
      isWithinEffectiveRange: isWithinEffectiveRange,
      specialRulesInEffect: Map<String, bool>.from(specialRulesInEffect),
      impactValues: Map<String, int>.from(impactValues),
    );

    // Calculate effective stand counts with characters
    context.effectiveAttackerStands =
        context.numAttackerStands + (context.attackerCharacter != null ? 1 : 0);
    context.effectiveDefenderStands =
        context.numDefenderStands + (context.defenderCharacter != null ? 1 : 0);

    // Calculate breaking threshold based on effective stand count
    context.standsToBreak = (context.effectiveDefenderStands / 2).ceil();

    // Create combat processor based on combat type
    final CombatProcessor processor = _createCombatProcessor(context);

    // Process the combat and get distributions
    final CombatDistributions distributions = processor.processCombat();

    // Create DiceResult instances for backward compatibility
    DiceResult hitRoll = DiceResult(
      successes: distributions.regularHitDistribution.mean.round(),
      failures: distributions.regularHitDistribution.diceCount -
          distributions.regularHitDistribution.mean.round(),
      total: distributions.regularHitDistribution.diceCount,
    );

    DiceResult defenseRoll = DiceResult(
      successes: (distributions.regularHitDistribution.mean -
              distributions.regularWoundDistribution.mean)
          .round(),
      failures: distributions.regularWoundDistribution.mean.round(),
      total: distributions.regularHitDistribution.mean.round(),
    );

    DiceResult resolveRoll = DiceResult(
      successes: (distributions.regularWoundDistribution.mean -
              distributions.regularResolveDistribution.mean)
          .round(),
      failures: distributions.regularResolveDistribution.mean.round(),
      total: distributions.regularWoundDistribution.mean.round(),
    );

    // Return the complete combat simulation
    return CombatSimulation(
      attacker: context.attacker,
      numAttackerStands: context.effectiveAttackerStands,
      defender: context.defender,
      numDefenderStands: context.effectiveDefenderStands,
      isCharge: context.isCharge,
      isImpact: context.isImpact,
      isFlank: context.isFlank,
      isRear: context.isRear,
      isVolley: context.isVolley,
      isWithinEffectiveRange: context.isWithinEffectiveRange,
      specialRulesInEffect: context.specialRulesInEffect,
      // For backward compatibility
      hitRoll: hitRoll,
      defenseRoll: defenseRoll,
      resolveRoll: resolveRoll,
      // Enhanced distributions
      hitDistribution: distributions.regularHitDistribution,
      woundDistribution: distributions.regularWoundDistribution,
      resolveDistribution: distributions.regularResolveDistribution,
      totalDamageDistribution: distributions.totalDamageDistribution,
      standsToBreak: context.standsToBreak,
    );
  }

  /// Creates the appropriate combat processor based on the combat context
  CombatProcessor _createCombatProcessor(CombatContext context) {
    if (context.isVolley) {
      return RangedCombatProcessor(context, _probabilityCalculator);
    } else {
      return MeleeCombatProcessor(context, _probabilityCalculator);
    }
  }
}

/// Holds all the context information for a combat calculation
class CombatContext {
  final Regiment attacker;
  final int numAttackerStands;
  final Regiment? attackerCharacter;
  final Regiment defender;
  final int numDefenderStands;
  final Regiment? defenderCharacter;
  final bool isCharge;
  final bool isImpact;
  final bool isFlank;
  final bool isRear;
  final bool isVolley;
  final bool isWithinEffectiveRange;
  final Map<String, bool> specialRulesInEffect;
  final Map<String, int> impactValues;

  // Calculated values
  int effectiveAttackerStands = 0;
  int effectiveDefenderStands = 0;
  int standsToBreak = 0;

  CombatContext({
    required this.attacker,
    required this.numAttackerStands,
    this.attackerCharacter,
    required this.defender,
    required this.numDefenderStands,
    this.defenderCharacter,
    required this.isCharge,
    required this.isImpact,
    required this.isFlank,
    required this.isRear,
    required this.isVolley,
    required this.isWithinEffectiveRange,
    required this.specialRulesInEffect,
    required this.impactValues,
  });
}

/// Holds all the probability distributions for a combat calculation
class CombatDistributions {
  final ProbabilityDistribution? impactHitDistribution;
  final ProbabilityDistribution? impactWoundDistribution;
  final ProbabilityDistribution? impactResolveDistribution;
  final ProbabilityDistribution? impactTotalDamageDistribution;
  final ProbabilityDistribution regularHitDistribution;
  final ProbabilityDistribution regularWoundDistribution;
  final ProbabilityDistribution regularResolveDistribution;
  final ProbabilityDistribution regularTotalDamageDistribution;
  final ProbabilityDistribution totalDamageDistribution;

  CombatDistributions({
    this.impactHitDistribution,
    this.impactWoundDistribution,
    this.impactResolveDistribution,
    this.impactTotalDamageDistribution,
    required this.regularHitDistribution,
    required this.regularWoundDistribution,
    required this.regularResolveDistribution,
    required this.regularTotalDamageDistribution,
    required this.totalDamageDistribution,
  });
}

/// Abstract base class for combat processors
abstract class CombatProcessor {
  final CombatContext context;
  final ProbabilityCalculator probabilityCalculator;

  CombatProcessor(this.context, this.probabilityCalculator);

  /// Process the combat and return all probability distributions
  CombatDistributions processCombat();

  /// Calculate the defense value with all applicable modifiers
  int calculateEffectiveDefense({
    required Regiment defender,
    required Regiment attacker,
    bool isImpact = false,
    bool isVolley = false,
    bool isFlank = false,
    bool isRear = false,
    required Map<String, bool> specialRulesInEffect,
  }) {
    int defenseTarget = math.max(defender.defense, defender.evasion);

    // Apply Shield bonus for front attacks
    bool hasShield = defender.shield ||
        defender.hasSpecialRule('shield') ||
        specialRulesInEffect['shield'] == true;

    if (!isFlank && !isRear && hasShield) {
      defenseTarget += 1;
    }

    // Apply armor piercing for volleys
    if (isVolley && attacker.hasArmorPiercing()) {
      defenseTarget =
          math.max(defenseTarget - attacker.getArmorPiercingValue(), 0);
    }
    // Apply armor piercing as a separate rule for non-volley attacks
    else if (!isVolley && specialRulesInEffect['armorPiercing'] == true) {
      int armorPiercingValue =
          specialRulesInEffect['armorPiercingValue'] as int? ??
              attacker.getArmorPiercingValue();
      defenseTarget = math.max(defenseTarget - armorPiercingValue, 0);
    }
    // Apply cleave for melee attacks
    else if (!isVolley &&
        !isImpact &&
        (attacker.getCleave() > 0 || specialRulesInEffect['cleave'] == true)) {
      int cleaveValue =
          specialRulesInEffect['cleaveValue'] as int? ?? attacker.getCleave();
      defenseTarget = math.max(defenseTarget - cleaveValue, 0);
    }
    // Apply brutal impact for impact attacks
    else if (isImpact &&
        (attacker.getBrutalImpact() > 0 ||
            specialRulesInEffect['brutalImpact'] == true)) {
      int brutalImpactValue =
          specialRulesInEffect['brutalImpactValue'] as int? ??
              attacker.getBrutalImpact();
      defenseTarget = math.max(defenseTarget - brutalImpactValue, 0);
    }

    return defenseTarget;
  }

  /// Calculate the resolve value with all applicable modifiers
  int calculateEffectiveResolve({
    required Regiment defender,
    bool isFlank = false,
    bool isRear = false,
    required Map<String, bool> specialRulesInEffect,
  }) {
    int resolveTarget = defender.getResolve();

    // Check for Animate Vessel (auto-pass resolve tests)
    bool hasAnimateVessel = defender.hasSpecialRule('animate vessel');
    if (hasAnimateVessel) {
      return 6; // Will always pass resolve tests
    }

    // Adjust for flank/rear attacks (re-roll successful tests)
    if (isFlank || isRear) {
      // Units attacked from flank/rear must re-roll successful resolve tests
      // Simulate re-rolls by reducing the target
      resolveTarget = math.max(resolveTarget - 1, 0);
    }

    return resolveTarget;
  }

  /// Calculate wound distribution based on hits and defense
  ProbabilityDistribution calculateWoundDistribution(
    ProbabilityDistribution hitDistribution,
    int defenseTarget,
  ) {
    // For defense roll failures, we need to roll higher than the defense target
    // E.g., if defense is 2, rolls of 3, 4, 5, 6 are failures
    int failureTarget = 6 - defenseTarget;

    // Create binomial distribution for direct wounds
    return probabilityCalculator.calculateBinomialDistribution(
      dice: hitDistribution.mean.round(),
      targetValue: failureTarget,
    );
  }

  /// Calculate resolve distribution based on wounds and resolve
  ProbabilityDistribution calculateResolveDistribution(
    ProbabilityDistribution woundDistribution,
    int resolveTarget,
    int indomitableValue,
  ) {
    // For resolve tests failures, we need to roll higher than the resolve target
    // E.g., if resolve is 3, rolls of 4, 5, 6 are failures
    int failureTarget = 6 - resolveTarget;

    // Create binomial distribution for resolve failures
    ProbabilityDistribution resolveDistribution =
        probabilityCalculator.calculateBinomialDistribution(
      dice: woundDistribution.mean.round(),
      targetValue: failureTarget,
    );

    // Apply Indomitable effect if present
    if (indomitableValue > 0) {
      // This is a simple approximation - we subtract indomitable from the mean
      double adjustedMean =
          math.max(0.0, resolveDistribution.mean - indomitableValue);

      // Create a new binomial distribution with appropriate mean
      if (adjustedMean > 0) {
        // Calculate probability that would give this adjusted mean
        double p = adjustedMean / woundDistribution.mean.round();
        if (p > 0 && p < 1) {
          int adjustedTarget = (6 * p).round();
          adjustedTarget = math.min(math.max(adjustedTarget, 0), 6);

          resolveDistribution =
              probabilityCalculator.calculateBinomialDistribution(
            dice: woundDistribution.mean.round(),
            targetValue: adjustedTarget,
          );
        }
      } else {
        // If indomitable would reduce to 0, create a distribution with just a 0
        resolveDistribution = ProbabilityDistribution(
          probabilities: [1.0], // 100% chance of 0 wounds
          mean: 0.0,
          standardDeviation: 0.0,
          diceCount: woundDistribution.mean.round(),
          targetValue: failureTarget,
        );
      }
    }

    return resolveDistribution;
  }

  /// Calculate total damage distribution (direct wounds + morale wounds)
  ProbabilityDistribution calculateTotalDamageDistribution(
    ProbabilityDistribution woundDistribution,
    ProbabilityDistribution resolveDistribution,
    int totalAttacks,
  ) {
    // Calculate a reasonable maximum for the total damage distribution
    int reasonableMaxOutcome = totalAttacks * 2 + 5;

    // Ensure we capture at least the mean + 3 standard deviations of both distributions
    int statisticalMax = (woundDistribution.mean +
            resolveDistribution.mean +
            3 *
                (woundDistribution.standardDeviation +
                    resolveDistribution.standardDeviation))
        .ceil();

    // Use the smaller of our calculated max and statistical max, but ensure it's at least 10
    int maxOutcome =
        math.max(10, math.min(reasonableMaxOutcome, statisticalMax));

    return probabilityCalculator.combineProbabilityDistributions(
      woundDistribution,
      resolveDistribution,
      maxOutcome: maxOutcome,
    );
  }
}

/// Processor for melee combat
class MeleeCombatProcessor extends CombatProcessor {
  MeleeCombatProcessor(
      CombatContext context, ProbabilityCalculator probabilityCalculator)
      : super(context, probabilityCalculator);

  @override
  CombatDistributions processCombat() {
    // Variables to store distributions
    ProbabilityDistribution? impactHitDistribution;
    ProbabilityDistribution? impactWoundDistribution;
    ProbabilityDistribution? impactResolveDistribution;
    ProbabilityDistribution? impactTotalDamageDistribution;

    // Process impact phase if applicable
    if (context.isImpact && context.attacker.hasImpact()) {
      // Handle impact attack phase
      impactHitDistribution = _calculateImpactHitDistribution();

      // Calculate defense roll distribution for impact hits
      impactWoundDistribution = calculateWoundDistribution(
        impactHitDistribution,
        calculateEffectiveDefense(
          defender: context.defender,
          attacker: context.attacker,
          isImpact: true,
          isFlank: context.isFlank,
          isRear: context.isRear,
          specialRulesInEffect: context.specialRulesInEffect,
        ),
      );

      // Calculate resolve test distribution for impact wounds
      impactResolveDistribution = calculateResolveDistribution(
        impactWoundDistribution,
        calculateEffectiveResolve(
          defender: context.defender,
          isFlank: context.isFlank,
          isRear: context.isRear,
          specialRulesInEffect: context.specialRulesInEffect,
        ),
        context.defender.getIndomitable(),
      );

      // Calculate total damage from impact phase
      impactTotalDamageDistribution = calculateTotalDamageDistribution(
        impactWoundDistribution,
        impactResolveDistribution,
        _calculateTotalImpacts(),
      );
    }

    // Process regular melee phase
    ProbabilityDistribution regularHitDistribution =
        _calculateRegularHitDistribution();

    // Calculate defense roll distribution for regular hits
    ProbabilityDistribution regularWoundDistribution =
        calculateWoundDistribution(
      regularHitDistribution,
      calculateEffectiveDefense(
        defender: context.defender,
        attacker: context.attacker,
        isImpact: false,
        isFlank: context.isFlank,
        isRear: context.isRear,
        specialRulesInEffect: context.specialRulesInEffect,
      ),
    );

    // Calculate resolve test distribution for regular wounds
    ProbabilityDistribution regularResolveDistribution =
        calculateResolveDistribution(
      regularWoundDistribution,
      calculateEffectiveResolve(
        defender: context.defender,
        isFlank: context.isFlank,
        isRear: context.isRear,
        specialRulesInEffect: context.specialRulesInEffect,
      ),
      context.defender.getIndomitable(),
    );

    // Calculate total damage from regular attack phase
    ProbabilityDistribution regularTotalDamageDistribution =
        calculateTotalDamageDistribution(
      regularWoundDistribution,
      regularResolveDistribution,
      _calculateTotalAttacks(),
    );

    // Combine both phases for the total damage distribution
    ProbabilityDistribution totalDamageDistribution;
    if (impactTotalDamageDistribution != null) {
      // Combine impact and regular damage distributions
      totalDamageDistribution =
          probabilityCalculator.combineProbabilityDistributions(
        impactTotalDamageDistribution,
        regularTotalDamageDistribution,
      );
    } else {
      // Just use regular damage if no impact phase
      totalDamageDistribution = regularTotalDamageDistribution;
    }

    return CombatDistributions(
      impactHitDistribution: impactHitDistribution,
      impactWoundDistribution: impactWoundDistribution,
      impactResolveDistribution: impactResolveDistribution,
      impactTotalDamageDistribution: impactTotalDamageDistribution,
      regularHitDistribution: regularHitDistribution,
      regularWoundDistribution: regularWoundDistribution,
      regularResolveDistribution: regularResolveDistribution,
      regularTotalDamageDistribution: regularTotalDamageDistribution,
      totalDamageDistribution: totalDamageDistribution,
    );
  }

  /// Calculate the hit distribution for impact attacks
  ProbabilityDistribution _calculateImpactHitDistribution() {
    // Get total impact attacks
    int totalImpacts = _calculateTotalImpacts();

    // Get base hit target (clash value for impacts)
    int hitTarget = context.attacker.clash;

    // Apply Glorious Charge bonus when charging
    if (context.isCharge &&
        context.attacker.hasSpecialRule('glorious charge')) {
      hitTarget += 1;
    }

    // Calculate binomial distribution for hits
    return probabilityCalculator.calculateBinomialDistribution(
      dice: totalImpacts,
      targetValue: hitTarget,
    );
  }

  /// Calculate total impact attacks
  int _calculateTotalImpacts() {
    // Get the impact value
    int impactValue = context.attacker.getImpact();

    // Calculate total impact attacks: impact value × number of stands
    int totalImpacts = impactValue * context.numAttackerStands;

    // Add character impact attacks if present
    if (context.attackerCharacter != null &&
        context.attackerCharacter!.hasImpact()) {
      totalImpacts += context.attackerCharacter!.getImpact();
    }

    return totalImpacts;
  }

  /// Calculate hit distribution for regular melee attacks
  ProbabilityDistribution _calculateRegularHitDistribution() {
    // Calculate total attacks
    int totalAttacks = _calculateTotalAttacks();

    // Get base hit target (clash value)
    int hitTarget = context.attacker.clash;

    // Apply Inspired bonus to Clash
    if (context.specialRulesInEffect['inspired'] == true) {
      hitTarget += 1;

      // If Inspired would raise Clash to 5+, use re-roll instead
      if (hitTarget >= 5) {
        hitTarget = context.attacker.clash; // Reset to base value
        context.specialRulesInEffect['inspiredReroll'] = true;
      }
    }

    // Apply Shock bonus when charging
    if (context.isCharge && context.attacker.hasSpecialRule('shock')) {
      hitTarget += 1;
    }

    // Check for reroll abilities
    bool hasRerolls = context.specialRulesInEffect['flurry'] == true ||
        context.specialRulesInEffect['inspiredReroll'] == true ||
        (context.attacker.hasSpecialRule('opportunists') &&
            (context.isFlank || context.isRear));

    if (hasRerolls) {
      // For rerolls, we use a special calculation that accounts for rerolling failures
      return probabilityCalculator.calculateDistributionWithRerolls(
        dice: totalAttacks,
        target: hitTarget,
        rerollFails: true,
      );
    } else {
      // Standard binomial distribution
      return probabilityCalculator.calculateBinomialDistribution(
        dice: totalAttacks,
        targetValue: hitTarget,
      );
    }
  }

  /// Calculate total regular attacks
  int _calculateTotalAttacks() {
    // For regular clash, use the attacks characteristic
    int regimentAttacks = context.attacker.attacks * context.numAttackerStands;

    // Add character attacks
    int characterAttacks = 0;
    if (context.attackerCharacter != null) {
      characterAttacks = context.attackerCharacter!.attacks;
    }

    // Calculate support attacks from unengaged stands
    // Simplified model: we'll assume half stands are engaged, half provide support
    int engagedStands = (context.numAttackerStands / 2).ceil();
    int supportingStands = context.numAttackerStands - engagedStands;

    // Get support value from Regiment's support field
    int supportValue = context.attacker.getSupport();

    // If no support value is defined, default to 1
    if (supportValue == 0) {
      supportValue = 1;
    }

    int supportAttacks = supportingStands * supportValue;

    // Add engaged attacks and support attacks
    int totalAttacks = (engagedStands * context.attacker.attacks) +
        supportAttacks +
        characterAttacks;

    // Add +1 attack if regiment has leader special rule
    if (context.attacker.hasSpecialRule('leader')) {
      totalAttacks += 1;
    }

    return totalAttacks;
  }
}

/// Processor for ranged combat
class RangedCombatProcessor extends CombatProcessor {
  RangedCombatProcessor(
      CombatContext context, ProbabilityCalculator probabilityCalculator)
      : super(context, probabilityCalculator);

  @override
  CombatDistributions processCombat() {
    // Calculate volley hit distribution
    ProbabilityDistribution regularHitDistribution =
        _calculateVolleryHitDistribution();

    // Calculate defense roll distribution for volley hits
    ProbabilityDistribution regularWoundDistribution =
        calculateWoundDistribution(
      regularHitDistribution,
      calculateEffectiveDefense(
        defender: context.defender,
        attacker: context.attacker,
        isVolley: true,
        isFlank: context.isFlank,
        isRear: context.isRear,
        specialRulesInEffect: context.specialRulesInEffect,
      ),
    );

    // Calculate resolve test distribution for volley wounds
    ProbabilityDistribution regularResolveDistribution =
        calculateResolveDistribution(
      regularWoundDistribution,
      calculateEffectiveResolve(
        defender: context.defender,
        isFlank: context.isFlank,
        isRear: context.isRear,
        specialRulesInEffect: context.specialRulesInEffect,
      ),
      context.defender.getIndomitable(),
    );

    // Calculate total damage from volley attack phase
    ProbabilityDistribution regularTotalDamageDistribution =
        calculateTotalDamageDistribution(
      regularWoundDistribution,
      regularResolveDistribution,
      _calculateTotalVolleys(),
    );

    // For ranged combat, there's no impact phase, so total damage is just the regular damage
    return CombatDistributions(
      regularHitDistribution: regularHitDistribution,
      regularWoundDistribution: regularWoundDistribution,
      regularResolveDistribution: regularResolveDistribution,
      regularTotalDamageDistribution: regularTotalDamageDistribution,
      totalDamageDistribution: regularTotalDamageDistribution,
    );
  }

  /// Calculate hit distribution for volley attacks
  ProbabilityDistribution _calculateVolleryHitDistribution() {
    // Calculate total volleys
    int totalVolleys = _calculateTotalVolleys();

    // Get base hit target (volley value)
    int hitTarget = context.attacker.volley;

    // Apply Aimed modifier
    if (context.specialRulesInEffect['aimed'] == true ||
        context.attacker.hasSpecialRule('deadshots')) {
      hitTarget += 1;

      // If Aimed would raise Volley to 5+, use re-roll instead
      if (hitTarget >= 5) {
        hitTarget = context.attacker.volley; // Reset to base value
        context.specialRulesInEffect['aimedReroll'] = true;
      }
    }

    // Check for reroll abilities
    bool hasRerolls = context.specialRulesInEffect['aimedReroll'] == true;

    if (hasRerolls) {
      // For rerolls, we use a special calculation that accounts for rerolling failures
      return probabilityCalculator.calculateDistributionWithRerolls(
        dice: totalVolleys,
        target: hitTarget,
        rerollFails: true,
      );
    } else {
      // Standard binomial distribution
      return probabilityCalculator.calculateBinomialDistribution(
        dice: totalVolleys,
        targetValue: hitTarget,
      );
    }
  }

  /// Calculate total volleys for ranged attacks
  int _calculateTotalVolleys() {
    if (!context.attacker.hasBarrage()) {
      return 0; // No barrage capability
    }

    int totalVolleys =
        context.attacker.getBarrage() * context.numAttackerStands;

    // Add character's barrage if present
    if (context.attackerCharacter != null &&
        context.attackerCharacter!.hasBarrage()) {
      totalVolleys += context.attackerCharacter!.getBarrage();
    }

    // Apply special rules for volleys
    if (context.attacker.hasSpecialRule('rapid volley') ||
        context.specialRulesInEffect['rapidVolley'] == true) {
      // Rapid volley grants an additional hit on rolls of 1
      // Simulate by increasing expected hits by 1/6 of the total shots
      double rapidVolleyBonus = totalVolleys * (1.0 / 6.0);
      totalVolleys += rapidVolleyBonus.round();
    }

    // Add +1 barrage if regiment has leader special rule
    if (context.attacker.hasSpecialRule('leader')) {
      totalVolleys += 1;
    }

    // Penalize for being outside effective range - halved shots
    if (!context.isWithinEffectiveRange) {
      totalVolleys = (totalVolleys * 0.5).round();
    }

    return totalVolleys;
  }
}

/// Utility class for probability calculations
class ProbabilityCalculator {
  /// Calculate a binomial probability distribution
  ProbabilityDistribution calculateBinomialDistribution({
    required int dice,
    required int targetValue,
  }) {
    return ProbabilityDistribution.binomial(
      dice: dice,
      targetValue: targetValue,
    );
  }

  /// Calculate probability distribution with rerolls
  ProbabilityDistribution calculateDistributionWithRerolls({
    required int dice,
    required int target,
    bool rerollFails = false,
    bool rerollOnes = false,
  }) {
    // Calculate base success probability
    double pSuccess = target / 6.0;

    // Calculate adjusted probability with rerolls
    double adjustedProbability;

    if (rerollFails) {
      // Probability after rerolling failures:
      // P' = P + (1-P)*P = P(2-P)
      adjustedProbability = pSuccess + (1 - pSuccess) * pSuccess;
    } else if (rerollOnes) {
      // Probability after rerolling only 1s:
      // P' = P + (1/6)*P
      adjustedProbability = pSuccess + (1 / 6) * pSuccess;
    } else {
      adjustedProbability = pSuccess;
    }

    // Use standard binomial with adjusted probability
    double mean = dice * adjustedProbability;
    double variance = dice * adjustedProbability * (1 - adjustedProbability);
    double stdDev = math.sqrt(variance);

    // Generate approximate probability distribution
    List<double> probabilities = List<double>.filled(dice + 1, 0.0);
    for (int k = 0; k <= dice; k++) {
      probabilities[k] = _binomialProbability(dice, k, adjustedProbability);
    }

    return ProbabilityDistribution(
      probabilities: probabilities,
      mean: mean,
      standardDeviation: stdDev,
      diceCount: dice,
      targetValue: target,
    );
  }

  /// Combine two probability distributions
  ProbabilityDistribution combineProbabilityDistributions(
    ProbabilityDistribution dist1,
    ProbabilityDistribution dist2, {
    int? maxOutcome,
  }) {
    return ProbabilityDistribution.combine(
      dist1,
      dist2,
      maxOutcome: maxOutcome,
    );
  }

  /// Helper for binomial probability mass function
  double _binomialProbability(int n, int k, double p) {
    if (k < 0 || k > n) return 0.0;
    if (p == 0.0) return (k == 0) ? 1.0 : 0.0;
    if (p == 1.0) return (k == n) ? 1.0 : 0.0;

    // Calculate binomial coefficient
    double coefficient = 1.0;
    for (int i = 0; i < k; i++) {
      coefficient *= (n - i) / (i + 1);
    }

    // Calculate probability
    return coefficient * math.pow(p, k) * math.pow(1 - p, n - k);
  }
}
