import 'package:conquest_calculator/domain/models/probability_distribution.dart';

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
