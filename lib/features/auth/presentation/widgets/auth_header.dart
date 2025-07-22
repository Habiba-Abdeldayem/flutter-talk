import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String imagePath;
  const AuthHeader({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, height: 150, width: 150),
        const SizedBox(height: AppSizes.xl),
        Text(title, style: Theme.of(context).textTheme.displayLarge),
      ],
    );
  }
}
