import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/components/shared/app_error_widget.dart';
import 'package:flutter_talk/core/components/shared/app_loading_widget.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';
import 'package:flutter_talk/features/chat/providers/chat_providers.dart';
import 'package:flutter_talk/features/home/presentation/widgets/chat_item_tile.dart';
import 'package:flutter_talk/features/home/providers/chat_search_provider.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);

    return currentUserAsync.when(
      loading: () => const AppLoadingWidget(),
      error: (err, _) => AppErrorWidget(error: err.toString()),
      data: (currentUser) {
        if (currentUser == null) {
          return const Center(child: Text("User not logged in"));
        }

        final userChatsWithUsers =
            ref.watch(userChatsWithUsersProvider(currentUser.uid));

        return userChatsWithUsers.when(
          loading: () => const AppLoadingWidget(),
          error: (err, _) => AppErrorWidget(error: err.toString()),
          data: (chats) {
            final filteredChats = ref.watch(chatSearchProvider);

            if (filteredChats.isEmpty) {
              return const Center(child: Text("No chats found"));
            }

            return Padding(
              padding: const EdgeInsets.all(AppSizes.medium),
              child: ListView.builder(
                itemCount: filteredChats.length,
                itemBuilder: (context, index) {
                  final chatWithUser = filteredChats[index];

                  return ChatItemTile(
                    chatWithUser: chatWithUser,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/chat',
                        arguments: {
                          'currentUserId': currentUser.uid,
                          'otherUser': chatWithUser.otherUser,
                        },
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
