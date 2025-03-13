# Conquest Probability Calculator Project Implementation Plan

This document outlines a detailed, step-by-step approach to building the Conquest Probability Calculator Flutter application. Each step is broken down into manageable tasks with specific prompts for a code-generation LLM to implement in a test-driven manner.

## Project Overview

The Conquest Probability Calculator is a Flutter application that helps players of the tabletop wargame "Conquest: The Last Argument of Kings" calculate combat probabilities. The app will:

1. Allow selection of attacker and defender units
2. Configure combat parameters (stands, positioning, special rules)
3. Calculate probability distributions for combat outcomes
4. Visualize results with threshold annotations

## Implementation Steps

### Phase 1: Foundation

#### Step 1: Project Setup and Core Domain Models

```
Create a new Flutter project named "conquest_calculator" with Flutter SDK 3.6.2 or higher. Set up the basic project structure following clean architecture principles with domain, data, and presentation layers. Implement the core domain model for a Regiment in the game Conquest, including:

1. Create a Regiment class with the following properties:
   - name (String)
   - faction (String)
   - type (enum: infantry, cavalry, brute, monster, chariot)
   - regimentClass (enum: light, medium, heavy)
   - characteristics (march, volley, clash, attacks, wounds, resolve, defense, evasion)
   - specialRules (List<String>)
   - drawEvents (List<String>)

2. Create a repository interface (RegimentRepository) with methods:
   - getAllRegiments()
   - getRegimentsByFaction(String faction)
   - getRegimentByName(String name)

Include appropriate tests for the domain models. Use proper naming conventions and documentation.
```

#### Step 2: Data Transfer Objects and Repository Implementation

```
Building on the previous step with the Regiment domain model and RegimentRepository interface, implement the data layer components:

1. Create a RegimentDto class that:
   - Maps to/from JSON
   - Converts between DTO and domain model
   - Handles special rules parsing
   - Includes a fromJson factory constructor and toJson method

2. Create a RegimentLocalDataSource class that:
   - Loads regiment data from JSON files in assets
   - Provides methods to get all regiments or regiments by faction
   - Handles basic error cases

3. Implement RegimentRepositoryImpl that:
   - Uses the RegimentLocalDataSource
   - Implements the RegimentRepository interface
   - Maps DTOs to domain models

4. Create a sample JSON file for testing with at least 2-3 different regiment types

Include appropriate unit tests for all components. Add the necessary dependencies to pubspec.yaml for JSON handling.
```

#### Step 3: Combat Simulation Models

```
Building on the Regiment model and repository implementation, create the core models for combat simulation:

1. Create a DiceResult class to represent the outcome of dice rolls:
   - Properties: successes, failures, total
   - Factory method for creating expected probability distributions
   - Methods to calculate success rates

2. Create a CombatSimulation class to represent a combat scenario:
   - Properties for attacker and defender (Regiment)
   - Number of stands for each
   - Combat modifiers (isCharge, isImpact, isFlank, isRear)
   - Map of special rules in effect
   - DiceResult objects for hit rolls, defense rolls, and resolve rolls

Make sure these models are immutable and properly structured for the probability calculations. Add appropriate tests for these models, particularly focusing on the DiceResult factory method for probability calculations.
```

### Phase 2: Core Logic

#### Step 4: Combat Calculation Use Case

```
Implement the core combat calculation logic by creating a CalculateCombat use case:

1. Create a CalculateCombat class with a method calculateExpectedResult that:
   - Takes attacker regiment, defender regiment, number of stands, and combat parameters
   - Calculates total attacks based on engaged stands, support attacks, and special rules
   - Determines hit probability based on clash value and modifiers
   - Computes defense rolls based on defense/evasion values
   - Calculates morale test outcomes
   - Returns a CombatSimulation object with the results

2. Implement helper methods for:
   - Calculating total attacks (_calculateTotalAttacks)
   - Applying special rules like Cleave, Shield, etc.
   - Handling flank/rear modifiers

Include comprehensive unit tests that verify:
- Impact attack calculations
- Regular clash attack calculations
- Defense roll calculations
- Morale test calculations
- Special rule interactions

Focus on accuracy and clean implementation rather than optimization at this stage.
```

### Phase 3: Presentation Layer

#### Step 5: State Management with Riverpod

```
Implement the state management layer using Riverpod:

1. Create a RegimentProvider with:
   - Provider for RegimentRepository
   - FutureProvider for all regiments
   - FutureProvider.family for regiments by faction
   - FutureProvider.family for regiment by name

2. Create a CombatProvider (StateNotifier) with:
   - CombatState class containing all combat parameters
   - Methods to update attacker, defender, stand counts
   - Methods to toggle combat modifiers (charge, impact, flank, etc.)
   - Method to recalculate combat simulation results

3. Wire the providers together in the main.dart file with ProviderScope

Include appropriate tests for the providers using ProviderContainer for testing. Make sure state updates correctly propagate and that the combat calculation is triggered when parameters change.
```

#### Step 6: Basic UI Screens

```
Implement the basic UI screens for the application:

1. Create a basic AppTheme class with:
   - Light and dark themes
   - Custom color scheme
   - Text styles
   - Button styles

2. Create the main app structure in main.dart using MaterialApp with:
   - Theme setup
   - Home screen routing

3. Implement a RegimentSelectionScreen with:
   - Faction selection
   - Regiment listing
   - Search functionality
   - Regiment selection callback

4. Create a basic widget for displaying regiment details.

Implement basic navigation between screens and ensure the UI matches the fantasy theme of the game. No need for complex animations at this stage, focus on functionality and clean UI structure.
```

#### Step 7: Combat Calculator UI

```
Build on the previous UI implementation to create the Combat Calculator screen:

1. Create a CombatCalculatorScreen that:
   - Shows selected attacker and defender
   - Provides controls for number of stands
   - Includes toggle controls for combat modifiers
   - Has a calculate button

2. Implement a TargetSelector widget for selecting the number of stands

3. Connect the UI to the CombatProvider to:
   - Update state when selections change
   - Trigger calculations
   - Display loading state during calculation

Keep the UI clean and user-friendly with appropriate spacing and typography. Make sure the state updates correctly when user interacts with the UI elements.
```

### Phase 4: Visualization

#### Step 8: Combat Results Visualization

```
Implement the visualization components for displaying combat results:

1. Create a custom WaveSlider widget that:
   - Displays a probability distribution as a wave
   - Shows expected success rate
   - Indicates thresholds for breaking, casualties, etc.
   - Uses custom drawing with CustomPainter

2. Create a WavePainter class that:
   - Renders the wave shape
   - Colors sections based on probability thresholds
   - Adds markers for critical points
   - Provides visual feedback

3. Enhance the CombatCalculatorScreen to display:
   - Hit roll probability wave
   - Defense roll probability wave
   - Resolve roll probability wave
   - Summary statistics

Make the visualization intuitive and helpful for decision-making. Use appropriate colors to indicate favorable vs. unfavorable outcomes. Ensure the UI is responsive and works well on different screen sizes.
```

### Phase 5: Integration and Polish

#### Step 9: Integration and Final Touches

```
Complete the application by integrating all components and adding final touches:

1. Connect regiment selection to combat calculator:
   - Implement navigation between screens
   - Pass selected regiments to combat calculator
   - Add faction icons and visual cues

2. Add error handling:
   - Graceful handling of missing data
   - User-friendly error messages
   - Retry mechanisms

3. Optimize performance:
   - Memoize calculations where appropriate
   - Use efficient state management
   - Minimize rebuilds

4. Add final UI polish:
   - Consistent styling
   - Intuitive layout
   - Responsive design

Test the complete application flow from regiment selection through combat calculation to results visualization. Ensure everything works together seamlessly and the user experience is smooth.
```

## LLM Prompts for Implementation

Below are the detailed prompts for a code-generation LLM to implement each step:

### Prompt 1: Project Setup and Core Domain Models

```
I'm building a Flutter application called "Conquest Calculator" for calculating combat probabilities in a tabletop wargame called "Conquest: The Last Argument of Kings". I need to start by setting up the project structure and implementing the core domain models.

Please create:

1. A proper Flutter project structure following clean architecture with folders for:
   - domain (models, repositories, usecases)
   - data (repositories, sources, dtos)
   - presentation (providers, screens, widgets, themes)

2. A Regiment model in the domain layer with:
   - name (String)
   - faction (String)
   - type (enum: infantry, cavalry, brute, monster, chariot)
   - regimentClass (enum: light, medium, heavy)
   - march (int)
   - volley (int)
   - clash (int)
   - attacks (int)
   - wounds (int)
   - resolve (int)
   - defense (int)
   - evasion (int)
   - specialRules (List<String>)
   - drawEvents (List<String>)

3. A RegimentRepository interface with methods:
   - Future<List<Regiment>> getAllRegiments();
   - Future<List<Regiment>> getRegimentsByFaction(String faction);
   - Future<Regiment?> getRegimentByName(String name);

Use proper immutable models and include appropriate documentation.

Also include a pubspec.yaml file with the necessary dependencies, including:
- flutter_riverpod
- any packages needed for UI and JSON handling

I'm using Flutter SDK 3.6.2 or higher.
```

### Prompt 2: Data Transfer Objects and Repository Implementation

```
Building on our Conquest Calculator project, let's implement the data layer for handling regiment data. I need to create DTOs, a local data source, and the repository implementation.

Using the Regiment domain model and RegimentRepository interface from before, please implement:

1. A RegimentDto class that:
   - Represents the JSON structure of regiment data
   - Has a fromJson factory constructor
   - Has a toJson method
   - Has a toRegiment method to convert to the domain model
   - Properly handles the enums from the domain model

2. A RegimentLocalDataSource that:
   - Loads regiment data from JSON files in assets/data/regiments/{faction}.json
   - Has methods to get regiments by faction
   - Has a method to get all regiments from all faction files
   - Properly handles errors (e.g., if a file doesn't exist)

3. A RegimentRepositoryImpl that:
   - Implements the RegimentRepository interface
   - Uses the RegimentLocalDataSource
   - Maps DTOs to domain models

4. Update pubspec.yaml to include:
   - Asset references for regiment data files

Create a sample JSON regiment data file format that would work with this implementation. The sample should include 2-3 different regiment types with realistic statistics.

Focus on clean implementation, proper error handling, and type safety.
```

### Prompt 3: Combat Simulation Models

```
Now let's continue building the Conquest Calculator by implementing the core models for combat simulation. Building on the Regiment model we already have, I need to create models to represent dice rolls and combat simulations.

Please create:

1. A DiceResult class in the domain/models folder:
   - Properties: int successes, int failures, int total
   - Named constructor
   - Factory method fromRoll({required int dice, required int target}) that creates a DiceResult with expected probability distribution
   - The factory should calculate expected successes based on the probability (target/6)

2. A CombatSimulation class in the domain/models folder:
   - Properties for attacker and defender (Regiment)
   - Properties for numAttackerStands and numDefenderStands (int)
   - Boolean properties: isCharge, isImpact, isFlank, isRear
   - Map<String, bool> specialRulesInEffect to track which special rules are active
   - DiceResult properties: hitRoll, defenseRoll, resolveRoll
   - Constructor that takes all these parameters

These models should be immutable and focused on representing the data structure needed for combat calculations. Don't implement the calculation logic yet - we'll do that in the next step.

Make sure both classes have proper documentation and clear, clean implementations.
```

### Prompt 4: Combat Calculation Use Case

```
Let's implement the core combat calculation logic for our Conquest Calculator. This is the heart of the application that will calculate probability distributions for combat outcomes.

Please create a CalculateCombat class in the domain/usecases folder that:

1. Has a method called calculateExpectedResult that:
   - Takes parameters: Regiment attacker, int numAttackerStands, Regiment defender, int numDefenderStands, plus boolean flags for isCharge, isImpact, isFlank, isRear, and a Map<String, bool> specialRulesInEffect
   - Returns a CombatSimulation object

2. Implements the calculation logic:
   - Calculate total attacks based on the number of stands, whether they're engaged, support attacks, etc.
   - Determine hit probability based on clash value (or impact value for impact attacks)
   - Compute defense rolls based on defense/evasion values and modifiers
   - Calculate morale test outcomes

3. Includes helper methods:
   - _calculateTotalAttacks to determine the number of attacks
   - Logic to handle special rules like Cleave, Shield, Flurry, etc.
   - Logic to apply flanking/rear attack modifiers

The implementation should focus on calculating expected probabilities rather than simulating individual dice rolls. Use the DiceResult.fromRoll factory method we created earlier to generate the expected probability distributions.

For special rules, implement at least these basics:
- Shield (+1 Defense against front attacks)
- Cleave (reduces defender's Defense)
- Flurry (re-roll failed hit rolls)
- Support(X) (unengaged stands contribute X support attacks instead of 1)

Keep the implementation clean, well-documented, and focused on accurately representing the game mechanics.
```

### Prompt 5: State Management with Riverpod

```
Now that we have our core models and calculation logic, let's implement the state management layer using Riverpod for our Conquest Calculator.

Please create:

1. A RegimentProvider in the presentation/providers folder:
   - Provider for RegimentRepository
   - FutureProvider for all regiments
   - FutureProvider.family for regiments by faction
   - FutureProvider.family for regiment by name

2. A CombatState class:
   - Properties for attacker and defender Regiment
   - Properties for numAttackerStands and numDefenderStands
   - Boolean properties for combat modifiers (isCharge, isImpact, isFlank, isRear)
   - Map<String, bool> for specialRulesInEffect
   - CombatSimulation? property for the current simulation result
   - copyWith method for immutable updates

3. A CombatNotifier extends StateNotifier<CombatState>:
   - Takes CalculateCombat in the constructor
   - Methods to update attacker, defender, stand counts
   - Methods to toggle combat modifiers
   - Private _recalculate method that runs the calculation when parameters change

4. A combatProvider using StateNotifierProvider

Ensure the providers are properly organized and that state updates trigger recalculations appropriately. Keep the implementation clean and focused on the state management concerns.
```

### Prompt 6: Basic UI Screens

```
Let's start building the UI for our Conquest Calculator. We'll begin by implementing the basic app structure and regiment selection screen.

Please create:

1. An AppTheme class in presentation/themes:
   - Light and dark themes using Material 3
   - Custom color scheme based on deep purple (primary) with fantasy game styling
   - Custom text styles using Google Fonts
   - Button styles with rounded corners

2. Update main.dart:
   - ProviderScope wrapping MaterialApp
   - Theme setup using AppTheme
   - Initial route to CombatCalculatorScreen

3. A RegimentSelectionScreen that:
   - Takes a parameter for faction and a callback onRegimentSelected
   - Uses a Consumer widget to watch the regimentsByFactionProvider
   - Displays a list of regiments with their basic stats
   - Has a clean, card-based design for regiment entries

4. Add a simple skeleton for CombatCalculatorScreen (we'll flesh it out in the next step)

Focus on clean UI implementation with proper widget composition and state management. Use Card widgets for regiment entries and make sure the UI is responsive.
```

### Prompt 7: Combat Calculator UI

```
Now let's implement the main Combat Calculator screen UI for our Conquest Calculator app.

Please create:

1. A TargetSelector widget that:
   - Allows selection of a number from 1 to a specified limit
   - Uses a dropdown for selection
   - Takes a callback for when the value changes
   - Has customizable styling (text size, colors)

2. Enhance the CombatCalculatorScreen:
   - Section for attacker selection with name display and stand selection
   - Section for defender selection with name display and stand selection
   - Combat modifier toggles (charge, impact, flank, rear attacks)
   - Results display area (placeholder for now)
   - "Select" buttons that present a bottom sheet with faction options

3. Add faction selection flow:
   - Bottom sheet with primary factions (Dweghom, Hundred Kingdoms, Nords)
   - Dialog with additional factions when "More Factions..." is selected
   - Navigation to RegimentSelectionScreen when faction is selected

4. Connect the UI to CombatProvider:
   - Update provider state when selections change
   - Use Consumer widgets to watch for state changes

Focus on creating a clean, intuitive UI that follows Material Design principles while maintaining the fantasy theme. Make sure the layout works well on different screen sizes.
```

### Prompt 8: Combat Results Visualization

```
Let's implement the visualization components for displaying combat results in our Conquest Calculator.

Please create:

1. A WavePainter class that extends CustomPainter:
   - Takes parameters for sliderPosition, dragPercentage, expectedSuccessPercentage, numDice, and expectedSuccesses
   - Draws a wave shape representing probability distribution
   - Colors sections based on probability (red for poor outcomes, yellow for neutral, green for good)
   - Adds markers for expected success threshold
   - Adds text annotations for dice count and expected successes

2. A WaveSlider widget that:
   - Uses the WavePainter
   - Displays a probability distribution as an interactive wave
   - Shows the expected success rate
   - Takes parameters for width, height, and callback
   - Displays the current value above the wave

3. Enhance the CombatCalculatorScreen to display:
   - Three WaveSlider widgets for hit, defense, and resolve rolls
   - Summary statistics (expected wounds, probability of breaking)
   - Clean, card-based layout for the results

Make the visualization intuitive and helpful for decision-making. The wave should clearly show the probability distribution and highlight critical thresholds. The UI should be responsive and work well on different screen sizes.
```

### Prompt 9: Integration and Final Touches

```
Let's complete our Conquest Calculator by integrating all components and adding final touches.

1. Finalize the CombatCalculatorScreen:
   - Make sure regiment selection, combat configuration, and results visualization are all connected
   - Add proper loading states when data is being fetched
   - Implement proper error handling for missing data or calculation errors
   - Add a helper function to calculate breaking probability

2. Improve the faction selection flow:
   - Add more structure to the faction selection
   - Ensure proper navigation between screens
   - Add visual cues for the faction selection (icons, colors)

3. Add summary cards:
   - Create a collapsed summary view of calculation results
   - Show key statistics prominently
   - Use color coding to indicate favorable/unfavorable outcomes

4. Add final polish:
   - Consistent padding and spacing
   - Proper typography hierarchy
   - Responsive layout adjustments
   - Theme consistency throughout the app

The final app should provide a smooth user experience from regiment selection through combat configuration to results visualization. The UI should be intuitive, responsive, and visually appealing while maintaining focus on the core functionality of calculating combat probabilities.
```

## Testing Strategy

For each implementation step, ensure proper testing:

1. **Unit Tests**:
   - Model validation and conversion
   - Repository pattern implementation
   - Combat calculation accuracy
   - Provider state management

2. **Widget Tests**:
   - UI component rendering
   - User interaction simulation
   - State updates in the UI

3. **Integration Tests** (where appropriate):
   - End-to-end flows
   - Data loading and processing

## Implementation Workflow Recommendations

1. **Iterative Development**:
   - Complete one step before moving to the next
   - Ensure tests pass before proceeding
   - Refactor as needed before adding new functionality

2. **Testing First**:
   - Write tests before implementation when possible
   - Verify behavior with tests before integration
   - Use test-driven development for complex logic

3. **Continuous Integration**:
   - Run tests frequently
   - Maintain code quality with static analysis
   - Document as you go