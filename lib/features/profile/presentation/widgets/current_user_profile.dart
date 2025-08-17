import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/enums/profile_field_type.dart';
import 'package:flutter_talk/features/profile/presentation/widgets/profile_avatar_section.dart';
import 'package:flutter_talk/features/user/models/user_model.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';

class CurrentUserProfile extends ConsumerWidget {
  const CurrentUserProfile({super.key});

  void _onTileTap(BuildContext context, ProfileFieldType fieldType) {
    Navigator.pushNamed(
      context,
      '/edit_profile_info',
      arguments: {'fieldType': fieldType},
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDataProvider);
    if (currentUser == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        ProfileAvatarSection(),
        const SizedBox(height: 60),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.changePhoto,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        _buildInfoList(context, currentUser),
      ],
    );
  }

  Widget _buildInfoList(BuildContext context, UserModel currentUser) {
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
            currentUser.bio,
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
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
      onTap: () => _onTileTap(context, fieldType),
    );
  }
}
