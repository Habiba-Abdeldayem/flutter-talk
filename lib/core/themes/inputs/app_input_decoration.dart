import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';

/// Light InputDecorationTheme
final inputDecorationThemeLight = InputDecorationTheme(
  filled: true,
  fillColor: Colors.white,
  hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFB0BEC5)),
    borderRadius: BorderRadius.circular(12),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
    borderRadius: BorderRadius.circular(12),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(8),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(8),
  ),
);

/// Dark InputDecorationTheme
final inputDecorationThemeDark = InputDecorationTheme(
  filled: true,
  fillColor: Color(0xFF1E1E1E),
  hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF455A64)),
    borderRadius: BorderRadius.circular(AppSizes.radius),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF80CBC4)), // primary
    borderRadius: BorderRadius.circular(AppSizes.radius),
  ),
);
