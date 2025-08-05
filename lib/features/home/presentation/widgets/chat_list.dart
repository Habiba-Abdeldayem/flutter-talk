import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/components/shared/app_error_widget.dart';
import 'package:flutter_talk/core/components/shared/app_loading_widget.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';
import 'package:flutter_talk/features/chat/providers/chat_providers.dart';
import 'package:flutter_talk/features/home/presentation/widgets/chat_item_tile.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(currentUserProvider).asData!.value!.uid;
    final userChatsWithUsers = ref.watch(
      userChatsWithUsersProvider(currentUserId),
    );
    return userChatsWithUsers.when(
      error: (error, stackTrace) => AppErrorWidget(error: error.toString()),
      loading: () => AppLoadingWidget(),
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(AppSizes.medium),
          child: ListView(
            children: data
                .where(
                  (chatWithUser) =>
                      chatWithUser.chat.lastMessage != null &&
                      chatWithUser.chat.lastMessageTime != null,
                )
                .map<Widget>((chatWithUser) {
                  return ChatItemTile(
                    chatWithUser: chatWithUser,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/chat',
                        arguments: {
                          'currentUserId': currentUserId,
                          'otherUser': chatWithUser.otherUser,
                        },
                      );
                    },
                  );
                })
                .toList(),
          ),
        );
      },
    );
  }
}
