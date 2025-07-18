import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talk/features/auth/presentation/pages/login_or_register_page.dart';
import 'package:flutter_talk/features/home/presentation/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // loading
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); 
          }
          // user is logged in
          if (snapshot.hasData) {
            return HomePage();
          } 
          // user isn't logged in
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
