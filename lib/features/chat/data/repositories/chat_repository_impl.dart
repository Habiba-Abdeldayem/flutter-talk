import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_talk/core/constants/firestore_keys.dart';
import 'package:flutter_talk/features/chat/data/models/chat.dart';
import 'package:flutter_talk/features/chat/data/models/chat_with_user.dart';
import 'package:flutter_talk/features/chat/data/models/message.dart';
import 'package:flutter_talk/features/chat/data/repositories/i_chat_repository.dart';
import 'package:flutter_talk/features/user/data/user_repository.dart';

class ChatRepositoryImplementation implements IChatRepository {
   final FirebaseFirestore _firestore;
  final UserRepository _userRepo;

  ChatRepositoryImplementation({
    required FirebaseFirestore firestore,
    required UserRepository userRepo,
  })  : _firestore = firestore,
        _userRepo = userRepo;

  @override
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

  @override
  Future<void> sendMessage(
    String chatId,
    String user1Id,
    String user2Id,
    Message message,
  ) async {
    try {
      final chatReference = _firestore
          .collection(FirestoreKeys.chats)
          .doc(chatId);
      final chatDoc = await chatReference.get();

      if (chatDoc.exists) {
        await _updateChatMetadata(chatReference, message);
      } else {
        await _createNewChat(chatReference, user1Id, user2Id, chatId, message);
      }

      await _addMessageToChat(chatId, message);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> doesChatExist(String chatId) async {
    try {
  final chatRef = await _firestore
      .collection(FirestoreKeys.chats)
      .doc(chatId)
      .get();
  
  return chatRef.exists;
} on Exception catch (e) {
  throw Exception(e.toString());
}
  }

  @override
  Stream<List<ChatWithUser>> getUserChatsWithUsers(String currentUserId) {
    return _firestore
        .collection(FirestoreKeys.chats)
        .where(FirestoreKeys.chatMembersId, arrayContains: currentUserId)
        .orderBy(FirestoreKeys.lastMessageTime, descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
          final chats = snapshot.docs
              .map((doc) => Chat.fromMap(doc.data()))
              .toList();

          final otherUsersId = chats
              .map(
                (chat) =>
                    chat.chatMembersId.firstWhere((id) => id != currentUserId),
              )
              .toList();

          final otherUsers = await Future.wait(
            otherUsersId.map((id) => _userRepo.fetchUserModelByUID(id)),
          );

          // filter any null user
          final validChats = <ChatWithUser>[];
          for (int i = 0; i < otherUsers.length; i++) {
            if (otherUsers[i] != null) {
              validChats.add(
                ChatWithUser(chat: chats[i], otherUser: otherUsers[i]!),
              );
            }
          }
          return validChats;
        });
  }

  Future<void> _updateChatMetadata(
    DocumentReference chatReference,
    Message message,
  ) async {
    await chatReference.update({
      FirestoreKeys.lastMessage: message.content,
      FirestoreKeys.lastMessageTime: message.timestamp,
    });
  }

  Future<void> _createNewChat(
    DocumentReference chatReference,
    String user1Id,
    String user2Id,
    String chatId,
    Message message,
  ) {
    return chatReference.set({
      FirestoreKeys.lastMessage: message.content,
      FirestoreKeys.lastMessageTime: message.timestamp,
      FirestoreKeys.chatMembersId: [user1Id, user2Id],
      FirestoreKeys.chatId: chatId,
    });
  }

  Future<void> _addMessageToChat(String chatId, Message message) {
    return _firestore
        .collection(FirestoreKeys.chats)
        .doc(chatId)
        .collection(FirestoreKeys.messages)
        .add(message.toMap());
  }
}
