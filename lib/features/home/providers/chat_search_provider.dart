// filter chatted users locally
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/providers/search_query_provider.dart';
import 'package:flutter_talk/features/chat/data/models/chat_with_user.dart';
import 'package:flutter_talk/features/chat/providers/chat_providers.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';

final chatSearchProvider = Provider.autoDispose<List<ChatWithUser>>((ref) {
  final currentUserAsync = ref.watch(currentUserProvider);
  final searchQuery = ref
      .watch(searchQueryProvider(SearchContext.chats))
      .toLowerCase();

  if (!currentUserAsync.hasValue) return [];

  final currentUserId = currentUserAsync.value!.uid;
  final chatsAsync = ref.watch(userChatsWithUsersProvider(currentUserId));

  return chatsAsync.when(
    data: (chats) {
      if (searchQuery.isEmpty) return chats;
      return chats.where((chat) {
        return chat.otherUser.displayName.toLowerCase().contains(searchQuery) ||
            chat.otherUser.email.toLowerCase().contains(searchQuery) ||
            (chat.chat.lastMessage?.toLowerCase().contains(searchQuery) ??
                false);
      }).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
});
