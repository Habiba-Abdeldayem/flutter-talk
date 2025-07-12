import 'package:flutter/material.dart';
import 'package:flutter_talk/pages/login_page.dart';
import 'package:flutter_talk/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool _isLoginPage = true;

  void togglePages() {
    setState(() {
      _isLoginPage = !_isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoginPage) {
      return LoginPage();
    } else {
      return RegisterPage();
    }
  }
}
