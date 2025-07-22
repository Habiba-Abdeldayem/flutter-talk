import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_talk/core/constants/firestore_keys.dart';
import 'package:flutter_talk/core/services/user_service.dart';
import 'package:flutter_talk/features/chat/data/models/chat.dart';
import 'package:flutter_talk/features/chat/data/models/chat_with_user.dart';

class UserChatsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserService _userService = UserService();

  Stream<List<Chat>> getUserChats(String currentUserId) {
    return _firestore
        .collection(FirestoreKeys.chats)
        .where(FirestoreKeys.chatMembersId, arrayContains: currentUserId)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Chat.fromMap(doc.data())).toList(),
        );
  }

  // Stream<List<ChatWithUser>> getUserChatsWithUsers(
  //   String currentUserId,
  // ) async* {
  //   final snapshot = await _firestore
  //       .collection(FirestoreKeys.chats)
  //       .where(FirestoreKeys.chatMembersId, arrayContains: currentUserId)
  //       .get();

  //   final chats = snapshot.docs.map((doc) => Chat.fromMap(doc.data())).toList();

  //   final otherUsersId = chats
  //       .map(
  //         (chat) => chat.chatMembersId.firstWhere((id) => id != currentUserId),
  //       )
  //       .toList();

  //   final usersSnapshots = await Future.wait(
  //     otherUsersId.map((id) => _userService.getUserById(id)),
  //   );
  //   final chatsWithUsers = <ChatWithUser>[];
  //   for (int i = 0; i < chats.length; i++) {
  //     chatsWithUsers.add(
  //       ChatWithUser(chat: chats[i], otherUser: usersSnapshots[i]!),
  //     );
  //   }

  //   yield chatsWithUsers;
  // }
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
            otherUsersId.map((id) => _userService.getUserById(id)),
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
          // return List.generate(
          //   otherUsersId.length,
          //   (i) => ChatWithUser(chat: chats[i], otherUser: otherUsers[i]!),
          // );
        });
  }
}
