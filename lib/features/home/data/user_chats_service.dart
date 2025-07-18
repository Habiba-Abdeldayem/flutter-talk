import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_talk/core/constants/firestore_keys.dart';

class UserChatsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUserChats(String currentUserId) {
    return _firestore
        .collection(FirestoreKeys.chats)
        .where(FirestoreKeys.chatMembersId, arrayContains: currentUserId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final chat = doc.data();
            return chat;
          }).toList();
        });
    // .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // getChatById
}
