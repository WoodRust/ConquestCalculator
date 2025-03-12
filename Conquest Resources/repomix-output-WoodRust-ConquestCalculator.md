This file is a merged representation of a subset of the codebase, containing specifically included files and files not matching ignore patterns, combined into a single document by Repomix. The content has been processed where line numbers have been added, security check has been disabled.

# File Summary

## Purpose
This file contains a packed representation of the entire repository's contents.
It is designed to be easily consumable by AI systems for analysis, code review,
or other automated processes.

## File Format
The content is organized as follows:
1. This summary section
2. Repository information
3. Directory structure
4. Multiple file entries, each consisting of:
  a. A header with the file path (## File: path/to/file)
  b. The full contents of the file in a code block

## Usage Guidelines
- This file should be treated as read-only. Any changes should be made to the
  original repository files, not this packed version.
- When processing this file, use the file path to distinguish
  between different files in the repository.
- Be aware that this file may contain sensitive information. Handle it with
  the same level of security as you would the original repository.

## Notes
- Some files may have been excluded based on .gitignore rules and Repomix's configuration
- Binary files are not included in this packed representation. Please refer to the Repository Structure section for a complete list of file paths, including binary files
- Only files matching these patterns are included: **/*.dart, **/lib/**/, **/pubspec.yaml, **/analysis_options.yaml, **/android/app/src/main/**/, **/ios/Runner/**/, **/assets/**/, **/l10n/**/, **/*.md, **/models/**/, **/providers/**/, **/blocs/**/*
- Files matching these patterns are excluded: **/.dart_tool/**/, **/build/**/, **/.idea/**/, **/.vscode/**/, **/.flutter-plugins*, **/.packages, **/generated_plugin*, **/*.g.dart, **/*.freezed.dart, **/ios/Pods/**/, **/.symlinks/**/
- Files matching patterns in .gitignore are excluded
- Files matching default ignore patterns are excluded
- Line numbers have been added to the beginning of each line
- Security check has been disabled - content may contain sensitive information

## Additional Info

# Directory Structure
```
ios/
  Runner/
    Assets.xcassets/
      LaunchImage.imageset/
        README.md
lib/
  domain/
    models/
      combat_simulation.dart
      regiment.dart
    usecases/
      calculate_combat.dart
  presentation/
    providers/
      combat_provider.dart
    screens/
      combat_calculator_screen.dart
    themes/
      app_theme.dart
    widgets/
      target_selector.dart
      wave_painter.dart
      wave_slider.dart
  main.dart
test/
  widget_test.dart
analysis_options.yaml
pubspec.yaml
README.md
```

# Files

## File: ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
```markdown
1: # Launch Screen Assets
2: 
3: You can customize the launch screen with your own desired assets by replacing the image files in this directory.
4: 
5: You can also do it by opening your Flutter project's Xcode project with `open ios/Runner.xcworkspace`, selecting `Runner/Assets.xcassets` in the Project Navigator and dropping in the desired images.
```

## File: lib/domain/models/combat_simulation.dart
```dart
 1: // lib/domain/models/combat_simulation.dart
 2: 
 3: import 'package:conquest_calculator/domain/models/regiment.dart';
 4: 
 5: class DiceResult {
 6:   final int successes;
 7:   final int failures;
 8:   final int total;
 9: 
10:   DiceResult({
11:     required this.successes,
12:     required this.failures,
13:     required this.total,
14:   });
15: 
16:   factory DiceResult.fromRoll({required int dice, required int target}) {
17:     // Calculate expected successes for a given number of dice and target
18:     final double successRate = target / 6.0;
19:     final int expectedSuccesses = (dice * successRate).round();
20:     return DiceResult(
21:       successes: expectedSuccesses,
22:       failures: dice - expectedSuccesses,
23:       total: dice,
24:     );
25:   }
26: }
27: 
28: class CombatSimulation {
29:   // Attacker
30:   final Regiment attacker;
31:   final int numAttackerStands;
32: 
33:   // Defender
34:   final Regiment defender;
35:   final int numDefenderStands;
36: 
37:   // Modifiers
38:   final bool isCharge;
39:   final bool isImpact;
40:   final bool isFlank;
41:   final bool isRear;
42:   final Map<String, bool> specialRulesInEffect;
43: 
44:   // Results
45:   final DiceResult hitRoll;
46:   final DiceResult defenseRoll;
47:   final DiceResult resolveRoll;
48: 
49:   CombatSimulation({
50:     required this.attacker,
51:     required this.numAttackerStands,
52:     required this.defender,
53:     required this.numDefenderStands,
54:     this.isCharge = false,
55:     this.isImpact = false,
56:     this.isFlank = false,
57:     this.isRear = false,
58:     this.specialRulesInEffect = const {},
59:     required this.hitRoll,
60:     required this.defenseRoll,
61:     required this.resolveRoll,
62:   });
63: }
```

## File: lib/domain/models/regiment.dart
```dart
 1: // lib/domain/models/regiment.dart
 2: enum RegimentType { infantry, cavalry, brute, monster, chariot }
 3: 
 4: enum RegimentClass { light, medium, heavy }
 5: 
 6: class Regiment {
 7:   final String name;
 8:   final String faction;
 9:   final RegimentType type;
10:   final RegimentClass regimentClass;
11:   final int march;
12:   final int volley;
13:   final int clash;
14:   final int attacks;
15:   final int wounds;
16:   final int resolve;
17:   final int defense;
18:   final int evasion;
19:   final List<String> specialRules;
20:   final List<String> drawEvents;
21: 
22:   Regiment({
23:     required this.name,
24:     required this.faction,
25:     required this.type,
26:     required this.regimentClass,
27:     required this.march,
28:     required this.volley,
29:     required this.clash,
30:     required this.attacks,
31:     required this.wounds,
32:     required this.resolve,
33:     required this.defense,
34:     required this.evasion,
35:     this.specialRules = const [],
36:     this.drawEvents = const [],
37:   });
38: }
```

## File: lib/domain/usecases/calculate_combat.dart
```dart
  1: // lib/domain/usecases/calculate_combat.dart
  2: import 'dart:math';
  3: import '../models/regiment.dart';
  4: import '../models/combat_simulation.dart';
  5: 
  6: class CalculateCombat {
  7:   final Random _random = Random();
  8: 
  9:   // Calculate expected result based on probabilities
 10:   CombatSimulation calculateExpectedResult({
 11:     required Regiment attacker,
 12:     required int numAttackerStands,
 13:     required Regiment defender,
 14:     required int numDefenderStands,
 15:     bool isCharge = false,
 16:     bool isImpact = false,
 17:     bool isFlank = false,
 18:     bool isRear = false,
 19:     Map<String, bool> specialRulesInEffect = const {},
 20:   }) {
 21:     // 1. Calculate total attacks
 22:     int totalAttacks = _calculateTotalAttacks(
 23:       attacker: attacker,
 24:       numAttackerStands: numAttackerStands,
 25:       isCharge: isCharge,
 26:       isImpact: isImpact,
 27:       specialRulesInEffect: specialRulesInEffect,
 28:     );
 29: 
 30:     // 2. Calculate hit probability based on clash or impact
 31:     int hitTarget;
 32:     if (isImpact) {
 33:       // For impact attacks, use the attacker's clash value
 34:       hitTarget = attacker.clash;
 35:     } else {
 36:       // For clash attacks, use the base clash value
 37:       // Also check if unit is inspired (which adds +1 to clash)
 38:       hitTarget =
 39:           attacker.clash + (specialRulesInEffect['inspired'] == true ? 1 : 0);
 40:     }
 41: 
 42:     // Adjust for special rules
 43:     if (specialRulesInEffect['cleave'] == true) {
 44:       // Apply cleave effect (doesn't change hit target, but affects defense later)
 45:     }
 46: 
 47:     // 3. Calculate expected hits
 48:     DiceResult hitRoll = DiceResult.fromRoll(
 49:       dice: totalAttacks,
 50:       target: hitTarget,
 51:     );
 52: 
 53:     // 4. Calculate defense roll
 54:     int defenseTarget = max(defender.defense, defender.evasion);
 55: 
 56:     // Adjust for flanking and special rules
 57:     if (isFlank || isRear) {
 58:       // Flanking ignores shields - simulate by reducing defense
 59:       if (specialRulesInEffect['shield'] == true) {
 60:         defenseTarget = max(defenseTarget - 1, 0);
 61:       }
 62:     }
 63: 
 64:     DiceResult defenseRoll = DiceResult.fromRoll(
 65:       dice: hitRoll.successes,
 66:       target: defenseTarget,
 67:     );
 68: 
 69:     // 5. Calculate morale/resolve roll
 70:     int resolveTarget = defender.resolve;
 71: 
 72:     // Adjust for flanking
 73:     if (isFlank || isRear) {
 74:       // Units attacked from flank/rear must re-roll successful resolve tests
 75:       // This effectively reduces their resolve
 76:       resolveTarget =
 77:           max(resolveTarget - 1, 0); // Simulate re-rolls by reducing target
 78:     }
 79: 
 80:     DiceResult resolveRoll = DiceResult.fromRoll(
 81:       dice: defenseRoll.failures,
 82:       target: resolveTarget,
 83:     );
 84: 
 85:     // 6. Return complete simulation
 86:     return CombatSimulation(
 87:       attacker: attacker,
 88:       numAttackerStands: numAttackerStands,
 89:       defender: defender,
 90:       numDefenderStands: numDefenderStands,
 91:       isCharge: isCharge,
 92:       isImpact: isImpact,
 93:       isFlank: isFlank,
 94:       isRear: isRear,
 95:       specialRulesInEffect: specialRulesInEffect,
 96:       hitRoll: hitRoll,
 97:       defenseRoll: defenseRoll,
 98:       resolveRoll: resolveRoll,
 99:     );
100:   }
101: 
102:   int _calculateTotalAttacks({
103:     required Regiment attacker,
104:     required int numAttackerStands,
105:     required bool isCharge,
106:     required bool isImpact,
107:     required Map<String, bool> specialRulesInEffect,
108:   }) {
109:     int totalAttacks;
110: 
111:     if (isImpact) {
112:       // For impact attacks, we need to know the Impact(X) value
113:       // Let's assume it's stored in specialRulesInEffect['impactValue']
114:       int impactValue = specialRulesInEffect['impactValue'] as int? ?? 0;
115:       totalAttacks = impactValue * numAttackerStands;
116:     } else {
117:       // For regular clash, use the attacks characteristic
118:       totalAttacks = attacker.attacks * numAttackerStands;
119: 
120:       // Add support attacks from unengaged stands
121:       // In a simplified model, we can assume half of stands provide support
122:       int supportAttacks = (numAttackerStands / 2).floor();
123: 
124:       // If the unit has Support(X) special rule, adjust support attacks
125:       int supportValue = specialRulesInEffect['supportValue'] as int? ?? 1;
126:       supportAttacks *= supportValue;
127: 
128:       totalAttacks += supportAttacks;
129:     }
130: 
131:     // Apply special rules modifications
132:     if (specialRulesInEffect['flurry'] == true) {
133:       // Flurry allows re-rolling failed hits
134:       // We can simulate this by increasing the effective number of attacks
135:       // For a clash value of 3, re-rolling failures increases success by roughly 50%
136:       double flurryMultiplier = 1 + ((6 - attacker.clash) / 6);
137:       totalAttacks = (totalAttacks * flurryMultiplier).round();
138:     }
139: 
140:     return totalAttacks;
141:   }
142: }
```

## File: lib/presentation/providers/combat_provider.dart
```dart
  1: // lib/presentation/providers/combat_provider.dart
  2: import 'package:flutter_riverpod/flutter_riverpod.dart';
  3: import '../../domain/models/regiment.dart';
  4: import '../../domain/models/combat_simulation.dart';
  5: import '../../domain/usecases/calculate_combat.dart';
  6: 
  7: class CombatState {
  8:   final Regiment? attacker;
  9:   final int numAttackerStands;
 10:   final Regiment? defender;
 11:   final int numDefenderStands;
 12:   final bool isCharge;
 13:   final bool isImpact;
 14:   final bool isFlank;
 15:   final bool isRear;
 16:   final Map<String, bool> specialRulesInEffect;
 17:   final CombatSimulation? simulation;
 18: 
 19:   CombatState({
 20:     this.attacker,
 21:     this.numAttackerStands = 3,
 22:     this.defender,
 23:     this.numDefenderStands = 3,
 24:     this.isCharge = false,
 25:     this.isImpact = false,
 26:     this.isFlank = false,
 27:     this.isRear = false,
 28:     this.specialRulesInEffect = const {},
 29:     this.simulation,
 30:   });
 31: 
 32:   CombatState copyWith({
 33:     Regiment? attacker,
 34:     int? numAttackerStands,
 35:     Regiment? defender,
 36:     int? numDefenderStands,
 37:     bool? isCharge,
 38:     bool? isImpact,
 39:     bool? isFlank,
 40:     bool? isRear,
 41:     Map<String, bool>? specialRulesInEffect,
 42:     CombatSimulation? simulation,
 43:   }) {
 44:     return CombatState(
 45:       attacker: attacker ?? this.attacker,
 46:       numAttackerStands: numAttackerStands ?? this.numAttackerStands,
 47:       defender: defender ?? this.defender,
 48:       numDefenderStands: numDefenderStands ?? this.numDefenderStands,
 49:       isCharge: isCharge ?? this.isCharge,
 50:       isImpact: isImpact ?? this.isImpact,
 51:       isFlank: isFlank ?? this.isFlank,
 52:       isRear: isRear ?? this.isRear,
 53:       specialRulesInEffect: specialRulesInEffect ?? this.specialRulesInEffect,
 54:       simulation: simulation ?? this.simulation,
 55:     );
 56:   }
 57: }
 58: 
 59: class CombatNotifier extends StateNotifier<CombatState> {
 60:   final CalculateCombat _calculateCombat;
 61: 
 62:   CombatNotifier(this._calculateCombat) : super(CombatState());
 63: 
 64:   void updateAttacker(Regiment attacker) {
 65:     state = state.copyWith(attacker: attacker);
 66:     _recalculate();
 67:   }
 68: 
 69:   void updateAttackerStands(int stands) {
 70:     state = state.copyWith(numAttackerStands: stands);
 71:     _recalculate();
 72:   }
 73: 
 74:   void updateDefender(Regiment defender) {
 75:     state = state.copyWith(defender: defender);
 76:     _recalculate();
 77:   }
 78: 
 79:   void updateDefenderStands(int stands) {
 80:     state = state.copyWith(numDefenderStands: stands);
 81:     _recalculate();
 82:   }
 83: 
 84:   void toggleCharge(bool value) {
 85:     state = state.copyWith(isCharge: value);
 86:     _recalculate();
 87:   }
 88: 
 89:   void toggleImpact(bool value) {
 90:     state = state.copyWith(isImpact: value);
 91:     _recalculate();
 92:   }
 93: 
 94:   void toggleFlank(bool value) {
 95:     state = state.copyWith(isFlank: value);
 96:     _recalculate();
 97:   }
 98: 
 99:   void toggleRear(bool value) {
100:     state = state.copyWith(isRear: value);
101:     _recalculate();
102:   }
103: 
104:   void toggleSpecialRule(String rule, bool value) {
105:     final updatedRules = Map<String, bool>.from(state.specialRulesInEffect);
106:     updatedRules[rule] = value;
107:     state = state.copyWith(specialRulesInEffect: updatedRules);
108:     _recalculate();
109:   }
110: 
111:   void _recalculate() {
112:     if (state.attacker != null && state.defender != null) {
113:       final simulation = _calculateCombat.calculateExpectedResult(
114:         attacker: state.attacker!,
115:         numAttackerStands: state.numAttackerStands,
116:         defender: state.defender!,
117:         numDefenderStands: state.numDefenderStands,
118:         isCharge: state.isCharge,
119:         isImpact: state.isImpact,
120:         isFlank: state.isFlank,
121:         isRear: state.isRear,
122:         specialRulesInEffect: state.specialRulesInEffect,
123:       );
124: 
125:       state = state.copyWith(simulation: simulation);
126:     }
127:   }
128: }
129: 
130: final calculateCombatProvider = Provider((ref) => CalculateCombat());
131: 
132: final combatProvider =
133:     StateNotifierProvider<CombatNotifier, CombatState>((ref) {
134:   final calculateCombat = ref.watch(calculateCombatProvider);
135:   return CombatNotifier(calculateCombat);
136: });
```

## File: lib/presentation/screens/combat_calculator_screen.dart
```dart
  1: // lib/presentation/screens/combat_calculator_screen.dart
  2: import 'package:flutter/material.dart';
  3: import 'package:flutter_riverpod/flutter_riverpod.dart';
  4: import '../providers/combat_provider.dart';
  5: import '../widgets/wave_slider.dart';
  6: import '../widgets/target_selector.dart';
  7: 
  8: class CombatCalculatorScreen extends ConsumerWidget {
  9:   const CombatCalculatorScreen({super.key});
 10: 
 11:   @override
 12:   Widget build(BuildContext context, WidgetRef ref) {
 13:     final combatState = ref.watch(combatProvider);
 14:     final combatNotifier = ref.read(combatProvider.notifier);
 15: 
 16:     // If we don't have a simulation yet, show a placeholder
 17:     if (combatState.simulation == null) {
 18:       return Scaffold(
 19:         appBar: AppBar(
 20:           title: const Text('Combat Calculator'),
 21:         ),
 22:         body: const Center(
 23:           child: Text('Select units to calculate combat probabilities'),
 24:         ),
 25:       );
 26:     }
 27: 
 28:     // Otherwise, show the combat visualization
 29:     final simulation = combatState.simulation!;
 30: 
 31:     return Scaffold(
 32:       appBar: AppBar(
 33:         title: const Text('Combat Calculator'),
 34:       ),
 35:       body: Padding(
 36:         padding: const EdgeInsets.all(16.0),
 37:         child: Column(
 38:           crossAxisAlignment: CrossAxisAlignment.start,
 39:           children: [
 40:             // Combat setup controls (simplified for now)
 41:             Row(
 42:               children: [
 43:                 Text('Number of Attacking Stands: '),
 44:                 TargetSelector(
 45:                   selectionLimit: 10,
 46:                   initialValue: combatState.numAttackerStands,
 47:                   onChanged: (value) =>
 48:                       combatNotifier.updateAttackerStands(value),
 49:                 ),
 50:               ],
 51:             ),
 52: 
 53:             const SizedBox(height: 24),
 54: 
 55:             // Hit roll wave slider
 56:             Text('Hit Roll', style: Theme.of(context).textTheme.headlineSmall),
 57:             WaveSlider(
 58:               width: MediaQuery.of(context).size.width - 32,
 59:               height: 80,
 60:               dragPercentage: 0.0,
 61:               expectedSuccessPercentage:
 62:                   simulation.hitRoll.successes / simulation.hitRoll.total,
 63:               numDice: simulation.hitRoll.total,
 64:               expectedSuccesses: simulation.hitRoll.successes.toDouble(),
 65:               onChanged: (value) {}, // We're using it for display only
 66:             ),
 67: 
 68:             const SizedBox(height: 16),
 69: 
 70:             // Defense roll wave slider
 71:             Text('Defense Roll',
 72:                 style: Theme.of(context).textTheme.headlineSmall),
 73:             WaveSlider(
 74:               width: MediaQuery.of(context).size.width - 32,
 75:               height: 80,
 76:               dragPercentage: 0.0,
 77:               expectedSuccessPercentage: simulation.defenseRoll.successes /
 78:                   simulation.defenseRoll.total,
 79:               numDice: simulation.defenseRoll.total,
 80:               expectedSuccesses: simulation.defenseRoll.successes.toDouble(),
 81:               onChanged: (value) {}, // We're using it for display only
 82:             ),
 83: 
 84:             const SizedBox(height: 16),
 85: 
 86:             // Resolve roll wave slider
 87:             Text('Resolve Roll',
 88:                 style: Theme.of(context).textTheme.headlineSmall),
 89:             WaveSlider(
 90:               width: MediaQuery.of(context).size.width - 32,
 91:               height: 80,
 92:               dragPercentage: 0.0,
 93:               expectedSuccessPercentage: simulation.resolveRoll.successes /
 94:                   simulation.resolveRoll.total,
 95:               numDice: simulation.resolveRoll.total,
 96:               expectedSuccesses: simulation.resolveRoll.successes.toDouble(),
 97:               onChanged: (value) {}, // We're using it for display only
 98:             ),
 99: 
100:             const SizedBox(height: 24),
101: 
102:             // Results summary
103:             Container(
104:               padding: const EdgeInsets.all(16),
105:               decoration: BoxDecoration(
106:                 color: Colors.deepPurple.withOpacity(0.1),
107:                 borderRadius: BorderRadius.circular(8),
108:               ),
109:               child: Column(
110:                 crossAxisAlignment: CrossAxisAlignment.start,
111:                 children: [
112:                   Text(
113:                     'Expected Wounds: ${simulation.defenseRoll.failures + simulation.resolveRoll.failures}',
114:                     style: const TextStyle(
115:                         fontSize: 18, fontWeight: FontWeight.bold),
116:                   ),
117:                   Text(
118:                     'Probability of Breaking: ${_calculateBreakProbability(combatState)}%',
119:                     style: const TextStyle(fontSize: 16),
120:                   ),
121:                 ],
122:               ),
123:             ),
124:           ],
125:         ),
126:       ),
127:     );
128:   }
129: 
130:   double _calculateBreakProbability(CombatState state) {
131:     if (state.simulation == null) return 0.0;
132: 
133:     final simulation = state.simulation!;
134:     final totalWounds =
135:         simulation.defenseRoll.failures + simulation.resolveRoll.failures;
136:     final standsLost = totalWounds ~/ state.defender!.wounds;
137: 
138:     // Simplified breaking calculation
139:     final standsRequired = (state.numDefenderStands / 2).ceil();
140:     if (standsLost >= standsRequired) {
141:       return 100.0;
142:     } else {
143:       // This is very simplified - a real implementation would use probability distributions
144:       return (standsLost / standsRequired * 100).clamp(0.0, 100.0);
145:     }
146:   }
147: }
```

## File: lib/presentation/themes/app_theme.dart
```dart
 1: // lib/presentation/themes/app_theme.dart
 2: import 'package:flutter/material.dart';
 3: import 'package:google_fonts/google_fonts.dart';
 4: 
 5: class AppTheme {
 6:   static final ThemeData lightTheme = ThemeData(
 7:     useMaterial3: true,
 8:     colorScheme: ColorScheme.fromSeed(
 9:       seedColor: Colors.deepPurple,
10:       brightness: Brightness.light,
11:     ),
12:     textTheme: GoogleFonts.robotoTextTheme(ThemeData.light().textTheme),
13:     elevatedButtonTheme: ElevatedButtonThemeData(
14:       style: ElevatedButton.styleFrom(
15:         backgroundColor: Colors.deepPurple,
16:         foregroundColor: Colors.white,
17:         shape: RoundedRectangleBorder(
18:           borderRadius: BorderRadius.circular(8),
19:         ),
20:         padding: const EdgeInsets.symmetric(
21:           horizontal: 24,
22:           vertical: 12,
23:         ),
24:       ),
25:     ),
26:   );
27: 
28:   static final ThemeData darkTheme = ThemeData(
29:     useMaterial3: true,
30:     colorScheme: ColorScheme.fromSeed(
31:       seedColor: Colors.deepPurple,
32:       brightness: Brightness.dark,
33:     ),
34:     textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
35:     elevatedButtonTheme: ElevatedButtonThemeData(
36:       style: ElevatedButton.styleFrom(
37:         backgroundColor: Colors.deepPurpleAccent,
38:         foregroundColor: Colors.white,
39:         shape: RoundedRectangleBorder(
40:           borderRadius: BorderRadius.circular(8),
41:         ),
42:         padding: const EdgeInsets.symmetric(
43:           horizontal: 24,
44:           vertical: 12,
45:         ),
46:       ),
47:     ),
48:   );
49: }
```

## File: lib/presentation/widgets/target_selector.dart
```dart
 1: // lib/presentation/widgets/target_selector.dart
 2: import 'package:flutter/material.dart';
 3: 
 4: class TargetSelector extends StatelessWidget {
 5:   final int selectionLimit;
 6:   final int initialValue;
 7:   final ValueChanged<int> onChanged;
 8:   final double textSize;
 9: 
10:   const TargetSelector({
11:     super.key,
12:     required this.selectionLimit,
13:     required this.initialValue,
14:     required this.onChanged,
15:     this.textSize = 16, // Default text size
16:   });
17: 
18:   @override
19:   Widget build(BuildContext context) {
20:     return DropdownButton<int>(
21:       value: initialValue,
22:       icon: const Icon(Icons.arrow_downward),
23:       elevation: 16,
24:       style: TextStyle(
25:         color: Colors.deepPurple,
26:         fontSize: textSize, // Use the provided text size
27:       ),
28:       underline: Container(height: 2, color: Colors.deepPurpleAccent),
29:       onChanged: (int? newValue) {
30:         if (newValue != null) {
31:           onChanged(newValue);
32:         }
33:       },
34:       items: List.generate(selectionLimit, (index) => index + 1)
35:           .map<DropdownMenuItem<int>>((int value) {
36:         return DropdownMenuItem<int>(
37:           value: value,
38:           child: Text(value.toString()),
39:         );
40:       }).toList(),
41:     );
42:   }
43: }
```

## File: lib/presentation/widgets/wave_painter.dart
```dart
  1: import 'dart:ui';
  2: import 'package:flutter/material.dart';
  3: 
  4: class WavePainter extends CustomPainter {
  5:   final double sliderPosition;
  6:   final double dragPercentage;
  7:   final double expectedSuccessPercentage;
  8:   final int numDice;
  9:   final double expectedSuccesses;
 10: 
 11:   // Buffer and drawing area parameters
 12:   final double horizontalBuffer;
 13:   final double verticalBuffer;
 14:   final double drawingWidth;
 15:   final double drawingHeight;
 16: 
 17:   final Color badColor = Color(0xFFFF4136); // Red
 18:   final Color neutralColor = Color(0xFFFFDC00); // Yellow
 19:   final Color goodColor = Color(0xFF2ECC40); // Green
 20: 
 21:   final Paint fillPainter;
 22:   final Paint expectedLinePainter;
 23:   late Paint wavePainter;
 24: 
 25:   double _previousSliderPosition = 0;
 26: 
 27:   WavePainter({
 28:     required this.sliderPosition,
 29:     required this.dragPercentage,
 30:     required this.expectedSuccessPercentage,
 31:     this.numDice = 1,
 32:     this.expectedSuccesses = 0,
 33:     required this.horizontalBuffer,
 34:     required this.verticalBuffer,
 35:     required this.drawingWidth,
 36:     required this.drawingHeight,
 37:   })  : fillPainter = Paint()
 38:           ..color = Colors.black
 39:           ..style = PaintingStyle.fill,
 40:         expectedLinePainter = Paint()
 41:           ..color = Colors.black
 42:           ..strokeWidth = 3.0 {
 43:     wavePainter = Paint()
 44:       ..color = _calculateWaveColor(dragPercentage, expectedSuccessPercentage)
 45:       ..style = PaintingStyle.stroke
 46:       ..strokeWidth = 2.5;
 47:   }
 48: 
 49:   /// Computes the color of the wave based on the drag percentage.
 50:   Color _calculateWaveColor(double dragPercentage, double expectedPercentage) {
 51:     const double biasFactor = 0.4; // 70% of the transition range
 52: 
 53:     if (dragPercentage < expectedPercentage) {
 54:       // Interpolate Red to Yellow with 70% bias
 55:       double t = dragPercentage / (1 - expectedPercentage * biasFactor);
 56:       t = t.clamp(0.0, 1.0); // Ensure stays in range
 57:       return Color.lerp(badColor, neutralColor, t) ?? neutralColor;
 58:     } else {
 59:       // Interpolate Yellow to Green with 70% bias
 60:       double t = (dragPercentage - expectedPercentage) /
 61:           ((1 - expectedPercentage) * biasFactor);
 62:       t = t.clamp(0.0, 1.0); // Ensure stays in range
 63:       return Color.lerp(neutralColor, goodColor, t) ?? goodColor;
 64:     }
 65:   }
 66: 
 67:   @override
 68:   void paint(Canvas canvas, Size size) {
 69:     // Calculate the drawing area - use almost all available space
 70:     final drawingArea = Rect.fromLTWH(
 71:         horizontalBuffer, // Left buffer
 72:         verticalBuffer * 0.8, // Reduced top buffer
 73:         drawingWidth, // Width between buffers
 74:         drawingHeight - (verticalBuffer) // Extend down almost to bottom
 75:         );
 76: 
 77:     // Paint elements in correct order for layering
 78:     _paintWaveLine(canvas, size, drawingArea);
 79:     _paintAnchors(canvas, size, drawingArea);
 80:     _paintExpectedSuccessDot(canvas, size, drawingArea);
 81:     _paintExpectedSuccessText(canvas, size, drawingArea);
 82:     _paintDiceCountAnnotation(canvas, size, drawingArea);
 83:   }
 84: 
 85:   void _paintExpectedSuccessDot(Canvas canvas, Size size, Rect drawingArea) {
 86:     double xPosition =
 87:         drawingArea.left + (expectedSuccessPercentage * drawingArea.width);
 88: 
 89:     // Only draw if within the drawing area
 90:     if (xPosition >= drawingArea.left && xPosition <= drawingArea.right) {
 91:       // Create a dot on the wave line - slightly smaller than anchor points
 92:       final dotPaint = Paint()
 93:         ..color = Colors.black
 94:         ..style = PaintingStyle.fill;
 95: 
 96:       canvas.drawCircle(
 97:           Offset(xPosition, drawingArea.bottom),
 98:           4.0, // Slightly smaller than anchor points (5.0)
 99:           dotPaint);
100:     }
101:   }
102: 
103:   void _paintExpectedSuccessText(Canvas canvas, Size size, Rect drawingArea) {
104:     final textPainter = TextPainter(
105:       textAlign: TextAlign.left,
106:       textDirection: TextDirection.ltr,
107:     );
108: 
109:     double xPosition =
110:         drawingArea.left + (expectedSuccessPercentage * drawingArea.width);
111: 
112:     // Only draw if within the drawing area
113:     if (xPosition >= drawingArea.left && xPosition <= drawingArea.right) {
114:       textPainter.text = TextSpan(
115:         text: expectedSuccesses.toStringAsFixed(1),
116:         style: TextStyle(
117:           color: Colors.black,
118:           fontSize: 14,
119:           fontWeight: FontWeight.bold,
120:         ),
121:       );
122:       textPainter.layout(maxWidth: 100);
123: 
124:       // Center the text below the expected dot
125:       double centeredXOffset = xPosition - (textPainter.width / 2);
126: 
127:       // Ensure text stays within bounds
128:       centeredXOffset = centeredXOffset.clamp(
129:           drawingArea.left, drawingArea.right - textPainter.width);
130: 
131:       // Position text below the wave line
132:       double textY = drawingArea.bottom + 10;
133:       textPainter.paint(canvas, Offset(centeredXOffset, textY));
134:     }
135:   }
136: 
137:   void _paintDiceCountAnnotation(Canvas canvas, Size size, Rect drawingArea) {
138:     final textPainter = TextPainter(
139:       textAlign: TextAlign.left,
140:       textDirection: TextDirection.ltr,
141:     );
142: 
143:     // Annotate number of dice below the right anchor point
144:     textPainter.text = TextSpan(
145:       text: '$numDice',
146:       style: TextStyle(
147:         color: Colors.black,
148:         fontSize: 14,
149:         fontWeight: FontWeight.bold,
150:       ),
151:     );
152:     textPainter.layout();
153: 
154:     // Center the text below the right anchor point
155:     double centeredXOffset = drawingArea.right - (textPainter.width / 2);
156: 
157:     // Position text below the wave line
158:     double textY = drawingArea.bottom + 10;
159:     textPainter.paint(canvas, Offset(centeredXOffset, textY));
160:   }
161: 
162:   void _paintAnchors(Canvas canvas, Size size, Rect drawingArea) {
163:     // Position anchors exactly at the ends of the drawing area
164:     double waveCenterY = drawingArea.bottom;
165:     canvas.drawCircle(Offset(drawingArea.left, waveCenterY), 5.0, fillPainter);
166:     canvas.drawCircle(Offset(drawingArea.right, waveCenterY), 5.0, fillPainter);
167:   }
168: 
169:   void _paintWaveLine(Canvas canvas, Size size, Rect drawingArea) {
170:     WaveCurveDefinitions waveCurve =
171:         _calculateWaveLineDefinitions(size, drawingArea);
172:     double waveY = drawingArea.bottom;
173: 
174:     Path path = Path();
175:     path.moveTo(drawingArea.left, waveY);
176:     path.lineTo(waveCurve.startofBezier, waveY);
177:     path.cubicTo(
178:         waveCurve.leftControlPoint1,
179:         waveY,
180:         waveCurve.leftControlPoint2,
181:         waveCurve.controlHeight,
182:         waveCurve.centerPoint,
183:         waveCurve.controlHeight);
184:     path.cubicTo(waveCurve.rightControlPoint1, waveCurve.controlHeight,
185:         waveCurve.rightControlPoint2, waveY, waveCurve.endOfBezier, waveY);
186:     path.lineTo(drawingArea.right, waveY);
187: 
188:     canvas.drawPath(path, wavePainter);
189:   }
190: 
191:   WaveCurveDefinitions _calculateWaveLineDefinitions(
192:       Size size, Rect drawingArea) {
193:     // Further increase the wave height by adjusting these factors
194:     double minWaveHeight = drawingArea.height * 0.1; // Further reduced minimum
195:     double maxWaveHeight =
196:         drawingArea.height * 0.95; // Increased maximum even more
197: 
198:     // Calculate the control height for the wave peak
199:     double controlHeight = drawingArea.top +
200:         (drawingArea.height - minWaveHeight) -
201:         (maxWaveHeight * dragPercentage);
202: 
203:     // Calculate bend and bezier width - standard values
204:     double bendWidth = 20 + 20 * dragPercentage;
205:     double bezierWidth = 20 + 20 * dragPercentage;
206: 
207:     // Ensure the slider position is correctly mapped to the drawing area
208:     double adjustedPosition = sliderPosition;
209: 
210:     // Center point cannot exceed the drawing area
211:     double centerPoint = adjustedPosition;
212:     centerPoint = centerPoint.clamp(drawingArea.left, drawingArea.right);
213: 
214:     // Calculate bezier curve points
215:     double startOfBend = centerPoint - bendWidth / 2;
216:     double startOfBezier = startOfBend - bezierWidth;
217:     double endOfBend = centerPoint + bendWidth / 2;
218:     double endOfBezier = endOfBend + bezierWidth;
219: 
220:     // Constrain points to the drawing area
221:     startOfBend = startOfBend.clamp(drawingArea.left, drawingArea.right);
222:     startOfBezier = startOfBezier.clamp(drawingArea.left, drawingArea.right);
223:     endOfBend = endOfBend.clamp(drawingArea.left, drawingArea.right);
224:     endOfBezier = endOfBezier.clamp(drawingArea.left, drawingArea.right);
225: 
226:     // Control points
227:     double leftControlPoint1 = startOfBend;
228:     double leftControlPoint2 = startOfBend;
229:     double rightControlPoint1 = endOfBend;
230:     double rightControlPoint2 = endOfBend;
231: 
232:     // Calculate bending based on position change
233:     double bendability = 25.0;
234:     double maxSlideDifference = 15.0;
235: 
236:     double slideDifference = (sliderPosition - _previousSliderPosition).abs();
237:     slideDifference = slideDifference.clamp(0.0, maxSlideDifference);
238: 
239:     bool moveLeft = sliderPosition < _previousSliderPosition;
240: 
241:     double bend =
242:         lerpDouble(0.0, bendability, slideDifference / maxSlideDifference) ??
243:             0.0;
244:     bend = moveLeft ? -bend : bend;
245: 
246:     // Apply bend to control points
247:     leftControlPoint1 = leftControlPoint1 + bend;
248:     leftControlPoint2 = leftControlPoint2 - bend;
249:     rightControlPoint1 = rightControlPoint1 - bend;
250:     rightControlPoint2 = rightControlPoint2 + bend;
251:     centerPoint = centerPoint - bend;
252: 
253:     // Constrain bent points to drawing area
254:     leftControlPoint1 =
255:         leftControlPoint1.clamp(drawingArea.left, drawingArea.right);
256:     leftControlPoint2 =
257:         leftControlPoint2.clamp(drawingArea.left, drawingArea.right);
258:     rightControlPoint1 =
259:         rightControlPoint1.clamp(drawingArea.left, drawingArea.right);
260:     rightControlPoint2 =
261:         rightControlPoint2.clamp(drawingArea.left, drawingArea.right);
262:     centerPoint = centerPoint.clamp(drawingArea.left, drawingArea.right);
263: 
264:     return WaveCurveDefinitions(
265:       startofBezier: startOfBezier,
266:       endOfBezier: endOfBezier,
267:       leftControlPoint1: leftControlPoint1,
268:       leftControlPoint2: leftControlPoint2,
269:       rightControlPoint1: rightControlPoint1,
270:       rightControlPoint2: rightControlPoint2,
271:       controlHeight: controlHeight,
272:       centerPoint: centerPoint,
273:     );
274:   }
275: 
276:   @override
277:   bool shouldRepaint(covariant WavePainter oldDelegate) {
278:     _previousSliderPosition = oldDelegate.sliderPosition;
279:     return oldDelegate.sliderPosition != sliderPosition ||
280:         oldDelegate.dragPercentage != dragPercentage ||
281:         oldDelegate.expectedSuccessPercentage != expectedSuccessPercentage;
282:   }
283: }
284: 
285: class WaveCurveDefinitions {
286:   double startofBezier;
287:   double endOfBezier;
288:   double leftControlPoint1;
289:   double leftControlPoint2;
290:   double rightControlPoint1;
291:   double rightControlPoint2;
292:   double controlHeight;
293:   double centerPoint;
294: 
295:   WaveCurveDefinitions({
296:     required this.startofBezier,
297:     required this.endOfBezier,
298:     required this.leftControlPoint1,
299:     required this.leftControlPoint2,
300:     required this.rightControlPoint1,
301:     required this.rightControlPoint2,
302:     required this.controlHeight,
303:     required this.centerPoint,
304:   });
305: }
```

## File: lib/presentation/widgets/wave_slider.dart
```dart
  1: import 'package:flutter/material.dart';
  2: import 'wave_painter.dart';
  3: 
  4: class WaveSlider extends StatefulWidget {
  5:   final double width;
  6:   final double height;
  7:   final Color color;
  8:   final ValueChanged<double> onChanged;
  9:   final double dragPercentage;
 10:   final double expectedSuccessPercentage;
 11:   final int numDice;
 12:   final double expectedSuccesses;
 13: 
 14:   const WaveSlider({
 15:     this.width = 400.0, // Increased from 350.0 to use more horizontal space
 16:     this.height = 70.0, // Increased from 60.0 to give more vertical space
 17:     this.color = Colors.black,
 18:     required this.onChanged,
 19:     this.dragPercentage = 0.0,
 20:     this.expectedSuccessPercentage = 0.0,
 21:     this.numDice = 1,
 22:     this.expectedSuccesses = 0,
 23:   }) : assert(height >= 50 && height <= 600);
 24: 
 25:   @override
 26:   State<WaveSlider> createState() => _WaveSliderState();
 27: }
 28: 
 29: class _WaveSliderState extends State<WaveSlider> {
 30:   double _dragPosition = 0;
 31:   double _dragPercentage = 0;
 32: 
 33:   @override
 34:   void didUpdateWidget(covariant WaveSlider oldWidget) {
 35:     super.didUpdateWidget(oldWidget);
 36:     if (widget.dragPercentage != oldWidget.dragPercentage) {
 37:       setState(() {
 38:         _dragPercentage = widget.dragPercentage;
 39:         _dragPosition = _dragPercentage * widget.width;
 40:       });
 41:     }
 42:   }
 43: 
 44:   void _updateDragPosition(Offset val) {
 45:     double newDragPosition = val.dx.clamp(0, widget.width);
 46:     setState(() {
 47:       _dragPosition = newDragPosition;
 48:       _dragPercentage = _dragPosition / widget.width;
 49:     });
 50:     widget.onChanged(_dragPercentage);
 51:   }
 52: 
 53:   @override
 54:   Widget build(BuildContext context) {
 55:     // Create a buffer around the slider for visual elements
 56:     final horizontalBuffer = 20.0;
 57:     final verticalBuffer = 10.0; // Further reduced to maximize space
 58: 
 59:     // Calculate the actual drawing area dimensions
 60:     final drawingWidth = widget.width - (horizontalBuffer * 2);
 61:     final drawingHeight = widget.height;
 62: 
 63:     // Calculate the adjusted drag position within the drawing area
 64:     final adjustedDragPosition =
 65:         (drawingWidth * _dragPercentage) + horizontalBuffer;
 66: 
 67:     return Container(
 68:       width: widget.width,
 69:       height: widget.height + 25, // Extra space for text below
 70:       // Add a light border for debugging
 71:       decoration: BoxDecoration(
 72:         border: Border.all(color: Colors.grey.withOpacity(0.1)),
 73:         borderRadius: BorderRadius.circular(4),
 74:       ),
 75:       child: Stack(
 76:         alignment: Alignment.center,
 77:         children: [
 78:           // Drawing container with buffer space
 79:           Positioned(
 80:             left: 0,
 81:             top: 0,
 82:             right: 0,
 83:             bottom: 0,
 84:             child: CustomPaint(
 85:               painter: WavePainter(
 86:                 sliderPosition: adjustedDragPosition,
 87:                 dragPercentage: _dragPercentage,
 88:                 expectedSuccessPercentage: widget.expectedSuccessPercentage,
 89:                 numDice: widget.numDice,
 90:                 expectedSuccesses: widget.expectedSuccesses,
 91:                 horizontalBuffer: horizontalBuffer,
 92:                 verticalBuffer: verticalBuffer,
 93:                 drawingWidth: drawingWidth,
 94:                 drawingHeight: drawingHeight,
 95:               ),
 96:               // This forces CustomPainter to use the full size
 97:               size: Size(widget.width, widget.height + 25),
 98:             ),
 99:           ),
100: 
101:           // Value indicator - positioned just above the wave line
102:           Positioned(
103:             left: adjustedDragPosition - 15, // Center it on the wave
104:             top: widget.height - 35, // Position above the wave line
105:             child: Container(
106:               padding: EdgeInsets.symmetric(
107:                   horizontal: 8, vertical: 2), // Reduced vertical padding
108:               decoration: BoxDecoration(
109:                 color: Colors.white.withOpacity(0.5),
110:                 borderRadius:
111:                     BorderRadius.circular(8), // Slightly smaller radius
112:               ),
113:               child: Text(
114:                 '${(widget.numDice * _dragPercentage).round()}',
115:                 style: TextStyle(
116:                   fontSize: 24,
117:                   fontWeight: FontWeight.bold,
118:                 ),
119:               ),
120:             ),
121:           ),
122:         ],
123:       ),
124:     );
125:   }
126: }
```

## File: lib/main.dart
```dart
 1: // lib/main.dart
 2: import 'package:flutter/material.dart';
 3: import 'package:flutter_riverpod/flutter_riverpod.dart';
 4: import 'presentation/screens/combat_calculator_screen.dart';
 5: import 'presentation/themes/app_theme.dart';
 6: 
 7: void main() {
 8:   runApp(
 9:     const ProviderScope(
10:       child: ConquestCalculatorApp(),
11:     ),
12:   );
13: }
14: 
15: class ConquestCalculatorApp extends StatelessWidget {
16:   const ConquestCalculatorApp({super.key});
17: 
18:   @override
19:   Widget build(BuildContext context) {
20:     return MaterialApp(
21:       title: 'Conquest Calculator',
22:       theme: AppTheme.lightTheme,
23:       darkTheme: AppTheme.darkTheme,
24:       themeMode: ThemeMode.system,
25:       home: const CombatCalculatorScreen(),
26:     );
27:   }
28: }
```

## File: test/widget_test.dart
```dart
 1: // // This is a basic Flutter widget test.
 2: // //
 3: // // To perform an interaction with a widget in your test, use the WidgetTester
 4: // // utility in the flutter_test package. For example, you can send tap and scroll
 5: // // gestures. You can also use WidgetTester to find child widgets in the widget
 6: // // tree, read text, and verify that the values of widget properties are correct.
 7: 
 8: // import 'package:flutter/material.dart';
 9: // import 'package:flutter_riverpod/flutter_riverpod.dart';
10: // import 'package:flutter_test/flutter_test.dart';
11: 
12: // import 'package:conquest_calculator/main.dart';
13: 
14: // void main() {
15: //   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
16: //     // Build our app and trigger a frame.
17: //     //await tester.pumpWidget(const ConquestCalculatorApp());
18: 
19: //     await tester.pumpWidget(
20: //       ProviderScope(
21: //         child: ConquestCalculatorApp(),
22: //       ),
23: //     );
24: 
25: //     // Verify that our counter starts at 0.
26: //     expect(find.text('0'), findsOneWidget);
27: //     expect(find.text('1'), findsNothing);
28: 
29: //     // Tap the '+' icon and trigger a frame.
30: //     await tester.tap(find.byIcon(Icons.add));
31: //     await tester.pump();
32: 
33: //     // Verify that our counter has incremented.
34: //     expect(find.text('0'), findsNothing);
35: //     expect(find.text('1'), findsOneWidget);
36: //   });
37: // }
```

## File: analysis_options.yaml
```yaml
 1: # This file configures the analyzer, which statically analyzes Dart code to
 2: # check for errors, warnings, and lints.
 3: #
 4: # The issues identified by the analyzer are surfaced in the UI of Dart-enabled
 5: # IDEs (https://dart.dev/tools#ides-and-editors). The analyzer can also be
 6: # invoked from the command line by running `flutter analyze`.
 7: 
 8: # The following line activates a set of recommended lints for Flutter apps,
 9: # packages, and plugins designed to encourage good coding practices.
10: include: package:flutter_lints/flutter.yaml
11: 
12: linter:
13:   # The lint rules applied to this project can be customized in the
14:   # section below to disable rules from the `package:flutter_lints/flutter.yaml`
15:   # included above or to enable additional rules. A list of all available lints
16:   # and their documentation is published at https://dart.dev/lints.
17:   #
18:   # Instead of disabling a lint rule for the entire project in the
19:   # section below, it can also be suppressed for a single line of code
20:   # or a specific dart file by using the `// ignore: name_of_lint` and
21:   # `// ignore_for_file: name_of_lint` syntax on the line or in the file
22:   # producing the lint.
23:   rules:
24:     # avoid_print: false  # Uncomment to disable the `avoid_print` rule
25:     # prefer_single_quotes: true  # Uncomment to enable the `prefer_single_quotes` rule
26: 
27: # Additional information about this file can be found at
28: # https://dart.dev/guides/language/analysis-options
```

## File: pubspec.yaml
```yaml
 1: name: conquest_calculator
 2: description: "A new Flutter project."
 3: # The following line prevents the package from being accidentally published to
 4: # pub.dev using `flutter pub publish`. This is preferred for private packages.
 5: publish_to: 'none' # Remove this line if you wish to publish to pub.dev
 6: 
 7: # The following defines the version and build number for your application.
 8: # A version number is three numbers separated by dots, like 1.2.43
 9: # followed by an optional build number separated by a +.
10: # Both the version and the builder number may be overridden in flutter
11: # build by specifying --build-name and --build-number, respectively.
12: # In Android, build-name is used as versionName while build-number used as versionCode.
13: # Read more about Android versioning at https://developer.android.com/studio/publish/versioning
14: # In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
15: # Read more about iOS versioning at
16: # https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
17: # In Windows, build-name is used as the major, minor, and patch parts
18: # of the product and file versions while build-number is used as the build suffix.
19: version: 1.0.0+1
20: 
21: environment:
22:   sdk: ^3.6.2
23: 
24: # Dependencies specify other packages that your package needs in order to work.
25: # To automatically upgrade your package dependencies to the latest versions
26: # consider running `flutter pub upgrade --major-versions`. Alternatively,
27: # dependencies can be manually updated by changing the version numbers below to
28: # the latest version available on pub.dev. To see which dependencies have newer
29: # versions available, run `flutter pub outdated`.
30: dependencies:
31:   flutter:
32:     sdk: flutter
33:   cupertino_icons: ^1.0.6
34:   flutter_riverpod: ^2.4.10
35:   google_fonts: ^6.1.0
36:   fl_chart: ^0.65.0
37:   json_annotation: ^4.9.0
38:   path_provider: ^2.1.2
39: 
40: dev_dependencies:
41:   flutter_test:
42:     sdk: flutter
43:   flutter_lints: ^5.0.0
44:   build_runner: ^2.4.8
45:   json_serializable: ^6.7.1
46: 
47: # For information on the generic Dart part of this file, see the
48: # following page: https://dart.dev/tools/pub/pubspec
49: 
50: # The following section is specific to Flutter packages.
51: flutter:
52: 
53:   # The following line ensures that the Material Icons font is
54:   # included with your application, so that you can use the icons in
55:   # the material Icons class.
56:   uses-material-design: true
57: 
58:   # To add assets to your application, add an assets section, like this:
59:   # assets:
60:   #   - images/a_dot_burr.jpeg
61:   #   - images/a_dot_ham.jpeg
62: 
63:   # An image asset can refer to one or more resolution-specific "variants", see
64:   # https://flutter.dev/to/resolution-aware-images
65: 
66:   # For details regarding adding assets from package dependencies, see
67:   # https://flutter.dev/to/asset-from-package
68: 
69:   # To add custom fonts to your application, add a fonts section here,
70:   # in this "flutter" section. Each entry in this list should have a
71:   # "family" key with the font family name, and a "fonts" key with a
72:   # list giving the asset and other descriptors for the font. For
73:   # example:
74:   # fonts:
75:   #   - family: Schyler
76:   #     fonts:
77:   #       - asset: fonts/Schyler-Regular.ttf
78:   #       - asset: fonts/Schyler-Italic.ttf
79:   #         style: italic
80:   #   - family: Trajan Pro
81:   #     fonts:
82:   #       - asset: fonts/TrajanPro.ttf
83:   #       - asset: fonts/TrajanPro_Bold.ttf
84:   #         weight: 700
85:   #
86:   # For details regarding fonts from package dependencies,
87:   # see https://flutter.dev/to/font-from-package
```

## File: README.md
```markdown
 1: # conquest_calculator
 2: 
 3: A new Flutter project.
 4: 
 5: ## Getting Started
 6: 
 7: This project is a starting point for a Flutter application.
 8: 
 9: A few resources to get you started if this is your first Flutter project:
10: 
11: - [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
12: - [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
13: 
14: For help getting started with Flutter development, view the
15: [online documentation](https://docs.flutter.dev/), which offers tutorials,
16: samples, guidance on mobile development, and a full API reference.
```
