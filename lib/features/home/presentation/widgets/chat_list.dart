import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';
import 'package:flutter_talk/features/home/data/user_chats_service.dart';
import 'package:flutter_talk/features/home/presentation/widgets/chat_item_tile.dart';

class ChatList extends StatelessWidget {
  final String currentUserId;
  ChatList({super.key, required this.currentUserId});
  final _userChatsService = UserChatsService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userChatsService.getUserChatsWithUsers(currentUserId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(AppSizes.medium),
          child: ListView(
            children: snapshot.data!
                .where(
                  (chatWithUser) =>
                      chatWithUser.chat.lastMessage != null &&
                      chatWithUser.chat.lastMessageTime != null,
                )
                .map<Widget>((chatWithUser) {
                  return ChatItemTile(
                    chatWithUser: chatWithUser,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/chat',
                        arguments: {
                          'currentUserId': currentUserId,
                          'otherUser': chatWithUser.otherUser,
                        },
                      );
                    },
                  );
                })
                .toList(),
          ),
        );
      },
    );
  }
}


              // return FutureBuilder(
              //   future: _userService.getUserById(otherUserId),
              //   builder: (context, userSnapshot) {
              //     if (userSnapshot.connectionState == ConnectionState.waiting) {
              //       return const ListTile(title: Text("Loading user..."));
              //     }
              //     if (!userSnapshot.hasData || userSnapshot.hasError) {
              //       return const ListTile(title: Text("Error loading user"));
              //     }

              //     final user = userSnapshot.data!;
              //     return ChatItemTile(
              //       chatData: chat,
              //       onTap: () {
              //         Navigator.pushNamed(context, '/chat', arguments: chat);
              //       },
              //       name: user.displayName,
              //     );
              //   },
              // );