import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/colors/app_colors.dart';
import 'package:flutter_talk/core/themes/inputs/app_input_decoration.dart';
import 'package:flutter_talk/core/themes/navigation/app_navbar_theme.dart';
import 'package:flutter_talk/core/themes/text/app_text_theme.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.white,
  inputDecorationTheme: inputDecorationThemeLight,
  textTheme: appTextTheme,
  bottomNavigationBarTheme: lightBottomNavBarTheme,
  useMaterial3: true,
);
