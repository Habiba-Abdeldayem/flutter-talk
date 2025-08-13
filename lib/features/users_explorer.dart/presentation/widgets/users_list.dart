import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/components/shared/app_error_widget.dart';
import 'package:flutter_talk/core/components/shared/app_loading_widget.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';
import 'package:flutter_talk/features/user/providers/other_users_provider.dart';
import 'package:flutter_talk/features/users_explorer.dart/presentation/widgets/user_tile.dart';

class UsersList extends ConsumerWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(currentUserDataProvider)!.uid;
    final otherUsersStream = ref.watch(otherUsersProvider);
    return otherUsersStream.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(child: Text(AppStrings.noUsersFound));
        }
        return Padding(
          padding: const EdgeInsets.all(AppSizes.medium),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return UserTile(
                userModel: data[index],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/chat',
                    arguments: {
                      'currentUserId': currentUserId,
                      'otherUser': data[index],
                    },
                  );
                },
              );
            },
          ),
        );
      },
      error: (error, stackTrace) {
        return const AppErrorWidget(error: AppStrings.somethingWentWrong);
      },
      loading: () => const AppLoadingWidget(),
    );
  }
}
