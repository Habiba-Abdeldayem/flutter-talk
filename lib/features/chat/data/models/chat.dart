import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final List<String> chatMembersId;
  final String chatId;
  final String lastMessage;
  final Timestamp lastMessageTime;

  Chat( {required this.chatMembersId, required this.chatId, required this.lastMessage, required this.lastMessageTime});
}
