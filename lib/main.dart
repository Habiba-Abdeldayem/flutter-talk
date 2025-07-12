import 'package:flutter/material.dart';
import 'package:flutter_talk/services/auth/login_or_register_page.dart';
import 'package:flutter_talk/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const LoginOrRegisterPage(),
    );
  }
}
