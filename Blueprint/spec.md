# Conquest Probability Calculator - Technical Specification

## Project Overview
The Conquest Probability Calculator is a mobile application designed to help players of the tabletop wargame "Conquest: The Last Argument of Kings" make informed tactical decisions by providing mathematical predictions for combat outcomes. The app will calculate probability distributions for combat interactions between units, supporting melee combat, ranged attacks, spell damage, and character duels with comprehensive special rule support.

## Architecture

### Clean Architecture with Feature-Based Organization
The application follows a clean architecture approach with a feature-based organization:

```
lib/
├── domain/
│   ├── models/         # Core game entities
│   ├── repositories/   # Abstract data access definitions
│   └── usecases/       # Business logic for calculations
├── data/
│   ├── repositories/   # Implementation of domain repositories
│   ├── sources/        # Data sources (local JSON)
│   └── dto/            # Data transfer objects
├── presentation/
│   ├── providers/      # Riverpod state management
│   ├── screens/        # Application screens
│   ├── widgets/        # Reusable UI components
│   └── themes/         # Visual styling
└── main.dart           # Application entry point
```

### State Management
- Riverpod will be used for state management throughout the application
- Key providers:
  - `regimentRepositoryProvider`: Provides access to regiment data
  - `combatProvider`: Manages combat configuration and calculation state
  - `resultHistoryProvider`: Manages stored calculation results for comparison
  - `listManagerProvider`: Manages custom army lists

## Core Features

### 1. Regiment Selection
- Users can select attacking and defending regiments from a categorized list
- Unit stats are automatically populated from JSON data
- Native special rules are automatically applied
- Users can specify:
  - Number of stands in each regiment
  - Number of engaged stands
- Character selection and attachment to regiments
- Option to switch between browsing all factions and loading custom army lists

### 2. Combat Configuration
- UI provides controls for situational modifiers:
  - Flank/rear attacks (toggle)
  - Impact attacks (auto-enabled for capable units)
  - Trample attacks (auto-enabled for capable units)
  - Clash attacks (auto-enabled by default)
  - Draw event effects (toggle for situational abilities)
  - Old Dominion tier selection (when applicable)
  - Terrain effects (dropdown/checkbox)
  - Defender obscured/lose formation status
  - Defender broken status
- Ranged combat options:
  - Volley (auto-enabled for units with barrage)
  - Arcing fire
  - Effective range toggle
  - Aimed shot
- Active modifiers are displayed with resulting characteristic adjustments for transparency
- Default options toggle on automatically based on unit capabilities

### 3. Duel Mode
- Character vs character combat calculation
- Simultaneous attack resolution
- Dual probability charts showing outcomes for both characters
- Death probability calculation for each character
- Support for character-specific special rules and items

### 4. Spell Integration
- Spell damage calculation
- Option to calculate spells alongside melee/ranged combat
- Support for entourage activation sequence
- Account for interference and scaling in spell casting
- Visual indicators for spell modifiers in effect

### 5. Probability Calculation
- Users configure options and tap "Calculate" to perform computation
- Each calculation is stored for potential comparison
- Calculation engine handles:
  - Impact attacks preceding clash attacks
  - Trample attacks from capable units
  - Support attacks from unengaged stands
  - Special rules modifying attacks (e.g., Support(X))
  - Special rules modifying defense (e.g., Cleave, Shield)
  - Morale/resolve tests with complete modifier support:
    - Stand count bonuses
    - Terrifying effects
    - Character bonuses
    - Faction-specific rules (e.g., Nords +1 after charge)
    - Indomitable effects
    - Broken status (lowest resolve characteristic)
  - Character-granted special rules (e.g., flurry from Vargyr, opportunists from Jarl)
  - Optional special rules (e.g., blessed, which can be toggled)

### 6. Results Visualization
- Line chart displays probability distribution of wounds
- X-axis represents number of wounds
- Y-axis represents probability
- Clear threshold annotations for:
  - Stand loss boundaries
  - Breaking point (half or more stands lost)
  - Regiment destruction
- Users can toggle multiple calculation results on the same graph for comparison
- Swipe-to-delete stored results
- Optional cumulative probability overlay
- Detailed combat summary with:
  - Expected hits, expected wounds, and expected stands lost
  - Explicit display of all target values in use
  - List of all active modifiers and their effects
  - Base values and modified values clearly differentiated
  - Impact and trample attack results

### 7. Army List Management
- Create and save custom army lists
- Toggle between browsing all factions and loading custom lists
- Auto-detection of list-specific abilities and modifiers
- Character attachment validation based on list rules

### 8. Result Storage and Sharing
- Auto-naming of saved combat interactions
- Format: "[Attacker](stands) vs [Defender](stands) - [situational effects]"
- Option to manually rename saved calculations
- Compare multiple calculation results side-by-side
- Share calculation results with other players

## Data Management

### Regiment Database
- JSON files organized by faction
- JSON structure to be optimized for calculation:
```json
{
  "name": "Regiment Name",
  "faction": "Faction Name",
  "type": "infantry",
  "regimentClass": "light",
  "characteristics": {
    "march": 6,
    "volley": 1,
    "clash": 3,
    "attacks": 6,
    "wounds": 5,
    "resolve": 4,
    "defense": 3,
    "evasion": 0
  },
  "specialRules": [
    {
      "name": "Shield",
      "description": "..."
    }
  ],
  "numericSpecialRules": {
    "impact": 3,
    "support": 2,
    "barrage": 4,
    "wizard": 6,
    "trample": 2,
    "indomitable": 1,
    "terrifying": 2
  },
  "drawEvents": [...],
  "points": 160,
  "pointsPerAdditionalStand": 50
}
```

### Result Storage
- Combat calculation results are persisted locally using shared preferences or SQLite
- Each result includes:
  - Units involved
  - Configuration settings
  - Timestamp
  - Full probability distribution
  - Auto-generated name
  - Active modifiers list
- Results can be compared on the visualization graph by toggling them on/off

### Army List Storage
- Custom army lists stored locally in JSON format
- List validation against faction rules
- Support for character attachments and restrictions

## User Interface Flow

1. **Main Screen**
   - List of factions or army lists for selection
   - Toggle between faction browser and list manager
   - Quick access to recent calculations

2. **Regiment Selection Screen**
   - Faction-based list of regiments
   - Character-only filtering option
   - Filtering options and search
   - Regiment stat summary cards

3. **Combat Calculator Screen**
   - Attacker and defender selection with stand configuration
   - Character attachment interface
   - Combat situation modifiers with auto-enabled defaults
   - Spell casting interface (when applicable)
   - Duel mode toggle for character-vs-character combat
   - "Calculate" button
   - Results visualization graph
   - Detailed combat summary with all modifiers
   - List of stored calculations for comparison

4. **Army List Management Screen**
   - List creation and editing interface
   - Regiment selection and point calculation
   - Character attachment management
   - List validation

## Technical Implementation Details

### Combat Calculation Engine
The combat calculation engine will handle probability distributions using either:
1. Monte Carlo simulation for complex interactions (10,000+ simulations)
2. Direct mathematical probability calculation for simpler interactions

Key calculations include:
- Attack dice generation based on:
  - Engaged stands * attacks value
  - Support attacks from unengaged stands
  - Impact attacks (if applicable)
  - Trample attacks (if applicable)
  - Special rules modifying attack counts
- Hit probability based on clash/impact values
- Defense/save probability incorporating special rules
- Resolve test probability with all applicable modifiers:
  - Stand count bonuses
  - Terrifying effects
  - Faction-specific modifiers
  - Broken status
  - Character bonuses
  - Indomitable effects
- Probability of reaching critical thresholds (stand loss, breaking, destruction)
- Spell damage calculation with interference and scaling
- Duel outcome calculation for both characters

### Special Rules System
- Comprehensive implementation of all game special rules
- Dynamic rule activation based on unit type
- Rule stacking and precedence handling
- Support for situation-dependent rules
- Character-granted rule implementation
- Optional rule toggling (e.g., blessed, flurry with specific characters)

### Optimizations
- Memoization of probability calculations
- Background processing for complex calculations
- Efficient state management to avoid unnecessary recalculations
- Binary probability distribution representation for memory efficiency

## Error Handling

1. **Data Loading Errors**
   - Graceful fallback to default values
   - User-friendly error messages with retry options
   - Logging for debugging

2. **Calculation Errors**
   - Boundary checking for all inputs
   - Validations to prevent impossible configurations
   - Exception handling with user feedback

3. **UI State Errors**
   - State restoration on app resume
   - Defensive programming to prevent UI inconsistencies

## Testing Strategy

1. **Unit Tests**
   - Combat calculation engine accuracy
   - Regiment data parsing and validation
   - Special rule application logic
   - Probability distribution correctness

2. **Widget Tests**
   - UI component rendering
   - User interaction flows
   - State management

3. **Integration Tests**
   - End-to-end calculation workflow
   - Data persistence
   - List management functionality

4. **Performance Testing**
   - Calculation speed benchmarks
   - Memory usage profiling
   - State management efficiency

## Development Roadmap

### Phase 1: Foundation (2 weeks)
- Project setup with clean architecture
- Basic data models and repositories
- JSON parsing and validation
- UI framework and navigation

### Phase 2: Core Calculator (3 weeks)
- Melee combat calculation engine
- Basic regiment selection interface
- Combat configuration UI
- Simple probability output

### Phase 3: Visualization (2 weeks)
- Line chart implementation
- Threshold annotations
- Result comparison functionality
- Result storage and management

### Phase 4: Advanced Combat Features (3 weeks)
- Impact and trample mechanics
- Enhanced resolve calculations with all modifiers
- Ranged combat options
- Situational modifiers
- Character effect system
- Optional rule toggling

### Phase 5: Spell and Duel Systems (2 weeks)
- Spell damage calculation
- Spell casting modifiers (interference, scaling)
- Enhanced duel mode with dual outcomes
- Character-specific abilities

### Phase 6: Army Lists and Polish (2 weeks)
- Army list management
- Enhanced result comparison
- Result sharing
- UI refinement and animation
- Performance optimization

## Non-Functional Requirements

1. **Performance**
   - Combat calculations complete in under 1 second for standard configurations
   - UI remains responsive during calculations
   - App startup time under 3 seconds

2. **Usability**
   - Clear, intuitive interface suitable for mid-game use
   - Consistent visual feedback for user actions
   - Responsive design for different screen sizes
   - Readable chart visualization
   - Auto-defaults for common unit abilities

3. **Reliability**
   - Graceful handling of JSON format changes
   - No crashes during normal operation
   - Data persistence across app restarts
   - Accurate implementation of game rules

## Future Expansion Considerations
- Ranged combat (Volley actions) calculation
- Magical effects and spell damage calculation
- Multiple-round combat simulation
- Army builder integration
- Battle simulation capabilities
- Cloud synchronization of army lists
- Game state tracking for ongoing battles

This specification provides a comprehensive roadmap for implementing the Conquest Probability Calculator, with a focus on accurately modeling the game's complex combat mechanics. The architecture and design principles allow for easy extension to additional features based on user feedback and evolving requirements.