import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  bool obscureText;
  AppTextField({super.key, required this.hintText, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      decoration: InputDecoration(
        hint: Text(hintText),
        // filled: true,
        // fillColor: Theme.of(context).colorScheme.surface,

        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
