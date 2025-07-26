import 'package:flutter/material.dart';

class AppFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? value;
  final bool isPassword;
  final String? Function(String?)? validator;
  const AppFormField({
    super.key,
    required this.hintText,
    this.value,
    required this.controller,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool _obscureText = true;
  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      widget.controller.text = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.isPassword && _obscureText,
      maxLines: 1,
      decoration: InputDecoration(
        hint: Text(
          widget.hintText,
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: _obscureText
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
