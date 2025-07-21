import 'package:flutter_talk/core/models/user_model.dart';
import 'package:flutter_talk/features/chat/data/models/chat.dart';

class ChatWithUser {
  final Chat chat;
  final UserModel otherUser;

  ChatWithUser({required this.chat, required this.otherUser});
}
