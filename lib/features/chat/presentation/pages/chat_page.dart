import 'package:flutter/material.dart';
import 'package:flutter_talk/core/models/user_model.dart';
import 'package:flutter_talk/features/chat/presentation/components/chat_messages_list.dart';
import 'package:flutter_talk/features/chat/presentation/components/message_input_field.dart';

class ChatPage extends StatelessWidget {
  final String senderId;
  final UserModel recieverUserModel;
  const ChatPage({
    super.key,
    required this.senderId,
    required this.recieverUserModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recieverUserModel.displayName)),
      body: Column(
        children: [
          Expanded(
            child: ChatMessagesList(
              senderId: senderId,
              recieverId: recieverUserModel.uid,
            ),
          ),
          MessageInputField(
            senderId: senderId,
            recieverId: recieverUserModel.uid,
          ),
        ],
      ),
    );
  }
}
