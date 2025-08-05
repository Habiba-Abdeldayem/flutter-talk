import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String? error;
  const AppErrorWidget({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    final errorMessage = error ?? "";
    return Center(child: Text("Error: $errorMessage"));
  }
}
