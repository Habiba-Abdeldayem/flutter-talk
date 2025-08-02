import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_talk/core/constants/firestore_keys.dart';
import 'package:flutter_talk/features/chat/data/models/chat.dart';
import 'package:flutter_talk/features/chat/data/models/chat_with_user.dart';
import 'package:flutter_talk/features/user/data/user_repository.dart';

class UserChatsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserRepository _userRepo = UserRepository();

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
}
