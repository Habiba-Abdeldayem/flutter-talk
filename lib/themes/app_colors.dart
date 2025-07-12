import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF6BA7A5), // Main button color
  onPrimary: Colors.white, // Text on primary
  secondary: Color(0xFF7A8A9E), // Subtext links
  onSecondary: Color(0xFF0B2539), // Titles / text
  surface: Color(0xFFFFFFFF), // Card background
  onSurface: Color(0xFF0B2539), // Text inside cards
  error: Color(0xFFB00020),
  onError: Colors.white,
  tertiary: Color(0xFFB2C5C7), // Icon color
  onTertiary: Color(0xFF0B2539),
);

/// Dark Color Scheme
final darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF80CBC4),
  onPrimary: Colors.black,
  secondary: Color(0xFFB0BEC5),
  onSecondary: Colors.white,
  surface: Color(0xFF121212), // Dark card background
  onSurface: Colors.white,
  error: Color(0xFFCF6679),
  onError: Colors.black,
  tertiary: Color(0xFF90A4AE),
  onTertiary: Colors.white,
);

