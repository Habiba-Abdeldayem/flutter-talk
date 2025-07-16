import 'package:flutter/material.dart';
import 'package:flutter_talk/features/auth/data/auth_repository.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _authRepository = AuthRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _authRepository.signOut();
            },
          ),
        ],
      ),
    );
  }
}
