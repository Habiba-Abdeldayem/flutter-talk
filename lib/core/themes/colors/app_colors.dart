import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF6BA7A5), // Main button color
  onPrimary: Colors.white,
  secondary: Color(0xFF7A8A9E),
  onSecondary: Color(0xFF0B2539),
  surface: Color(0xFFE8F5E9), // Card background
  onSurface: Color(0xFF0B2539),
  error: Color(0xFFB00020),
  onError: Colors.white,
  tertiary: Color(0xFFB2C5C7),
  onTertiary: Color(0xFF0B2539),
);

final darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF80CBC4),
  onPrimary: Colors.black,
  secondary: Color(0xFFB0BEC5),
  onSecondary: Colors.white,
  surface: Color(0xFF1A1A1A),
  onSurface: Colors.white,
  error: Color(0xFFCF6679),
  onError: Colors.black,
  tertiary: Color(0xFF90A4AE),
  onTertiary: Colors.white,
);
