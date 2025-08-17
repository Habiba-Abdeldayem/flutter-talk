import 'package:flutter/material.dart';
import 'package:flutter_talk/features/user/models/user_model.dart';
import 'package:flutter_talk/features/chat/presentation/components/chat_messages_list.dart';
import 'package:flutter_talk/features/chat/presentation/components/message_input_field.dart';

class ChatPage extends StatelessWidget {
  final UserModel recieverUserModel;
  const ChatPage({super.key, required this.recieverUserModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/other_profile',
              arguments: {'profileId': recieverUserModel.uid},
            );
          },
          child: Row(
            children: [
              BackButton(onPressed: () => Navigator.pop(context)),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundImage: AssetImage("lib/core/images/user_avatar.png"),
              ),
              const SizedBox(width: 8),
              Text(
                recieverUserModel.displayName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(child: ChatMessagesList(recieverId: recieverUserModel.uid)),
          MessageInputField(recieverId: recieverUserModel.uid),
        ],
      ),
    );
  }
}
