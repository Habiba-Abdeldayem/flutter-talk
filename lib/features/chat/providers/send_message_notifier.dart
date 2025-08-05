import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/features/chat/data/models/message.dart';
import 'package:flutter_talk/features/chat/providers/chat_providers.dart';

final sendMessageNotifierProvider = AsyncNotifierProvider<SendMessageNotifier, void>(()=> SendMessageNotifier());
class SendMessageNotifier extends AsyncNotifier {
  @override
  Future<void> build() async {}

  Future<void> sendMessage(
    String chatId,
    String user1Id,
    String user2Id,
    Message message,
  ) async {
    final chatRepo = ref.read(chatRepositoryProvider);
    state = const AsyncLoading();

    try{
      await chatRepo.sendMessage(chatId, user1Id, user2Id, message);
      state = const AsyncData(null);
    }catch (e,st){
      state = AsyncError(e, st);
    }
  }
}
