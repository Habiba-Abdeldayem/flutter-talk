import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/app_sizes.dart';
import 'package:flutter_talk/features/home/data/user_chats_service.dart';
import 'package:flutter_talk/core/components/shared/contact_tile.dart';

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
          return Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading..");
        }
        return Padding(
          padding: const EdgeInsets.all(AppSizes.medium),
          child: ListView(
            children: snapshot.data!
                .map<Widget>((chatData) => ContactTile(chatData: chatData))
                .toList(),
          ),
        );
      },
    );
  }
}
