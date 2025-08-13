import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/features/profile/presentation/widgets/profile_avatar_section.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';

class OtherUserProfile extends ConsumerWidget {
  const OtherUserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final otherUserAsyncValue = ref.watch(otherUserProvider);
    return ListView(
      children: [
        ProfileAvatarSection(),
        const SizedBox(height: 60),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const SizedBox(height: 20)],
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _buildInfoList(context),
        ),
      ],
    );
  }

  Widget _buildInfoList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // _otherUserInfo(context, userName, userEmail, userPhone, userBio),
                  Icon(Icons.logout), Text(AppStrings.chats)],
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _otherUserInfo(
    BuildContext context,
    String userName,
    String userEmail,
    String userPhone,
    String userBio,
  ) {
    return Column(children: [
      Text(userName, style: Theme.of(context).textTheme.headlineMedium,),
      Text(userEmail),
      Text(userPhone),
      Text(userBio),
    ]);
  }

  // Widget _otherUserButton(
  //   BuildContext context,
  //   Icon leadingIcon,
  //   ProfileFieldType fieldType,
  //   String? value,
  // ) {
  //   return ListTile(
  //     leading: leadingIcon,
  //     title: Text(fieldType.name),
  //     subtitle: Text(
  //       value ?? 'Tap to add your ${fieldType.name.toLowerCase()}',
  //     ),
  //     trailing: Icon(Icons.arrow_forward_ios_rounded),
  //     onTap: () => _onTileTap(context, fieldType),
  //   );
  // }
}
