import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/components/shared/app_error_widget.dart';
import 'package:flutter_talk/core/components/shared/app_loading_widget.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/core/utils/chat_helpers.dart';
import 'package:flutter_talk/features/chat/presentation/components/message_bubble.dart';
import 'package:flutter_talk/features/chat/providers/chat_providers.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';

class ChatMessagesList extends ConsumerStatefulWidget {
  final String recieverId;
  const ChatMessagesList({super.key, required this.recieverId});

  @override
  ConsumerState<ChatMessagesList> createState() => _ChatMessagesListState();
}

class _ChatMessagesListState extends ConsumerState<ChatMessagesList> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider).value!;
    final chatId = getChatRoomId(currentUser.uid, widget.recieverId);
    final chatMessages = ref.watch(chatMessagesProvider(chatId));
    return chatMessages.when(
      data: (data) {
        return ListView(
          children: data.map<Widget>((message) {
            bool isCurrentUser = message.senderId == currentUser.uid;
            var alignment = isCurrentUser
                ? Alignment.centerRight
                : Alignment.centerLeft;
            return Container(
              alignment: alignment,
              child: MessageBubble(
                message: message,
                isCurrentUser: isCurrentUser,
              ),
            );
          }).toList(),
        );
      },
      error: (error, stackTrace) =>
          const AppErrorWidget(error: AppStrings.somethingWentWrong),
      loading: () => const AppLoadingWidget(),
    );

  }
}
