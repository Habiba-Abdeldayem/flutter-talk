import 'package:flutter/material.dart';
import 'package:flutter_talk/core/constants/firestore_keys.dart';
import 'package:flutter_talk/core/themes/app_sizes.dart';

class ChatItemTile extends StatelessWidget {
  final Map<String, dynamic> chatData;
  const ChatItemTile({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                        "John Doe",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "12:53 PM",
                        style: Theme.of(context).textTheme.bodySmall,
                        // chatData[FirestoreKeys.lastMessageTimeStamp].toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    chatData[FirestoreKeys.lastMessage],
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
