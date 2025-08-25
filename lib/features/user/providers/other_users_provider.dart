import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/providers/search_query_provider.dart';
import 'package:flutter_talk/features/user/models/user_model.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';

final otherUsersProvider = StreamProvider.autoDispose<List<UserModel>>((ref) {
  final userRepo = ref.watch(userRepositoryProvider);
  final currentUser = ref.watch(currentUserDataProvider);
  if (currentUser == null) {
    return const Stream.empty();
  }
  return userRepo.fetchAllUsersExcluding(currentUser.uid);
});

final userByIdProvider = StreamProvider.family<UserModel?, String>((ref, uid) {
  final userRepo = ref.watch(userRepositoryProvider);
  return userRepo.fetchUserStreamByUID(uid);
});

// filtered users based on search
final filteredUsersProvider = Provider.autoDispose<List<UserModel>>((ref) {
  final usersAsync = ref.watch(otherUsersProvider);
  final query = ref.watch(searchQueryProvider(SearchContext.users));

  return usersAsync.when(
    data: (users) {
      if (query.isEmpty) return users;
      final lowerQuery = query.toLowerCase();
      return users.where((u) {
        return u.displayName.toLowerCase().contains(lowerQuery) ||
            u.email.toLowerCase().contains(lowerQuery);
      }).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
});
