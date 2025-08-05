import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/utils/chat_helpers.dart';
import 'package:flutter_talk/features/chat/data/models/message.dart';
import 'package:flutter_talk/features/chat/providers/send_message_notifier.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';

class MessageInputField extends ConsumerStatefulWidget {
  final String recieverId;
  const MessageInputField({super.key, required this.recieverId});

  @override
  ConsumerState<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends ConsumerState<MessageInputField> {
  final TextEditingController controller = TextEditingController();
  bool isSending = false;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _sendMessage(String senderId) async {
      final text = controller.text.trim();
  if (text.isEmpty) return;
    Message message = Message(
      senderId: senderId,
      recieverId: widget.recieverId,
      content: controller.text,
      timestamp: Timestamp.now(),
    );
final chatId = getChatRoomId(senderId, widget.recieverId);

    setState(() {
      isSending = true;
    });
      await ref
          .read(sendMessageNotifierProvider.notifier)
          .sendMessage(chatId, senderId, widget.recieverId, message);
      controller.clear();
    setState(() {
      isSending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserAsync = ref.watch(currentUserProvider);
if (!currentUserAsync.hasValue) return SizedBox();
final currentUser = currentUserAsync.value!;
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(hint: Text("message")),
          ),
        ),
        InkWell(
          onTap: () => _sendMessage(currentUser.uid),
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
