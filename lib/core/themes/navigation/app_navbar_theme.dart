import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/colors/app_colors.dart';

final lightBottomNavBarTheme = BottomNavigationBarThemeData(
  backgroundColor: lightColorScheme.surface,
  selectedItemColor: lightColorScheme.primary,
  unselectedItemColor: lightColorScheme.secondary.withValues(alpha: 0.6),
  selectedIconTheme: IconThemeData(color: lightColorScheme.primary),
  unselectedIconTheme: IconThemeData(
    color: lightColorScheme.secondary.withValues(alpha: 0.6),
  ),
  showSelectedLabels: true,
  showUnselectedLabels: false,
  type: BottomNavigationBarType.fixed,
);

final darkBottomNavBarTheme = BottomNavigationBarThemeData(
  backgroundColor: darkColorScheme.surface,
  selectedItemColor: darkColorScheme.primary,
  unselectedItemColor: darkColorScheme.secondary.withValues(alpha: 0.6),
  selectedIconTheme: IconThemeData(color: darkColorScheme.primary),
  unselectedIconTheme: IconThemeData(
    color: darkColorScheme.secondary.withValues(alpha: 0.6),
  ),
  showSelectedLabels: true,
  showUnselectedLabels: false,
  type: BottomNavigationBarType.fixed,
);
