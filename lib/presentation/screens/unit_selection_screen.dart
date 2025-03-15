// lib/presentation/screens/unit_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/regiment_provider.dart';
import '../../domain/models/regiment.dart';
import '../widgets/unit_selection/special_rule_chip.dart';

enum UnitFilter {
  all,
  regimentsOnly,
  charactersOnly,
}

class UnitSelectionScreen extends ConsumerStatefulWidget {
  final String faction;
  final Function(Regiment) onUnitSelected;
  final UnitFilter initialFilter;
  final String? title;
  final Set<UnitFilter> allowedFilters;
  final bool isDuelMode;

  const UnitSelectionScreen({
    super.key,
    required this.faction,
    required this.onUnitSelected,
    this.initialFilter = UnitFilter.all,
    this.title,
    this.allowedFilters = const {
      UnitFilter.all,
      UnitFilter.regimentsOnly,
      UnitFilter.charactersOnly
    },
    this.isDuelMode = false,
  });

  @override
  ConsumerState<UnitSelectionScreen> createState() =>
      _UnitSelectionScreenState();
}

class _UnitSelectionScreenState extends ConsumerState<UnitSelectionScreen> {
  late UnitFilter _currentFilter;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Choose default filter based on mode
    UnitFilter defaultFilter = widget.isDuelMode
        ? UnitFilter.charactersOnly
        : UnitFilter.regimentsOnly;

    // Use the default filter if allowed, otherwise use the provided initialFilter
    if (widget.allowedFilters.contains(defaultFilter)) {
      _currentFilter = defaultFilter;
    } else if (widget.allowedFilters.contains(widget.initialFilter)) {
      // Fall back to initialFilter if available
      _currentFilter = widget.initialFilter;
    } else {
      // Last resort: use the first allowed filter
      _currentFilter = widget.allowedFilters.first;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final regimentsAsyncValue =
        ref.watch(regimentsByFactionProvider(widget.faction));

    // Add relevant context for character-only selection mode
    final bool isCharactersOnlyMode =
        _currentFilter == UnitFilter.charactersOnly ||
            (widget.allowedFilters.length == 1 &&
                widget.allowedFilters.contains(UnitFilter.charactersOnly));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Select ${widget.faction} Unit'),
        // Add an info button with explanation when in characters-only mode
        actions: [
          if (isCharactersOnlyMode)
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'Character Selection Info',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Character Selection'),
                    content: const Text(
                        'When selecting a character as your attacker, you can only choose another character as the defender.\n\n'
                        'Character vs character combat is resolved differently from regular combat between regiments.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          PopupMenuButton<UnitFilter>(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter units',
            onSelected: (UnitFilter filter) {
              setState(() {
                _currentFilter = filter;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<UnitFilter>>[
              if (widget.allowedFilters.contains(UnitFilter.all))
                const PopupMenuItem<UnitFilter>(
                  value: UnitFilter.all,
                  child: Text('Show All Units'),
                ),
              if (widget.allowedFilters.contains(UnitFilter.regimentsOnly))
                const PopupMenuItem<UnitFilter>(
                  value: UnitFilter.regimentsOnly,
                  child: Text('Regiments Only'),
                ),
              if (widget.allowedFilters.contains(UnitFilter.charactersOnly))
                const PopupMenuItem<UnitFilter>(
                  value: UnitFilter.charactersOnly,
                  child: Text('Characters Only'),
                ),
            ],
          ),
        ],
        // Add a character mode indicator when appropriate
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(isCharactersOnlyMode ? 76.0 : 48.0),
          child: Column(
            children: [
              if (isCharactersOnlyMode)
                Container(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.3),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.person, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Character vs Character Mode',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search units...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: regimentsAsyncValue.when(
        data: (regiments) {
          // Filter regiments based on current filter and search query
          final filteredRegiments = regiments.where((regiment) {
            bool matchesFilter = true;

            // Apply type filter
            switch (_currentFilter) {
              case UnitFilter.regimentsOnly:
                matchesFilter = !regiment.isCharacter();
                break;
              case UnitFilter.charactersOnly:
                matchesFilter = regiment.isCharacter();
                break;
              case UnitFilter.all:
                // Show all types
                break;
            }

            // Apply search filter
            if (_searchQuery.isNotEmpty) {
              return matchesFilter &&
                  regiment.name.toLowerCase().contains(_searchQuery);
            }

            return matchesFilter;
          }).toList();

          if (filteredRegiments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No units found',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _searchQuery.isNotEmpty
                        ? 'Try a different search term'
                        : 'No units available for this filter',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: filteredRegiments.length,
            itemBuilder: (context, index) {
              return _buildUnitCard(context, filteredRegiments[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error loading units: $error'),
        ),
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilterChip(
              selected: _currentFilter == UnitFilter.all,
              label: const Text('All'),
              onSelected: widget.allowedFilters.contains(UnitFilter.all)
                  ? (_) => setState(() {
                        _currentFilter = UnitFilter.all;
                      })
                  : null, // Disabled if not allowed
            ),
            const SizedBox(width: 12),
            FilterChip(
              selected: _currentFilter == UnitFilter.regimentsOnly,
              label: const Text('Regiments'),
              onSelected:
                  widget.allowedFilters.contains(UnitFilter.regimentsOnly)
                      ? (_) => setState(() {
                            _currentFilter = UnitFilter.regimentsOnly;
                          })
                      : null, // Disabled if not allowed
            ),
            const SizedBox(width: 12),
            FilterChip(
              selected: _currentFilter == UnitFilter.charactersOnly,
              label: const Text('Characters'),
              onSelected:
                  widget.allowedFilters.contains(UnitFilter.charactersOnly)
                      ? (_) => setState(() {
                            _currentFilter = UnitFilter.charactersOnly;
                          })
                      : null, // Disabled if not allowed
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitCard(BuildContext context, Regiment regiment) {
    final bool isCharacter = regiment.isCharacter();

    // Use a more structured layout for the card
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      // For characters, use a slightly different card color
      color: isCharacter
          ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2)
          : null,
      shape: isCharacter
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
            )
          : null,
      child: InkWell(
        onTap: () => widget.onUnitSelected(regiment),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with unit name and character indicator
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Character badge or unit type icon
                  Badge(
                    isLabelVisible: isCharacter,
                    label: const Text('C'),
                    backgroundColor: isCharacter
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    child: Icon(
                      isCharacter
                          ? Icons.person
                          : _getRegimentTypeIcon(regiment.type),
                      color: isCharacter
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Unit name
                  Expanded(
                    child: Text(
                      regiment.name,
                      style: TextStyle(
                        fontWeight:
                            isCharacter ? FontWeight.bold : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  // Type and class indicators in top right
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          regiment.type.toString().split('.').last,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          regiment.regimentClass.toString().split('.').last,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Stats grid - using a more structured approach for consistent spacing
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildStatColumns(context, regiment),
                ),
              ),

              // Special rules section - full width with tooltips
              if (regiment.specialRules.isNotEmpty ||
                  regiment.hasBarrage() ||
                  regiment.hasArmorPiercing()) ...[
                const SizedBox(height: 12),
                Text(
                  'Special Rules',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    // Add barrage as a separate special rule
                    if (regiment.hasBarrage())
                      SpecialRuleChip(
                        ruleName: regiment.barrageRange != null &&
                                regiment.barrageRange! > 0
                            ? "Barrage (${regiment.getBarrage()}) (${regiment.getBarrageRange()}\")"
                            : "Barrage (${regiment.getBarrage()})",
                      ),

                    // Add armor piercing as a separate special rule
                    if (regiment.hasArmorPiercing())
                      SpecialRuleChip(
                        ruleName:
                            "Armor Piercing (${regiment.getArmorPiercingValue()})",
                      ),

                    // Add other special rules (excluding barrage and armor piercing that are handled separately)
                    ...regiment.specialRules
                        .map((rule) {
                          // Skip barrage and armor piercing as they're handled separately above
                          if ((rule.contains('Barrage') &&
                                  regiment.hasBarrage()) ||
                              (rule.contains('Armor Piercing') &&
                                  regiment.hasArmorPiercing())) {
                            return const SizedBox.shrink();
                          }

                          return SpecialRuleChip(ruleName: rule);
                        })
                        .where((widget) => widget is! SizedBox)
                        .toList(),
                  ],
                ),
              ],

              // Draw events section - full width with tooltips
              if (regiment.drawEvents.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Draw Events',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: regiment.drawEvents.map((event) {
                    return SpecialRuleChip(ruleName: event);
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build stat columns
  List<Widget> _buildStatColumns(BuildContext context, Regiment regiment) {
    final labels = ['M', 'V', 'C', 'A', 'W', 'R', 'D', 'E'];
    final values = [
      regiment.march?.toString() ?? '-',
      regiment.volley.toString(),
      regiment.clash.toString(),
      regiment.attacks.toString(),
      regiment.wounds.toString(),
      regiment.resolve?.toString() ?? '-',
      regiment.defense.toString(),
      regiment.evasion.toString(),
    ];

    return List.generate(labels.length, (index) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Stat label
          Container(
            padding: const EdgeInsets.all(4),
            child: Text(
              labels[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          // Stat value
          Container(
            padding: const EdgeInsets.all(4),
            child: Text(
              values[index],
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      );
    });
  }

  IconData _getRegimentTypeIcon(RegimentType type) {
    switch (type) {
      case RegimentType.infantry:
        return Icons.people;
      case RegimentType.cavalry:
        return Icons.sports_handball;
      case RegimentType.brute:
        return Icons.fitness_center;
      case RegimentType.monster:
        return Icons.pets;
      case RegimentType.chariot:
        return Icons.directions_car;
      default:
        return Icons.group;
    }
  }
}
