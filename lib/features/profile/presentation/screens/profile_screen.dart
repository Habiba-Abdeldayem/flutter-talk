import 'package:flutter/material.dart';
import 'package:flutter_talk/features/profile/presentation/widgets/current_user_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CurrentUserProfile());
  }
}
