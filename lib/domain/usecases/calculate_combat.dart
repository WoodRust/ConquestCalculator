// lib/domain/usecases/calculate_combat.dart
import 'dart:math' as math;
import '../models/regiment.dart';
import '../models/combat_simulation.dart';
import '../models/probability_distribution.dart';

class CalculateCombat {
  final math.Random _random = math.Random();

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
    // Create mutable copies of the maps to avoid modifying unmodifiable maps
    final Map<String, bool> mutableSpecialRules =
        Map<String, bool>.from(specialRulesInEffect);
    final Map<String, int> mutableImpactValues =
        Map<String, int>.from(impactValues);

    // Calculate effective stand counts with characters
    int effectiveAttackerStands =
        numAttackerStands + (attackerCharacter != null ? 1 : 0);
    int effectiveDefenderStands =
        numDefenderStands + (defenderCharacter != null ? 1 : 0);

    // Calculate breaking threshold based on effective stand count
    int standsToBreak = (effectiveDefenderStands / 2).ceil();

    // ENHANCED IMPLEMENTATION: Handle multi-phase combat properly
    // First, calculate the impact attacks phase (if applicable)
    ProbabilityDistribution? impactHitDistribution;
    ProbabilityDistribution? impactWoundDistribution;
    ProbabilityDistribution? impactResolveDistribution;
    ProbabilityDistribution? impactTotalDamageDistribution;

    if (isImpact && attacker.hasImpact()) {
      // Handle impact attack phase
      impactHitDistribution = _calculateImpactHitDistribution(
        attacker: attacker,
        numAttackerStands: numAttackerStands,
        attackerCharacter: attackerCharacter,
        isCharge: isCharge,
        specialRulesInEffect: mutableSpecialRules,
      );

      // Calculate defense roll distribution for impact hits
      impactWoundDistribution = _calculateWoundDistribution(
        impactHitDistribution,
        _calculateEffectiveDefense(
          defender: defender,
          isImpact: true,
          isFlank: isFlank,
          isRear: isRear,
          specialRulesInEffect: mutableSpecialRules,
          attacker: attacker,
        ),
      );

      // Calculate resolve test distribution for impact wounds
      impactResolveDistribution = _calculateResolveDistribution(
        impactWoundDistribution,
        _calculateEffectiveResolve(
          defender: defender,
          attacker: attacker, // Pass attacker to check for terrifying
          isFlank: isFlank,
          isRear: isRear,
          specialRulesInEffect: mutableSpecialRules,
        ),
        defender.getIndomitable(),
      );

      // Calculate total damage from impact phase
      impactTotalDamageDistribution = _calculateTotalDamageDistribution(
        impactWoundDistribution,
        impactResolveDistribution,
        _calculateTotalImpacts(
          attacker: attacker,
          numAttackerStands: numAttackerStands,
          attackerCharacter: attackerCharacter,
          specialRulesInEffect: mutableSpecialRules,
        ),
      );
    }

    // Calculate regular attack phase
    ProbabilityDistribution regularHitDistribution;
    if (isVolley) {
      // For volley actions, use barrage value
      regularHitDistribution = _calculateVolleryHitDistribution(
        attacker: attacker,
        numAttackerStands: numAttackerStands,
        attackerCharacter: attackerCharacter,
        isWithinEffectiveRange: isWithinEffectiveRange,
        specialRulesInEffect: mutableSpecialRules,
      );
    } else {
      // For clash actions, use the base clash value with potential modifier bonuses
      regularHitDistribution = _calculateRegularHitDistribution(
        attacker: attacker,
        numAttackerStands: numAttackerStands,
        attackerCharacter: attackerCharacter,
        isCharge: isCharge,
        isFlank: isFlank,
        isRear: isRear,
        specialRulesInEffect: mutableSpecialRules,
      );
    }

    // Calculate defense roll distribution for regular hits
    ProbabilityDistribution regularWoundDistribution =
        _calculateWoundDistribution(
      regularHitDistribution,
      _calculateEffectiveDefense(
        defender: defender,
        isImpact: false,
        isVolley: isVolley,
        isFlank: isFlank,
        isRear: isRear,
        specialRulesInEffect: mutableSpecialRules,
        attacker: attacker,
      ),
    );

    // Calculate resolve test distribution for regular wounds
    ProbabilityDistribution regularResolveDistribution =
        _calculateResolveDistribution(
      regularWoundDistribution,
      _calculateEffectiveResolve(
        defender: defender,
        attacker: attacker, // Pass attacker to check for terrifying
        isFlank: isFlank,
        isRear: isRear,
        specialRulesInEffect: mutableSpecialRules,
      ),
      defender.getIndomitable(),
    );

    // Calculate total damage from regular attack phase
    ProbabilityDistribution regularTotalDamageDistribution =
        _calculateTotalDamageDistribution(
      regularWoundDistribution,
      regularResolveDistribution,
      isVolley
          ? _calculateTotalVolleys(
              attacker: attacker,
              numAttackerStands: numAttackerStands,
              attackerCharacter: attackerCharacter,
              isWithinEffectiveRange: isWithinEffectiveRange,
              specialRulesInEffect: mutableSpecialRules,
            )
          : _calculateTotalAttacks(
              attacker: attacker,
              numAttackerStands: numAttackerStands,
              attackerCharacter: attackerCharacter,
              isCharge: isCharge,
              isImpact: false,
              specialRulesInEffect: mutableSpecialRules,
            ),
    );

    // ENHANCED: Combine both phases for the total damage distribution
    ProbabilityDistribution totalDamageDistribution;
    if (impactTotalDamageDistribution != null) {
      // Combine impact and regular damage distributions
      totalDamageDistribution = ProbabilityDistribution.combine(
        impactTotalDamageDistribution,
        regularTotalDamageDistribution,
      );
    } else {
      // Just use regular damage if no impact phase
      totalDamageDistribution = regularTotalDamageDistribution;
    }

    // Create DiceResult instances for backward compatibility
    DiceResult hitRoll = DiceResult(
      successes: regularHitDistribution.mean.round(),
      failures: regularHitDistribution.diceCount -
          regularHitDistribution.mean.round(),
      total: regularHitDistribution.diceCount,
    );

    DiceResult defenseRoll = DiceResult(
      successes:
          (regularHitDistribution.mean - regularWoundDistribution.mean).round(),
      failures: regularWoundDistribution.mean.round(),
      total: regularHitDistribution.mean.round(),
    );

    DiceResult resolveRoll = DiceResult(
      successes:
          (regularWoundDistribution.mean - regularResolveDistribution.mean)
              .round(),
      failures: regularResolveDistribution.mean.round(),
      total: regularWoundDistribution.mean.round(),
    );

    // Return the complete combat simulation
    return CombatSimulation(
      attacker: attacker,
      numAttackerStands: effectiveAttackerStands,
      defender: defender,
      numDefenderStands: effectiveDefenderStands,
      isCharge: isCharge,
      isImpact: isImpact,
      isFlank: isFlank,
      isRear: isRear,
      isVolley: isVolley,
      isWithinEffectiveRange: isWithinEffectiveRange,
      specialRulesInEffect: mutableSpecialRules,
      // For backward compatibility
      hitRoll: hitRoll,
      defenseRoll: defenseRoll,
      resolveRoll: resolveRoll,
      // Enhanced distributions
      hitDistribution: regularHitDistribution,
      woundDistribution: regularWoundDistribution,
      resolveDistribution: regularResolveDistribution,
      totalDamageDistribution: totalDamageDistribution, // Combined distribution
      standsToBreak: standsToBreak,
    );
  }

  // IMPACT ATTACK PHASE HELPERS

  // Calculate the hit distribution for impact attacks
  ProbabilityDistribution _calculateImpactHitDistribution({
    required Regiment attacker,
    required int numAttackerStands,
    Regiment? attackerCharacter,
    required bool isCharge,
    required Map<String, bool> specialRulesInEffect,
  }) {
    // Get total impact attacks
    int totalImpacts = _calculateTotalImpacts(
      attacker: attacker,
      numAttackerStands: numAttackerStands,
      attackerCharacter: attackerCharacter,
      specialRulesInEffect: specialRulesInEffect,
    );

    // Get base hit target (clash value for impacts)
    int hitTarget = attacker.clash;

    // Apply Glorious Charge bonus when charging
    if (isCharge && attacker.hasSpecialRule('glorious charge')) {
      hitTarget += 1;
    }

    // Calculate binomial distribution for hits
    return ProbabilityDistribution.binomial(
      dice: totalImpacts,
      targetValue: hitTarget,
    );
  }

  // Calculate total impact attacks
  int _calculateTotalImpacts({
    required Regiment attacker,
    required int numAttackerStands,
    Regiment? attackerCharacter,
    required Map<String, bool> specialRulesInEffect,
  }) {
    // Get the impact value
    int impactValue = attacker.getImpact();

    // Calculate total impact attacks: impact value × number of stands
    int totalImpacts = impactValue * numAttackerStands;

    // Add character impact attacks if present
    if (attackerCharacter != null && attackerCharacter.hasImpact()) {
      totalImpacts += attackerCharacter.getImpact();
    }

    return totalImpacts;
  }

  // REGULAR ATTACK PHASE HELPERS

  // Calculate hit distribution for regular melee attacks
  ProbabilityDistribution _calculateRegularHitDistribution({
    required Regiment attacker,
    required int numAttackerStands,
    Regiment? attackerCharacter,
    required bool isCharge,
    required bool isFlank,
    required bool isRear,
    required Map<String, bool> specialRulesInEffect,
  }) {
    // Calculate total attacks
    int totalAttacks = _calculateTotalAttacks(
      attacker: attacker,
      numAttackerStands: numAttackerStands,
      attackerCharacter: attackerCharacter,
      isCharge: isCharge,
      isImpact: false,
      specialRulesInEffect: specialRulesInEffect,
    );

    // Get base hit target (clash value)
    int hitTarget = attacker.clash;

    // Apply Inspired bonus to Clash
    if (specialRulesInEffect['inspired'] == true) {
      hitTarget += 1;

      // If Inspired would raise Clash to 5+, use re-roll instead
      if (hitTarget >= 5) {
        hitTarget = attacker.clash; // Reset to base value
        specialRulesInEffect['inspiredReroll'] = true;
      }
    }

    // Apply Shock bonus when charging
    if (isCharge && attacker.hasSpecialRule('shock')) {
      hitTarget += 1;
    }

    // Check for reroll abilities
    bool hasRerolls = specialRulesInEffect['flurry'] == true ||
        specialRulesInEffect['inspiredReroll'] == true ||
        (attacker.hasSpecialRule('opportunists') && (isFlank || isRear));

    if (hasRerolls) {
      // For rerolls, we use a special calculation that accounts for rerolling failures
      return _calculateDistributionWithRerolls(
        dice: totalAttacks,
        target: hitTarget,
        rerollFails: true,
      );
    } else {
      // Standard binomial distribution
      return ProbabilityDistribution.binomial(
        dice: totalAttacks,
        targetValue: hitTarget,
      );
    }
  }

  // Calculate hit distribution for volley attacks
  ProbabilityDistribution _calculateVolleryHitDistribution({
    required Regiment attacker,
    required int numAttackerStands,
    Regiment? attackerCharacter,
    required bool isWithinEffectiveRange,
    required Map<String, bool> specialRulesInEffect,
  }) {
    // Calculate total volleys
    int totalVolleys = _calculateTotalVolleys(
      attacker: attacker,
      numAttackerStands: numAttackerStands,
      attackerCharacter: attackerCharacter,
      isWithinEffectiveRange: isWithinEffectiveRange,
      specialRulesInEffect: specialRulesInEffect,
    );

    // Get base hit target (volley value)
    int hitTarget = attacker.volley;

    // Apply Aimed modifier
    if (specialRulesInEffect['aimed'] == true ||
        attacker.hasSpecialRule('deadshots')) {
      hitTarget += 1;

      // If Aimed would raise Volley to 5+, use re-roll instead
      if (hitTarget >= 5) {
        hitTarget = attacker.volley; // Reset to base value
        specialRulesInEffect['aimedReroll'] = true;
      }
    }

    // Check for reroll abilities
    bool hasRerolls = specialRulesInEffect['aimedReroll'] == true;

    if (hasRerolls) {
      // For rerolls, we use a special calculation that accounts for rerolling failures
      return _calculateDistributionWithRerolls(
        dice: totalVolleys,
        target: hitTarget,
        rerollFails: true,
      );
    } else {
      // Standard binomial distribution
      return ProbabilityDistribution.binomial(
        dice: totalVolleys,
        targetValue: hitTarget,
      );
    }
  }

  // Calculate total regular attacks
  int _calculateTotalAttacks({
    required Regiment attacker,
    required int numAttackerStands,
    Regiment? attackerCharacter,
    required bool isCharge,
    required bool isImpact,
    required Map<String, bool> specialRulesInEffect,
    Map<String, int> specialRuleValues = const {},
  }) {
    int totalAttacks;

    // For regular clash, use the attacks characteristic
    int regimentAttacks = attacker.attacks * numAttackerStands;

    // Add character attacks
    int characterAttacks = 0;
    if (attackerCharacter != null) {
      characterAttacks = attackerCharacter.attacks;
    }

    // Calculate support attacks from unengaged stands
    // Simplified model: we'll assume half stands are engaged, half provide support
    int engagedStands = (numAttackerStands / 2).ceil();
    int supportingStands = numAttackerStands - engagedStands;

    // Get support value from Regiment's support field
    int supportValue = attacker.getSupport();

    // If no support value is defined, default to 1
    if (supportValue == 0) {
      supportValue = 1;
    }

    int supportAttacks = supportingStands * supportValue;

    // Add engaged attacks and support attacks
    totalAttacks =
        (engagedStands * attacker.attacks) + supportAttacks + characterAttacks;

    // Add +1 attack if regiment has leader special rule
    if (attacker.hasSpecialRule('leader')) {
      totalAttacks += 1;
    }

    return totalAttacks;
  }

  // Calculate total volleys for ranged attacks
  int _calculateTotalVolleys({
    required Regiment attacker,
    required int numAttackerStands,
    Regiment? attackerCharacter,
    required bool isWithinEffectiveRange,
    required Map<String, bool> specialRulesInEffect,
  }) {
    if (!attacker.hasBarrage()) {
      return 0; // No barrage capability
    }

    int totalVolleys = attacker.getBarrage() * numAttackerStands;

    // Add character's barrage if present
    if (attackerCharacter != null && attackerCharacter.hasBarrage()) {
      totalVolleys += attackerCharacter.getBarrage();
    }

    // Apply special rules for volleys
    if (attacker.hasSpecialRule('rapid volley') ||
        specialRulesInEffect['rapidVolley'] == true) {
      // Rapid volley grants an additional hit on rolls of 1
      // Simulate by increasing expected hits by 1/6 of the total shots
      double rapidVolleyBonus = totalVolleys * (1.0 / 6.0);
      totalVolleys += rapidVolleyBonus.round();
    }

    // Add +1 barrage if regiment has leader special rule
    if (attacker.hasSpecialRule('leader')) {
      totalVolleys += 1;
    }

    // Penalize for being outside effective range - halved shots
    if (!isWithinEffectiveRange) {
      totalVolleys = (totalVolleys * 0.5).round();
    }

    return totalVolleys;
  }

  // DEFENSE CALCULATIONS

  // Calculate effective defense value with all modifiers
  int _calculateEffectiveDefense({
    required Regiment defender,
    bool isImpact = false,
    bool isVolley = false,
    bool isFlank = false,
    bool isRear = false,
    required Map<String, bool> specialRulesInEffect,
    required Regiment attacker,
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

  // Updated to include terrifying and fearless special rule interactions
  int _calculateEffectiveResolve({
    required Regiment defender,
    required Regiment attacker, // Now required to check for terrifying
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

    // Check if defender has Fearless which negates Terrifying
    bool isFearless = defender.hasSpecialRule('fearless');

    // Apply Terrifying effect if attacker has it and defender isn't Fearless
    if (!isFearless) {
      int terrifyingValue = attacker.getTerrifying();
      if (terrifyingValue > 0) {
        // Reduce resolve by terrifying value
        resolveTarget = math.max(resolveTarget - terrifyingValue, 0);
      }
    }

    // Adjust for flank/rear attacks (re-roll successful tests)
    if (isFlank || isRear) {
      // Units attacked from flank/rear must re-roll successful resolve tests
      // Simulate re-rolls by reducing the target
      resolveTarget = math.max(resolveTarget - 1, 0);
    }

    return resolveTarget;
  }

  // Calculate wound distribution based on hits and defense
  ProbabilityDistribution _calculateWoundDistribution(
    ProbabilityDistribution hitDistribution,
    int defenseTarget,
  ) {
    // For defense roll failures, we need to roll higher than the defense target
    // E.g., if defense is 2, rolls of 3, 4, 5, 6 are failures
    int failureTarget = 6 - defenseTarget;

    // Create binomial distribution for direct wounds
    return ProbabilityDistribution.binomial(
      dice: hitDistribution.mean.round(),
      targetValue: failureTarget,
    );
  }

  // Calculate resolve distribution based on wounds and resolve
  ProbabilityDistribution _calculateResolveDistribution(
    ProbabilityDistribution woundDistribution,
    int resolveTarget,
    int indomitableValue,
  ) {
    // For resolve tests failures, we need to roll higher than the resolve target
    // E.g., if resolve is 3, rolls of 4, 5, 6 are failures
    // IMPORTANT: In Conquest, a roll of 1 is always a success for morale tests
    // So even if resolveTarget is 0, rolls of 1 will still be successes
    int failureTarget = 6 - resolveTarget;

    // Adjust for the "1 always succeeds" rule by ensuring we don't have a 100% failure rate
    // If resolveTarget is 0, we should have 1/6 success rate (only on rolls of 1)
    double successProbability = math.max(resolveTarget / 6.0, 1.0 / 6.0);
    double failureProbability = 1.0 - successProbability;

    // Create binomial distribution for resolve failures with adjusted probability
    ProbabilityDistribution resolveDistribution = ProbabilityDistribution(
      probabilities: _createBinomialProbabilities(
          woundDistribution.mean.round(), failureProbability),
      mean: woundDistribution.mean.round() * failureProbability,
      standardDeviation: math.sqrt(woundDistribution.mean.round() *
          failureProbability *
          (1 - failureProbability)),
      diceCount: woundDistribution.mean.round(),
      targetValue: failureTarget,
    );

    // Apply Indomitable effect if present
    if (indomitableValue > 0) {
      // This is a simple approximation - we subtract indomitable from the mean
      double adjustedMean =
          math.max(0.0, resolveDistribution.mean - indomitableValue);

      // Create a new distribution with appropriate mean
      if (adjustedMean > 0) {
        // Calculate probability that would give this adjusted mean
        double p = adjustedMean / woundDistribution.mean.round();
        if (p > 0 && p < 1) {
          resolveDistribution = ProbabilityDistribution(
            probabilities:
                _createBinomialProbabilities(woundDistribution.mean.round(), p),
            mean: adjustedMean,
            standardDeviation:
                math.sqrt(woundDistribution.mean.round() * p * (1 - p)),
            diceCount: woundDistribution.mean.round(),
            targetValue: failureTarget,
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

  // Calculate total damage distribution (direct wounds + morale wounds)
  ProbabilityDistribution _calculateTotalDamageDistribution(
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

    return ProbabilityDistribution.combine(
      woundDistribution,
      resolveDistribution,
      maxOutcome: maxOutcome,
    );
  }

  // Calculate probability distribution with rerolls
  ProbabilityDistribution _calculateDistributionWithRerolls({
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

  // Helper method to create binomial probability distribution
  List<double> _createBinomialProbabilities(int n, double p) {
    List<double> probabilities = List<double>.filled(n + 1, 0.0);
    for (int k = 0; k <= n; k++) {
      probabilities[k] = _binomialProbability(n, k, p);
    }
    return probabilities;
  }

  // Helper for binomial probability mass function
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
