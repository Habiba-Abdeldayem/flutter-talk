import 'package:flutter/material.dart';

TextTheme buildTextTheme(ColorScheme colorScheme) {
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: colorScheme.onSurface,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: colorScheme.onSurface,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: colorScheme.onSurface,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: colorScheme.onSurface.withValues(alpha:0.85),
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: colorScheme.onSurface.withValues(alpha:0.6),
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: colorScheme.onPrimary,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      color: colorScheme.error,
    ),
  );
}
