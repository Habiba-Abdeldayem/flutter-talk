import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/app_sizes.dart';
import 'package:flutter_talk/core/utils/chat_helpers.dart';
import 'package:flutter_talk/features/chat/data/models/message.dart';
import 'package:flutter_talk/features/chat/data/services/chat_messages_service.dart';
import 'package:flutter_talk/features/chat/presentation/components/message_bubble.dart';

class ChatPage extends StatelessWidget {
  final String userId1;
  final String userId2;
  ChatPage({super.key, required this.userId1, required this.userId2});
  final TextEditingController controller = TextEditingController();
  final ChatMessagesService _chatMessagesService = ChatMessagesService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("chatId")),
      body: Column(
        children: [
          Expanded(child: _buildChatLayout()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildChatLayout() {
    final chatId = getChatRoomId(userId1, userId2);
    return StreamBuilder(
      stream: _chatMessagesService.getChatMessages(chatId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return const Center(child: Text("Something went wrong"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.map<Widget>((message) {
            return MessageBubble(messageContent: message.content);
          }).toList(),
        );
      },
    );
  }

  Widget _buildUserInput() {
    final chatId = getChatRoomId(userId1, userId2);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(hint: Text("message")),
          ),
        ),
        GestureDetector(
          onTap: () {
            _chatMessagesService.sendMessage(
              chatId,
              userId1,
              userId2,
              Message(
                senderId: userId1,
                recieverId: userId2,
                content: controller.text,
                timestamp: Timestamp.now(),
              ),
            );
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(AppSizes.radius),
            ),
            child: Icon(Icons.send, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
