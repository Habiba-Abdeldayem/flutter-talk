import 'package:flutter/material.dart';
import 'package:flutter_talk/core/models/user_model.dart';
import 'package:flutter_talk/features/profile/presentation/widgets/current_user_profile.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel currentUser;
  const ProfileScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurrentUserProfile(currentUser: currentUser)
      //  CurrentUserProfile(currentUser: currentUser)
    );
  }
}
