import 'package:flutter/material.dart';

/// Centralized app theme definitions providing a modern, minimal design system.
class AppTheme {
  AppTheme._();

  // Primary Color Palette
  static const Color primaryGradientStart = Color(0xFF1F1C2C);
  static const Color primaryGradientEnd = Color(0xFF928DAB);
  static const Color accentColor = Color(0xFF6C5CE7);
  static const Color cardBackgroundColor = Color(0x1FFFFFFF); // Glassmorphic white tint
  static const Color cardBorderColor = Color(0x33FFFFFF);
  static const Color textPrimaryColor = Color(0xFFF8F9FA);
  static const Color textSecondaryColor = Color(0xFFB8C2CC);

  // Modern Dark Glassmorphic Theme Data
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F0C20),
      colorScheme: ColorScheme.dark(
        primary: accentColor,
        surface: const Color(0xFF1E1B32),
        onPrimary: Colors.white,
        onSurface: textPrimaryColor,
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimaryColor,
          height: 1.4,
          letterSpacing: -0.5,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textSecondaryColor,
          fontStyle: FontStyle.italic,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textSecondaryColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          elevation: 8,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
