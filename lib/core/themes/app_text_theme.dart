import 'package:flutter/material.dart';


final TextTheme appTextTheme = const TextTheme(
  // Large app title (e.g. Splash screen or onboarding)
  displayLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),

  // Section headers (e.g. Settings or Profile screen titles)
  headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),

  // Chat username in the chat list
  titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),

  // Last message preview in the chat list
  bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),

  // Message timestamp (small, subtle text)
  bodySmall: TextStyle(fontSize: 12, color: Colors.grey),

  // General readable text (e.g. paragraph, description)
  bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),

  // Button text (e.g. Send, Login, Register)
  labelLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),

  // Error or warning messages (e.g. "Invalid email")
  labelSmall: TextStyle(fontSize: 14, color: Colors.red),
);
