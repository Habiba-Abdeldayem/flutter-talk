import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/colors/app_colors.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';

// Light Mode Input Decoration
final inputDecorationThemeLight = InputDecorationTheme(
  filled: true,
  fillColor: Colors.white,
  hintStyle: TextStyle(color: Colors.grey[600]),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: lightColorScheme.secondary.withValues(alpha:0.3)),
    borderRadius: BorderRadius.circular(AppSizes.radius),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: lightColorScheme.primary, width: 2),
    borderRadius: BorderRadius.circular(AppSizes.radius),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: lightColorScheme.error),
    borderRadius: BorderRadius.circular(AppSizes.radius),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: lightColorScheme.error, width: 2),
    borderRadius: BorderRadius.circular(AppSizes.radius),
  ),
);

// Dark Mode Input Decoration
final inputDecorationThemeDark = InputDecorationTheme(
  filled: true,
  fillColor: const Color(0xFF1E1E1E),
  hintStyle: TextStyle(color: Colors.grey[400]),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: darkColorScheme.secondary.withValues(alpha:0.3)),
    borderRadius: BorderRadius.circular(AppSizes.radius),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: darkColorScheme.primary, width: 2),
    borderRadius: BorderRadius.circular(AppSizes.radius),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: darkColorScheme.error),
    borderRadius: BorderRadius.circular(AppSizes.radius),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: darkColorScheme.error, width: 2),
    borderRadius: BorderRadius.circular(AppSizes.radius),
  ),
);
