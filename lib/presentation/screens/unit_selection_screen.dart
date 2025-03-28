// lib/presentation/screens/unit_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/regiment_provider.dart';
import '../../domain/models/regiment.dart';
import '../widgets/unit_card.dart';

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
    return UnitCard(
      regiment: regiment,
      padding: const EdgeInsets.all(12.0),
      inSelectionScreen:
          true, // This is crucial to make special rules read-only
      onTap: () => widget.onUnitSelected(regiment),
    );
  }
}
