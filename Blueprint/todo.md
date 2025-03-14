# Conquest Calculator - Implementation Checklist

## Phase 1: Foundation

### Step 1: Project Setup and Core Domain Models
- [x] Create new Flutter project "conquest_calculator"
- [x] Set up folder structure
  - [x] domain/models
  - [x] domain/repositories
  - [x] domain/usecases
  - [x] data/repositories
  - [x] data/sources
  - [x] data/dto
  - [x] presentation/providers
  - [x] presentation/screens
  - [x] presentation/widgets
  - [x] presentation/themes
- [x] Add dependencies to pubspec.yaml
  - [x] flutter_riverpod
  - [x] google_fonts
  - [x] fl_chart
  - [x] json_annotation
  - [x] path_provider
- [x] Create Regiment model
  - [x] Define RegimentType enum (infantry, cavalry, brute, monster, chariot)
  - [x] Define RegimentClass enum (light, medium, heavy)
  - [x] Implement Regiment class with all fields
  - [x] Add documentation
- [x] Create RegimentRepository interface
  - [x] Define getAllRegiments() method
  - [x] Define getRegimentsByFaction() method
  - [x] Define getRegimentByName() method
- [x] Write unit tests for Regiment model

### Step 2: Data Transfer Objects and Repository Implementation
- [x] Create RegimentDto class
  - [x] Implement fields matching JSON structure
  - [x] Create fromJson factory constructor
  - [x] Create toJson method
  - [x] Implement toRegiment() conversion method
  - [x] Handle proper type conversion
- [x] Implement RegimentLocalDataSource
  - [x] Create method to load JSON from assets
  - [x] Implement getRegiments(faction) method
  - [x] Implement getAllRegiments() method
  - [x] Add error handling
- [x] Implement RegimentRepositoryImpl
  - [x] Inject RegimentLocalDataSource
  - [x] Implement getAllRegiments()
  - [x] Implement getRegimentsByFaction()
  - [x] Implement getRegimentByName()
- [ ] Create sample JSON data files
  - [x] Create assets/data/regiments folder
  - [x] Create dweghom.json with sample data
  - [x] Create hundred_kingdoms.json with sample data
  - [x] Create nords.json with sample data
  - [ ] Create additional faction JSON files (spires, old_dominion, wadrhun, etc.)
  - [ ] Expand regiment data with comprehensive special rules
- [x] Update pubspec.yaml to include assets
- [x] Write unit tests for data layer

### Step 3: Combat Simulation Models
- [x] Create DiceResult class
  - [x] Add fields: successes, failures, total
  - [x] Create constructor
  - [x] Implement fromRoll factory method for probability calculation
  - [x] Add documentation
- [x] Create CombatSimulation class
  - [x] Add fields for attacker and defender Regiments
  - [x] Add fields for stand counts
  - [x] Add fields for combat modifiers (charge, impact, flank, rear)
  - [x] Add specialRulesInEffect map
  - [x] Add DiceResult properties: hitRoll, defenseRoll, resolveRoll
  - [x] Create constructor
  - [x] Add documentation
- [ ] Write unit tests for combat simulation models

## Phase 2: Core Logic

### Step 4: Combat Calculation Use Case
- [x] Create CalculateCombat class
  - [x] Implement calculateExpectedResult method
  - [x] Create helper method for total attack calculation
  - [x] Implement hit probability calculation
  - [x] Implement defense roll calculation
  - [x] Implement resolve test calculation
  - [x] Handle basic special rules (Shield, Cleave, etc.)
  - [x] Apply flank/rear modifiers correctly
- [ ] Enhance probability calculations
  - [ ] Replace simplified calculations with proper probability distributions
  - [ ] Implement binomial probability distribution for hit rolls
  - [ ] Create proper calculation for wound distributions
  - [ ] Implement Monte Carlo simulation for complex interactions
  - [ ] Add support for more special rules from the game
  - [ ] Implement detailed rule interactions (e.g., Support, Flurry, Fearsome)
- [ ] Write comprehensive unit tests for combat calculation
  - [ ] Test basic attack calculation
  - [ ] Test impact attacks
  - [ ] Test defense calculations
  - [ ] Test resolve tests
  - [ ] Test special rule interactions
  - [ ] Test flank/rear attack scenarios

## Phase 3: Presentation Layer

### Step 5: State Management with Riverpod
- [x] Create RegimentProvider
  - [x] Implement regimentRepositoryProvider
  - [x] Create allRegimentsProvider
  - [x] Create regimentsByFactionProvider
  - [x] Create regimentByNameProvider
- [x] Create CombatState class
  - [x] Add fields for attacker/defender
  - [x] Add fields for stand counts
  - [x] Add fields for combat modifiers
  - [x] Add field for specialRulesInEffect
  - [x] Add field for CombatSimulation result
  - [x] Implement copyWith method
- [x] Create CombatNotifier class
  - [x] Inject CalculateCombat
  - [x] Implement updateAttacker/updateDefender methods
  - [x] Implement updateAttackerStands/updateDefenderStands methods
  - [x] Implement toggle methods for combat modifiers
  - [x] Implement toggleSpecialRule method
  - [x] Create _recalculate private method
- [x] Create combatProvider
- [x] Update main.dart with ProviderScope
- [ ] Create ResultHistoryProvider
  - [ ] Implement storage of calculation results
  - [ ] Create state for managing multiple calculation results
  - [ ] Add methods for toggling visibility of saved results
- [ ] Write tests for providers

### Step 6: Basic UI Screens
- [x] Create AppTheme class
  - [x] Define light theme
  - [x] Define dark theme
  - [x] Create custom color scheme
  - [x] Define text styles
  - [x] Define button styles
- [x] Update main.dart
  - [x] Add MaterialApp with theme
  - [x] Set up initial routes
- [x] Create RegimentSelectionScreen
  - [x] Add faction parameter and selection callback
  - [x] Implement regiment list view
  - [x] Create regiment card design
  - [x] Add loading/error states
- [x] Create skeleton CombatCalculatorScreen
  - [x] Add basic layout structure
  - [x] Create placeholders for key sections
- [ ] Write widget tests for UI components

### Step 7: Combat Calculator UI
- [x] Create TargetSelector widget
  - [x] Implement dropdown-based selection
  - [x] Add callback for value changes
  - [x] Add styling customization
- [x] Enhance CombatCalculatorScreen
  - [x] Implement attacker selection section
  - [x] Implement defender selection section
  - [x] Add stand count selectors
  - [x] Create combat modifier toggles
  - [x] Add results display area
- [x] Implement faction selection flow
  - [x] Create bottom sheet with main factions
  - [x] Add dialog for more factions
  - [x] Set up navigation to RegimentSelectionScreen
- [x] Connect UI to CombatProvider
  - [x] Update provider state on selection changes
  - [x] Add Consumer widgets for state observation
  - [x] Implement loading indicators
- [ ] Create comprehensive special rules UI
  - [ ] Add UI for all relevant special rules
  - [ ] Create section for activating special abilities
  - [ ] Add dynamic special rule detection from regiment data
- [ ] Write widget tests for combat calculator UI

## Phase 4: Visualization

### Step 8: Combat Results Visualization
- [x] Create basic WavePainter class
  - [x] Implement paint method for wave drawing
  - [x] Add color calculation based on probabilities
  - [x] Implement expected success marker
  - [x] Add text annotations
- [x] Create basic WaveSlider widget
  - [x] Set up CustomPaint with WavePainter
  - [x] Implement interactive sliding
  - [x] Add value display
  - [x] Handle size constraints
- [ ] Replace WaveSlider with proper probability distribution graphs
  - [ ] Create ProbabilityDistributionChart widget using fl_chart
  - [ ] Implement proper bar or line chart visualization
  - [ ] Add X axis (wounds/dice) and Y axis (probability)
  - [ ] Create threshold markers for critical points (breaking, stand loss)
  - [ ] Implement color-coded sections based on outcomes
- [ ] Add visualization for multiple probability distributions
  - [ ] Show multiple data series on the same chart
  - [ ] Add legend for comparing different combat scenarios
  - [ ] Implement toggle controls for hiding/showing distributions
- [ ] Write tests for visualization components

## Phase 5: Integration and Polish

### Step 9: Integration and Final Touches
- [ ] Complete CombatCalculatorScreen integration
  - [ ] Ensure all components work together
  - [ ] Add proper loading states
  - [ ] Implement error handling
  - [ ] Add breaking probability calculation
- [ ] Implement persistent storage
  - [ ] Create model for stored combat calculations
  - [ ] Implement SharedPreferences or SQLite storage
  - [ ] Add UI for naming and saving calculations
  - [ ] Create history screen for viewing saved calculations
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

- [ ] Add comprehensive README.md
  - [ ] Project description
  - [ ] Setup instructions
  - [ ] Usage guide
  - [ ] Screenshots
- [ ] Create complete data for all factions
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