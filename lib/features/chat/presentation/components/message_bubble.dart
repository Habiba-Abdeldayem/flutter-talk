import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messageContent;
  const MessageBubble({super.key, required this.messageContent});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(messageContent));
  }
}
