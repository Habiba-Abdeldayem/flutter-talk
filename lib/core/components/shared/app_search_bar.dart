import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/app_sizes.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function(String value) searchByName;

  const AppSearchBar({
    super.key,
    required this.hintText,
    required this.searchByName,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.medium),
      margin: EdgeInsets.symmetric(horizontal: AppSizes.large),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
      ),
      child: TextField(
        controller: controller,
        onSubmitted: (value) {
          final query = value.trim();
          searchByName(query);
        },
        decoration: InputDecoration(
          hint: Text(hintText),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
