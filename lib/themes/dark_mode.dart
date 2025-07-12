import 'package:flutter/material.dart';
import 'package:flutter_talk/themes/app_colors.dart';
import 'package:flutter_talk/themes/app_input_decoration.dart';
import 'package:flutter_talk/themes/app_text_theme.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  inputDecorationTheme: inputDecorationThemeDark,
  textTheme: appTextTheme,
  useMaterial3: true,
);
