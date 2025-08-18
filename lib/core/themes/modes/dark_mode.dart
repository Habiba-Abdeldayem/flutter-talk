import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/colors/app_colors.dart';
import 'package:flutter_talk/core/themes/inputs/app_input_decoration.dart';
import 'package:flutter_talk/core/themes/navigation/app_navbar_theme.dart';
import 'package:flutter_talk/core/themes/text/app_text_theme.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.surface,
  cardColor: const Color(0xFF1E1E1E),
  inputDecorationTheme: inputDecorationThemeDark,
  bottomNavigationBarTheme: darkBottomNavBarTheme,
  textTheme: buildTextTheme(darkColorScheme),
  useMaterial3: true,
);
