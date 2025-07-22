import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talk/core/utils/chat_helpers.dart';
import 'package:flutter_talk/features/chat/data/models/message.dart';
import 'package:flutter_talk/features/chat/data/services/chat_messages_service.dart';

class MessageInputField extends StatefulWidget {
  final String senderId;
  final String recieverId;
  const MessageInputField({
    super.key,
    required this.senderId,
    required this.recieverId,
  });

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController controller = TextEditingController();
  final ChatMessagesService _chatMessagesService = ChatMessagesService();
  late final String chatId;
  bool isSending = false;

  @override
  void initState() {
    chatId = getChatRoomId(widget.senderId, widget.recieverId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _sendMessage() async {
    setState(() {
      isSending = true;
    });
    if (controller.text.trim().isNotEmpty) {
      await _chatMessagesService.sendMessage(
        chatId,
        widget.senderId,
        widget.recieverId,
        Message(
          senderId: widget.senderId,
          recieverId: widget.recieverId,
          content: controller.text,
          timestamp: Timestamp.now(),
        ),
      );
      controller.clear();
    }
    setState(() {
      isSending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(hint: Text("message")),
          ),
        ),
        InkWell(
          onTap: _sendMessage,
          borderRadius: BorderRadius.circular(100),
          child: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: isSending
                ? SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                : Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
          ),
        ),
      ],
    );
  }
}
