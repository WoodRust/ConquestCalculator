# Conquest Probability Calculator - Technical Specification

## Project Overview
The Conquest Probability Calculator is a mobile application designed to help players of the tabletop wargame "Conquest: The Last Argument of Kings" make informed tactical decisions by providing mathematical predictions for combat outcomes. The app will calculate probability distributions for combat interactions between units, supporting melee combat initially with plans to expand to ranged attacks and magic.

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

## Core Features

### 1. Regiment Selection
- Users can select attacking and defending regiments from a categorized list
- Unit stats are automatically populated from JSON data
- Native special rules are automatically applied
- Users can specify:
  - Number of stands in each regiment
  - Number of engaged stands

### 2. Combat Configuration
- UI provides controls for situational modifiers:
  - Flank/rear attacks (toggle)
  - Impact attacks (toggle, enabled by default when available)
  - Clash attacks (toggle, enabled by default)
  - Draw event effects (toggle for situational abilities)
  - Old Dominion tier selection (when applicable)
  - Terrain effects (dropdown/checkbox)
- Active modifiers are displayed with resulting characteristic adjustments for transparency

### 3. Probability Calculation
- Users configure options and tap "Calculate" to perform computation
- Each calculation is stored for potential comparison
- Calculation engine handles:
  - Impact attacks preceding clash attacks
  - Support attacks from unengaged stands
  - Special rules modifying attacks (e.g., Support(X))
  - Special rules modifying defense (e.g., Cleave, Shield)
  - Morale/resolve tests and potential additional casualties

### 4. Results Visualization
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
    "wizard": 6
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
- Results can be compared on the visualization graph by toggling them on/off

## User Interface Flow

1. **Main Screen**
   - List of factions or search bar for regiment selection
   - Quick access to recent calculations

2. **Regiment Selection Screen**
   - Faction-based list of regiments
   - Filtering options
   - Regiment stat summary cards

3. **Combat Calculator Screen**
   - Attacker and defender selection with stand configuration
   - Combat situation modifiers
   - "Calculate" button
   - Results visualization graph
   - List of stored calculations for comparison

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
  - Special rules modifying attack counts
- Hit probability based on clash/impact values
- Defense/save probability incorporating special rules
- Resolve test probability and additional casualties
- Probability of reaching critical thresholds (stand loss, breaking, destruction)

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

2. **Widget Tests**
   - UI component rendering
   - User interaction flows
   - State management

3. **Integration Tests**
   - End-to-end calculation workflow
   - Data persistence

4. **Performance Testing**
   - Calculation speed benchmarks
   - Memory usage profiling

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

### Phase 4: Polish & Extensions (2 weeks)
- UI refinement and animation
- Performance optimization
- Expanded special rule handling
- Potential extension to ranged combat

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

3. **Reliability**
   - Graceful handling of JSON format changes
   - No crashes during normal operation
   - Data persistence across app restarts

## Future Expansion Considerations
- Ranged combat (Volley actions) calculation
- Magical effects and spell damage calculation
- Multiple-round combat simulation
- Army builder integration
- Battle simulation capabilities

This specification provides a comprehensive roadmap for implementing the Conquest Probability Calculator, with a focus on the melee combat calculation as the initial deliverable. The architecture and design principles allow for easy extension to additional features based on user feedback and evolving requirements.