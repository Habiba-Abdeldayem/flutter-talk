import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_talk/core/constants/firestore_keys.dart';
import 'package:flutter_talk/features/chat/data/models/message.dart';

class ChatMessagesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Message>> getChatMessages(String chatId) {
    return _firestore
        .collection(FirestoreKeys.chats)
        .doc(chatId)
        .collection(FirestoreKeys.messages)
        .orderBy(FirestoreKeys.timestamp, descending: false)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList(),
        );
  }

  Future<void> sendMessage(
    String chatId,
    String user1Id,
    String user2Id,
    Message message,
  ) async {
    final chatReference = _firestore
        .collection(FirestoreKeys.chats)
        .doc(chatId);
    final chatDoc = await chatReference.get();

    if (chatDoc.exists) {
      await chatReference.update({
        FirestoreKeys.lastMessage: message.content,
        FirestoreKeys.lastMessageTime: message.timestamp,
      });
    } else {
      await chatReference.set({
        FirestoreKeys.lastMessage: message.content,
        FirestoreKeys.lastMessageTime: message.timestamp,
        FirestoreKeys.chatMembersId: [user1Id, user2Id],
        FirestoreKeys.chatId: chatId,
      });
    }

    await _firestore
        .collection(FirestoreKeys.chats)
        .doc(chatId)
        .collection(FirestoreKeys.messages)
        .add(message.toMap());
  }

  Future<bool> doesChatExist(String chatId) async {
    final chatRef = await _firestore
        .collection(FirestoreKeys.chats)
        .doc(chatId)
        .get();

    if (chatRef.exists) {
      return true;
    }
    return false;
  }
}
