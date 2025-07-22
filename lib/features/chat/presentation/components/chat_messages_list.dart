import 'package:flutter/material.dart';
import 'package:flutter_talk/core/utils/chat_helpers.dart';
import 'package:flutter_talk/features/auth/data/auth_repository.dart';
import 'package:flutter_talk/features/chat/data/services/chat_messages_service.dart';
import 'package:flutter_talk/features/chat/presentation/components/message_bubble.dart';

class ChatMessagesList extends StatefulWidget {
  final String senderId;
  final String recieverId;
  const ChatMessagesList({
    super.key,
    required this.senderId,
    required this.recieverId,
  });

  @override
  State<ChatMessagesList> createState() => _ChatMessagesListState();
}

class _ChatMessagesListState extends State<ChatMessagesList> {
  final AuthRepository _authRepository = AuthRepository();
  final ChatMessagesService _chatMessagesService = ChatMessagesService();

  @override
  Widget build(BuildContext context) {
    final chatId = getChatRoomId(widget.senderId, widget.recieverId);
    return StreamBuilder(
      stream: _chatMessagesService.getChatMessages(chatId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.map<Widget>((message) {
            bool isCurrentUser =
                message.senderId == _authRepository.getCurrentUser()!.uid;
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
    );
  }
}
