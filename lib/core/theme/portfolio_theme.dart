import 'package:flutter/material.dart';

abstract final class PortfolioTheme {
  static const background = Color(0xFF101210);
  static const surface = Color(0xFF1A1D19);
  static const accent = Color(0xFFC4F477);
  static const muted = Color(0xFFA6ADA1);
  static const border = Color(0xFF343A30);
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(
      primary: accent,
      secondary: accent,
      surface: surface,
      secondaryContainer: accent,
      onSecondaryContainer: background,
      outline: border,
      outlineVariant: border,
    ),
    fontFamily: 'Arial',
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 15, height: 1.6),
      bodyLarge: TextStyle(fontSize: 18, height: 1.6, color: muted),
    ),
    dividerColor: border,
    dividerTheme: const DividerThemeData(color: border, thickness: 1),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        side: const BorderSide(color: border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      ),
    ),
  );
}
