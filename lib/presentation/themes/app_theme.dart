// lib/presentation/themes/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Claude.ai inspired colors
  static const Color claudeSurface = Color(0xFFFAFAFA);
  static const Color claudeCardSurface = Color(0xFFF7F7F7);
  static const Color claudeBorder = Color(0xFFE6E6E6);
  static const Color claudeDarkerBorder = Color(0xFFD9D9D9);
  static const Color claudeText = Color(0xFF333333);
  static const Color claudeSubtleText = Color(0xFF666666);
  static const Color claudePrimary =
      Color(0xFF513E9D); // Purple shade similar to Claude
  static const Color claudeAttackerAccent =
      Color(0xFF689F38); // Green for attacker
  static const Color claudeDefenderAccent =
      Color(0xFFD32F2F); // Red for defender

  // Combat outcome colors - used for thresholds and probability indicators
  static const Color noLossColor = Color(0xFF388E3C); // Dark green
  static const Color singleStandLossColor =
      Color.fromARGB(255, 22, 138, 247); // Light orange
  static const Color breakingColor = Color(0xFFF57C00); // Deep orange
  static const Color destroyedColor = Color(0xFFD32F2F); // Red

  // Combat probability gradient - from good to bad outcomes
  static const List<Color> probabilityGradient = [
    noLossColor,
    singleStandLossColor,
    breakingColor,
    destroyedColor,
  ];

  // Get a color for probability based on the value (0-1)
  static Color getProbabilityColor(double probability) {
    if (probability < 0.25) return noLossColor;
    if (probability < 0.5) return singleStandLossColor;
    if (probability < 0.75) return breakingColor;
    return destroyedColor;
  }

  // Get threshold color based on the stand count and breaking threshold
  static Color getThresholdColor(
      int standCount, int totalStands, int standsToBreak) {
    if (standCount == totalStands) {
      return destroyedColor;
    } else if (standCount >= standsToBreak) {
      return breakingColor;
    } else {
      return singleStandLossColor;
    }
  }

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      surface: claudeSurface,
      surfaceContainerLow: claudeCardSurface,
      primary: claudePrimary,
      secondary: claudeAttackerAccent,
      error: claudeDefenderAccent,
      onSurface: claudeText,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
      bodyColor: claudeText,
      displayColor: claudeText,
    ),
    cardTheme: CardTheme(
      color: claudeCardSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: claudeBorder, width: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: claudePrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: claudePrimary,
        side: const BorderSide(color: claudePrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return claudePrimary;
        }
        return Colors.transparent;
      }),
      side: const BorderSide(color: claudeSubtleText),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return claudePrimary;
        }
        return Colors.grey.shade400;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return claudePrimary.withAlpha(128);
        }
        return Colors.grey.shade300;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return claudePrimary;
        }
        return claudeSubtleText;
      }),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: claudeCardSurface,
      selectedColor: claudePrimary.withAlpha(26),
      side: const BorderSide(color: claudeBorder),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      labelStyle: const TextStyle(color: claudeText),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: claudeCardSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: claudeBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: claudeBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: claudePrimary.withAlpha(204)),
      ),
    ),
    scaffoldBackgroundColor: claudeSurface,
  );

  static final ThemeData darkTheme = ThemeData(
    // A simplified dark theme that maintains Claude's aesthetic
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      surface: const Color(0xFF1E1E1E),
      surfaceContainerLow: const Color(0xFF2C2C2C),
      primary: claudePrimary.withAlpha(230),
      secondary: claudeAttackerAccent.withAlpha(230),
      error: claudeDefenderAccent.withAlpha(230),
      onSurface: Colors.white.withAlpha(230),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
  );
}
