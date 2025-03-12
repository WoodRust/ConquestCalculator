// lib/domain/models/regiment.dart
enum RegimentType { infantry, cavalry, brute, monster, chariot }

enum RegimentClass { light, medium, heavy }

class Regiment {
  final String name;
  final String faction;
  final RegimentType type;
  final RegimentClass regimentClass;
  final int march;
  final int volley;
  final int clash;
  final int attacks;
  final int wounds;
  final int resolve;
  final int defense;
  final int evasion;
  final List<String> specialRules;
  final List<String> drawEvents;

  Regiment({
    required this.name,
    required this.faction,
    required this.type,
    required this.regimentClass,
    required this.march,
    required this.volley,
    required this.clash,
    required this.attacks,
    required this.wounds,
    required this.resolve,
    required this.defense,
    required this.evasion,
    this.specialRules = const [],
    this.drawEvents = const [],
  });
}
