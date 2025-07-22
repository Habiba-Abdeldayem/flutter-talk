import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';
import 'package:flutter_talk/core/utils/chat_helpers.dart';
import 'package:flutter_talk/features/chat/data/models/chat_with_user.dart';

class ChatItemTile extends StatelessWidget {
  // final Chat chatData;
  final ChatWithUser chatWithUser;
  final void Function()? onTap;
  const ChatItemTile({
    super.key,
    // required this.chatData,
    required this.chatWithUser,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizes.medium),
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(AppSizes.radius),
              child: Image.asset(
                "lib/core/images/user_avatar.png",
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(width: AppSizes.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chatWithUser.otherUser.displayName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        formatTimestamp(chatWithUser.chat.lastMessageTime!),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    chatWithUser.chat.lastMessage!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
