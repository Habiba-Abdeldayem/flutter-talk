import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String error;
  const AppErrorWidget(this.error , {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Error: $error"));
  }
}