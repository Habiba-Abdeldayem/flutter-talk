import 'package:flutter/material.dart';
import 'package:flutter_talk/core/enums/profile_field_type.dart';
import 'package:flutter_talk/core/models/user_model.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/features/profile/presentation/pages/edit_profile_info_page.dart';

class CurrentUserProfile extends StatelessWidget {
  final UserModel currentUser;
  const CurrentUserProfile({super.key, required this.currentUser});

  void _onTileTap(BuildContext context, ProfileFieldType fieldType) {
    Navigator.pushNamed(
      context,
      '/edit_profile_info',
      arguments: {'fieldType': fieldType, 'currentUser': currentUser},
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(height: 180, color: Colors.teal[100]),
            Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width / 2 - 50,
              bottom: -80,
              child: InkWell(
                onTap: () {
                  // TODO show image/image picker
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(
                      "lib/core/images/user_avatar.png",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.changePhoto,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        _buildInfoList(context),
      ],
    );
  }

  Widget _buildInfoList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _infoTile(
            context,
            Icon(Icons.person),
            ProfileFieldType.name,
            currentUser.displayName,
          ),
          // TODO: modify UserModel to store phone, bio
          _infoTile(
            context,
            Icon(Icons.phone),
            ProfileFieldType.phone,
            currentUser.phone,
          ),
          _infoTile(
            context,
            Icon(Icons.info),
            ProfileFieldType.bio,

            "Flutter Developer",
          ),
        ],
      ),
    );
  }

  Widget _infoTile(
    BuildContext context,
    Icon leadingIcon,
    ProfileFieldType fieldType,
    String? value,
  ) {
    return ListTile(
      leading: leadingIcon,
      title: Text(fieldType.name),
      subtitle: Text(
        value ?? 'Tap to add your ${fieldType.name.toLowerCase()}',
        // : value,
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
      onTap: () => _onTileTap(context, fieldType),
    );
  }
}
