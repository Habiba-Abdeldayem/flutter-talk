import 'package:flutter/material.dart';
import 'package:flutter_talk/features/settings/presentation/widgets/profile_section.dart';
import 'package:flutter_talk/features/settings/presentation/widgets/settings_options_section.dart';

class SettingsScreen extends StatelessWidget {
  final String? username;
  final String? email;
  final String? phone;
  final String? bio;
  final String? photoUrl;

  const SettingsScreen({
    super.key,
    this.username,
    this.email,
    this.phone,
    this.bio,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          ProfileSection(),

          const SizedBox(height: 20),

          SettingsOptionsSection(),
        ],
      ),
    );
  }
}
