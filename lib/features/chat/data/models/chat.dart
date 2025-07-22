import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_talk/core/constants/firestore_keys.dart';

class Chat {
  final List<String> chatMembersId;
  final String chatId;
  final String? lastMessage;
  final Timestamp? lastMessageTime;

  Chat({
    required this.chatMembersId,
    required this.chatId,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  Map<String, dynamic> toMap() {
    return {
      FirestoreKeys.chatMembersId: chatMembersId,
      FirestoreKeys.chatId: chatId,
      FirestoreKeys.lastMessage: lastMessage,
      FirestoreKeys.lastMessageTime: lastMessageTime,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      chatMembersId: List<String>.from(map[FirestoreKeys.chatMembersId]),
      chatId: map[FirestoreKeys.chatId],
      lastMessage: map[FirestoreKeys.lastMessage],
      lastMessageTime: map[FirestoreKeys.lastMessageTime],
    );
  }

  /// For updating a field
  Chat copyWith({
    final List<String>? chatMembersId,
    final String? chatId,
    final String? lastMessage,
    final Timestamp? lastMessageTime,
  }) {
    return Chat(
      chatMembersId: chatMembersId ?? this.chatMembersId,
      chatId: chatId ?? this.chatId,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
    );
  }
}
