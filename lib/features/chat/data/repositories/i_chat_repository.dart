import 'package:flutter_talk/features/chat/data/models/chat_with_user.dart';
import 'package:flutter_talk/features/chat/data/models/message.dart';

abstract class IChatRepository {
  Stream<List<Message>> getChatMessages(String chatId);
  Future<void> sendMessage(
    String chatId,
    String user1Id,
    String user2Id,
    Message message,
  );

  Future<bool> doesChatExist(String chatId);

  Stream<List<ChatWithUser>> getUserChatsWithUsers(String currentUserId);
}
