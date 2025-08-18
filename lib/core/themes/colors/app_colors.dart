import 'package:flutter/material.dart';

// Light Color Scheme
final lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: const Color(0xFF4DB6AC), 
  onPrimary: Colors.white,
  secondary: const Color(0xFF546E7A),
  onSecondary: Colors.white,
  surface: Colors.white,
  onSurface: Colors.black87,
  error: Colors.red.shade700,
  onError: Colors.white,
  tertiary: const Color(0xFFB2DFDB),
  onTertiary: Colors.black87,
);

// Dark Color Scheme
final darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: const Color(0xFF80CBC4), 
  onPrimary: Colors.white, 
  secondary: const Color(0xFF90A4AE), 
  onSecondary: Colors.black,
  surface: const Color(0xFF121212), 
  onSurface: Colors.grey[200]!, 
  error: const Color(0xFFEF5350),
  onError: Colors.white,
  tertiary: const Color(0xFFB0BEC5),
  onTertiary: Colors.black,
);
