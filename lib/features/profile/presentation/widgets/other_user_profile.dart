import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/components/shared/app_error_widget.dart';
import 'package:flutter_talk/core/components/shared/app_loading_widget.dart';
import 'package:flutter_talk/core/components/shared/profile_action_button.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';
import 'package:flutter_talk/features/profile/presentation/widgets/profile_avatar_section.dart';
import 'package:flutter_talk/features/user/models/user_model.dart';
import 'package:flutter_talk/features/user/providers/other_users_provider.dart';

class OtherUserProfile extends ConsumerWidget {
  final String profileId;
  const OtherUserProfile({super.key, required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otherUserAsyncValue = ref.watch(userByIdProvider(profileId));

    return Scaffold(
      body: otherUserAsyncValue.when(
        loading: () => const AppLoadingWidget(),
        error: (error, stackTrace) => const AppErrorWidget(),
        data: (userData) {
          if (userData == null) {
            return AppErrorWidget(error: "No user data found");
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ProfileAvatarSection(),
                const SizedBox(height: 50),

                Text(
                  userData.displayName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(height: 8),
                // Text(
                //   userData.bio ?? "No bio yet",
                //   style: Theme.of(
                //     context,
                //   ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                //   textAlign: TextAlign.center,
                // ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileActionButton(
                      icon: Icons.block,
                      label: "Block",
                      onPressed: () {},
                    ),
                    const SizedBox(width: 24),
                    ProfileActionButton(
                      icon: Icons.message,
                      label: "Message",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildInfoTile(Icons.email, userData.email),
                          const Divider(),
                          _buildInfoTile(Icons.phone, userData.phone ?? "N/A"),
                          const Divider(),
                          _buildInfoTile(Icons.info, userData.bio ?? "No bio"),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
      ],
    );
  }
}
