// lib/data/sources/local/special_rules_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';

/// Represents a single special rule from the Conquest game system
class SpecialRule {
  final String name;
  final String description;

  SpecialRule({required this.name, required this.description});

  factory SpecialRule.fromJson(Map<String, dynamic> json) {
    return SpecialRule(
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

class DrawEvent {
  final String name;
  final String description;

  DrawEvent({required this.name, required this.description});

  factory DrawEvent.fromJson(Map<String, dynamic> json) {
    return DrawEvent(
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

class SpecialRulesService {
  static final SpecialRulesService _instance = SpecialRulesService._internal();
  factory SpecialRulesService() => _instance;

  SpecialRulesService._internal();

  List<SpecialRule> _specialRules = [];
  List<DrawEvent> _drawEvents = [];

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/special_rules.json');
      final Map<String, dynamic> jsonData =
          json.decode(jsonString) as Map<String, dynamic>;

      _specialRules = (jsonData['special_rules'] as List)
          .map((rule) => SpecialRule.fromJson(rule as Map<String, dynamic>))
          .toList();

      _drawEvents = (jsonData['draw_events'] as List? ?? [])
          .map((event) => DrawEvent.fromJson(event as Map<String, dynamic>))
          .toList();

      _isInitialized = true;
    } catch (e) {
      print('Error initializing special rules service: $e');
      // Initialize with empty lists to prevent errors
      _specialRules = [];
      _drawEvents = [];
      _isInitialized = true;
    }
  }

  // Get a special rule's description by its base name (without any (X) parameters)
  String getSpecialRuleDescription(String ruleName) {
    if (!_isInitialized) {
      print('Warning: Special rules service not initialized');
      return '';
    }

    // Extract the base rule name by removing any parameters
    final baseRuleName = _extractBaseRuleName(ruleName);

    // Find the matching rule
    final rule = _specialRules.firstWhere(
      (rule) => _extractBaseRuleName(rule.name) == baseRuleName,
      orElse: () =>
          SpecialRule(name: ruleName, description: 'No description available.'),
    );

    return rule.description;
  }

  // Get a draw event's description by its base name (without any (X) parameters)
  String getDrawEventDescription(String eventName) {
    if (!_isInitialized) {
      print('Warning: Special rules service not initialized');
      return '';
    }

    // Extract the base rule name by removing any parameters
    final baseEventName = _extractBaseRuleName(eventName);

    // Find the matching event
    final event = _drawEvents.firstWhere(
      (event) => _extractBaseRuleName(event.name) == baseEventName,
      orElse: () =>
          DrawEvent(name: eventName, description: 'No description available.'),
    );

    return event.description;
  }

  // Helper method to extract base name by removing any (X) parameters
  String _extractBaseRuleName(String fullName) {
    // If the name contains a parenthesis, extract just the name part
    int parenIndex = fullName.indexOf('(');
    if (parenIndex > 0) {
      return fullName.substring(0, parenIndex).trim();
    }
    return fullName.trim();
  }

  // Helper method to check if a string matches a special rule base name
  bool hasSpecialRule(String ruleName) {
    if (!_isInitialized) return false;

    final baseRuleName = _extractBaseRuleName(ruleName);
    return _specialRules
        .any((rule) => _extractBaseRuleName(rule.name) == baseRuleName);
  }

  // Helper method to check if a string matches a draw event base name
  bool hasDrawEvent(String eventName) {
    if (!_isInitialized) return false;

    final baseEventName = _extractBaseRuleName(eventName);
    return _drawEvents
        .any((event) => _extractBaseRuleName(event.name) == baseEventName);
  }

  // Get all special rules
  List<SpecialRule> getAllSpecialRules() {
    if (!_isInitialized) {
      initialize(); // Try to initialize if not already
      return [];
    }
    return List.unmodifiable(_specialRules);
  }

  // Get all draw events
  List<DrawEvent> getAllDrawEvents() {
    if (!_isInitialized) {
      initialize(); // Try to initialize if not already
      return [];
    }
    return List.unmodifiable(_drawEvents);
  }
}
