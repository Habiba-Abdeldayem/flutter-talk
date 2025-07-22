import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';
import 'package:flutter_talk/core/utils/chat_helpers.dart';
import 'package:flutter_talk/features/chat/data/models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;
  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AppSizes.xs,
        horizontal: AppSizes.small,
      ),
      padding: EdgeInsets.all(AppSizes.medium),
      // If message is long, take 70% only of the screen width
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radius),
          topRight: Radius.circular(AppSizes.radius),
          bottomLeft: isCurrentUser
              ? Radius.circular(AppSizes.radius)
              : Radius.zero,
          bottomRight: isCurrentUser
              ? Radius.zero
              : Radius.circular(AppSizes.radius),
        ),
        color: isCurrentUser
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(message.content),
          Text(formatTimestamp(message.timestamp)),
        ],
      ),
    );
  }
}
