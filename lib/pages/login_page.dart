import 'package:flutter/material.dart';
import 'package:flutter_talk/components/app_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/images/user_avatar.png", height: 100, width: 100),
            SizedBox(height: 25),
            Text("Login", style: Theme.of(context).textTheme.displayLarge),
            AppTextField(hintText: "hintText", obscureText: false),
            AppTextField(hintText: "hintText", obscureText: false),
          ],
        ),
      ),
    );
  }
}
