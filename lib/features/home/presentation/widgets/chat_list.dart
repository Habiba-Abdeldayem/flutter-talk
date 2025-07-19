import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/app_sizes.dart';
import 'package:flutter_talk/features/home/data/user_chats_service.dart';
import 'package:flutter_talk/features/home/presentation/widgets/chat_item_tile.dart';

class ChatList extends StatelessWidget {
  final String currentUserId;
  ChatList({super.key, required this.currentUserId});
  final _userChatsService = UserChatsService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userChatsService.getUserChats(currentUserId),
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
                .map<Widget>((chatData) => ChatItemTile(chatData: chatData))
                .toList(),
          ),
        );
      },
    );
  }
}
