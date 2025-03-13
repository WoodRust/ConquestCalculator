# Conquest Calculator - Implementation Checklist

## Phase 1: Foundation

### Step 1: Project Setup and Core Domain Models

- [ ] Create new Flutter project "conquest_calculator"
- [ ] Set up folder structure
  - [ ] domain/models
  - [ ] domain/repositories
  - [ ] domain/usecases
  - [ ] data/repositories
  - [ ] data/sources
  - [ ] data/dto
  - [ ] presentation/providers
  - [ ] presentation/screens
  - [ ] presentation/widgets
  - [ ] presentation/themes
- [ ] Add dependencies to pubspec.yaml
  - [ ] flutter_riverpod
  - [ ] google_fonts
  - [ ] fl_chart
  - [ ] json_annotation
  - [ ] path_provider
- [ ] Create Regiment model
  - [ ] Define RegimentType enum (infantry, cavalry, brute, monster, chariot)
  - [ ] Define RegimentClass enum (light, medium, heavy)
  - [ ] Implement Regiment class with all fields
  - [ ] Add documentation
- [ ] Create RegimentRepository interface
  - [ ] Define getAllRegiments() method
  - [ ] Define getRegimentsByFaction() method
  - [ ] Define getRegimentByName() method
- [ ] Write unit tests for Regiment model

### Step 2: Data Transfer Objects and Repository Implementation

- [ ] Create RegimentDto class
  - [ ] Implement fields matching JSON structure
  - [ ] Create fromJson factory constructor
  - [ ] Create toJson method
  - [ ] Implement toRegiment() conversion method
  - [ ] Handle proper type conversion
- [ ] Implement RegimentLocalDataSource
  - [ ] Create method to load JSON from assets
  - [ ] Implement getRegiments(faction) method
  - [ ] Implement getAllRegiments() method
  - [ ] Add error handling
- [ ] Implement RegimentRepositoryImpl
  - [ ] Inject RegimentLocalDataSource
  - [ ] Implement getAllRegiments()
  - [ ] Implement getRegimentsByFaction()
  - [ ] Implement getRegimentByName()
- [ ] Create sample JSON data files
  - [ ] Create assets/data/regiments folder
  - [ ] Create dweghom.json with sample data
  - [ ] Create hundred_kingdoms.json with sample data
  - [ ] Create nords.json with sample data
- [ ] Update pubspec.yaml to include assets
- [ ] Write unit tests for data layer

### Step 3: Combat Simulation Models

- [ ] Create DiceResult class
  - [ ] Add fields: successes, failures, total
  - [ ] Create constructor
  - [ ] Implement fromRoll factory method for probability calculation
  - [ ] Add documentation
- [ ] Create CombatSimulation class
  - [ ] Add fields for attacker and defender Regiments
  - [ ] Add fields for stand counts
  - [ ] Add fields for combat modifiers (charge, impact, flank, rear)
  - [ ] Add specialRulesInEffect map
  - [ ] Add DiceResult fields for hit, defense, and resolve rolls
  - [ ] Create constructor
  - [ ] Add documentation
- [ ] Write unit tests for combat simulation models

## Phase 2: Core Logic

### Step 4: Combat Calculation Use Case

- [ ] Create CalculateCombat class
  - [ ] Implement calculateExpectedResult method
  - [ ] Create helper method for total attack calculation
  - [ ] Implement hit probability calculation
  - [ ] Implement defense roll calculation
  - [ ] Implement resolve test calculation
  - [ ] Handle special rules (Shield, Cleave, etc.)
  - [ ] Apply flank/rear modifiers correctly
- [ ] Write unit tests for combat calculation
  - [ ] Test basic attack calculation
  - [ ] Test impact attacks
  - [ ] Test defense calculations
  - [ ] Test resolve tests
  - [ ] Test special rule interactions
  - [ ] Test flank/rear attack scenarios

## Phase 3: Presentation Layer

### Step 5: State Management with Riverpod

- [ ] Create RegimentProvider
  - [ ] Implement regimentRepositoryProvider
  - [ ] Create allRegimentsProvider
  - [ ] Create regimentsByFactionProvider
  - [ ] Create regimentByNameProvider
- [ ] Create CombatState class
  - [ ] Add fields for attacker/defender
  - [ ] Add fields for stand counts
  - [ ] Add fields for combat modifiers
  - [ ] Add field for specialRulesInEffect
  - [ ] Add field for CombatSimulation result
  - [ ] Implement copyWith method
- [ ] Create CombatNotifier class
  - [ ] Inject CalculateCombat
  - [ ] Implement updateAttacker/updateDefender methods
  - [ ] Implement updateAttackerStands/updateDefenderStands methods
  - [ ] Implement toggle methods for combat modifiers
  - [ ] Implement toggleSpecialRule method
  - [ ] Create _recalculate private method
- [ ] Create combatProvider
- [ ] Update main.dart with ProviderScope
- [ ] Write tests for providers

### Step 6: Basic UI Screens

- [ ] Create AppTheme class
  - [ ] Define light theme
  - [ ] Define dark theme
  - [ ] Create custom color scheme
  - [ ] Define text styles
  - [ ] Define button styles
- [ ] Update main.dart
  - [ ] Add MaterialApp with theme
  - [ ] Set up initial routes
- [ ] Create RegimentSelectionScreen
  - [ ] Add faction parameter and selection callback
  - [ ] Implement regiment list view
  - [ ] Create regiment card design
  - [ ] Add loading/error states
- [ ] Create skeleton CombatCalculatorScreen
  - [ ] Add basic layout structure
  - [ ] Create placeholders for key sections
- [ ] Write widget tests for UI components

### Step 7: Combat Calculator UI

- [ ] Create TargetSelector widget
  - [ ] Implement dropdown-based selection
  - [ ] Add callback for value changes
  - [ ] Add styling customization
- [ ] Enhance CombatCalculatorScreen
  - [ ] Implement attacker selection section
  - [ ] Implement defender selection section
  - [ ] Add stand count selectors
  - [ ] Create combat modifier toggles
  - [ ] Add results display area
- [ ] Implement faction selection flow
  - [ ] Create bottom sheet with main factions
  - [ ] Add dialog for more factions
  - [ ] Set up navigation to RegimentSelectionScreen
- [ ] Connect UI to CombatProvider
  - [ ] Update provider state on selection changes
  - [ ] Add Consumer widgets for state observation
  - [ ] Implement loading indicators
- [ ] Write widget tests for combat calculator UI

## Phase 4: Visualization

### Step 8: Combat Results Visualization

- [ ] Create WavePainter class
  - [ ] Implement paint method for wave drawing
  - [ ] Add color calculation based on probabilities
  - [ ] Implement expected success marker
  - [ ] Add text annotations
- [ ] Create WaveSlider widget
  - [ ] Set up CustomPaint with WavePainter
  - [ ] Implement interactive sliding (optional)
  - [ ] Add value display
  - [ ] Handle size constraints
- [ ] Enhance CombatCalculatorScreen with visualizations
  - [ ] Add hit roll wave slider
  - [ ] Add defense roll wave slider
  - [ ] Add resolve roll wave slider
  - [ ] Create summary statistics section
  - [ ] Design card-based layout for results
- [ ] Write tests for visualization components

## Phase 5: Integration and Polish

### Step 9: Integration and Final Touches

- [ ] Complete CombatCalculatorScreen integration
  - [ ] Ensure all components work together
  - [ ] Add proper loading states
  - [ ] Implement error handling
  - [ ] Add breaking probability calculation
- [ ] Improve faction selection
  - [ ] Add structure to faction selection
  - [ ] Ensure smooth navigation
  - [ ] Add visual faction indicators
- [ ] Add summary cards
  - [ ] Create collapsed summary view
  - [ ] Highlight key statistics
  - [ ] Add color coding for outcomes
- [ ] Final UI polish
  - [ ] Review and standardize padding/spacing
  - [ ] Check typography hierarchy
  - [ ] Test responsiveness on different screen sizes
  - [ ] Ensure theme consistency
- [ ] Comprehensive testing
  - [ ] Run all unit tests
  - [ ] Run widget tests
  - [ ] Perform manual testing on different devices
  - [ ] Fix any remaining issues

## Documentation and Deployment

- [ ] Add README.md
  - [ ] Project description
  - [ ] Setup instructions
  - [ ] Usage guide
  - [ ] Screenshots
- [ ] Create sample data for all factions
  - [ ] Complete dweghom.json
  - [ ] Complete hundred_kingdoms.json
  - [ ] Complete nords.json
  - [ ] Add data for other factions
- [ ] Final code review
  - [ ] Check for unused code
  - [ ] Verify naming conventions
  - [ ] Review documentation
  - [ ] Check for performance issues
- [ ] Prepare for release
  - [ ] Update app version
  - [ ] Configure build settings
  - [ ] Create app icons
  - [ ] Write release notes

## Stretch Goals

- [ ] Add ranged combat calculations
- [ ] Implement spellcasting simulation
- [ ] Add result history storage
- [ ] Create result comparison view
- [ ] Add unit images/icons
- [ ] Implement multi-round simulation