import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/app_colors.dart';
import 'package:flutter_talk/core/themes/app_input_decoration.dart';
import 'package:flutter_talk/core/themes/app_text_theme.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.white,
  inputDecorationTheme: inputDecorationThemeLight,
  textTheme: appTextTheme,
  useMaterial3: true,
);
