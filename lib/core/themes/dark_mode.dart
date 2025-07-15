import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/app_colors.dart';
import 'package:flutter_talk/core/themes/app_input_decoration.dart';
import 'package:flutter_talk/core/themes/app_text_theme.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: Color(0xFF1B2B27),
  cardColor: Color(0xFF1E1E1E),
  inputDecorationTheme: inputDecorationThemeDark,
  textTheme: appTextTheme,
  useMaterial3: true,
);
