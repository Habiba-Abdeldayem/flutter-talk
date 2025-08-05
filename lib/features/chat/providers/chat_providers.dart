import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/features/chat/data/models/chat_with_user.dart';
import 'package:flutter_talk/features/chat/data/models/message.dart';
import 'package:flutter_talk/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:flutter_talk/features/chat/data/repositories/i_chat_repository.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';

final chatRepositoryProvider = Provider<IChatRepository>(
  (ref){
      final firestore = FirebaseFirestore.instance;
  final userRepo = ref.watch(userRepositoryProvider);

  return ChatRepositoryImplementation(
    firestore: firestore,
    userRepo: userRepo,
  );
  },
);

final userChatsWithUsersProvider =
    StreamProvider.family<List<ChatWithUser>, String>((ref, uid) {
      final chatRepo = ref.watch(chatRepositoryProvider);
      return chatRepo.getUserChatsWithUsers(uid);
    });

final chatMessagesProvider = StreamProvider.family<List<Message>, String>((
  ref,
  chatId,
) {
  final chatRepo = ref.watch(chatRepositoryProvider);
  return chatRepo.getChatMessages(chatId);
});
