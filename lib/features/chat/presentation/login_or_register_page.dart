import 'package:flutter/material.dart';
import 'package:flutter_talk/features/auth/presentation/components/auth_form.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool _showLoginPage = true;

  void togglePages() {
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoginPage) {
      return AuthForm(
        onButtonClick:
            (
              String email,
              String password,
              String? confirmPassword,
              String? userName,
            ) {},
        onTogglePage: togglePages,
        isLoginPage: true,
      );
    } else {
      return AuthForm(
        onButtonClick:
            (
              String email,
              String password,
              String? confirmPassword,
              String? userName,
            ) {},
        onTogglePage: togglePages,
        isLoginPage: false,
      );
    }
  }
}
