import 'package:flutter/material.dart';

class AppColors {
  // Primary brand
  static const Color primary = Color(0xFF0B3D91); // deep blue
  static const Color onPrimary = Colors.white;

  // Accent / secondary
  static const Color secondary = Color(0xFF50647A); // slate

  // Surface / background
  static const Color surface = Color(0xFFF7F9FB);
  static const Color background = Color(0xFFF2F5F9);

  // Status colors
  static const Color statusNew = Color(0xFF0B79FF);
  static const Color statusActive = Color(0xFFD97706); // amber/darker
  static const Color statusClosed = Color(0xFF0F9D58);

  // Muted
  static const Color muted = Color(0xFF6B7280);
}

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
  );

  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      centerTitle: true,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
      hintStyle: const TextStyle(color: Colors.black45),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
    ),
    textTheme: Typography.material2021().black.apply(fontFamily: 'Inter'),
  );
}
