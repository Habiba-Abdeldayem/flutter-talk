import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/features/user/data/user_repository.dart';
import 'package:flutter_talk/features/user/models/user_model.dart';
import 'package:flutter_talk/features/auth/providers/auth_state_provider.dart';

final currentUserProvider =
    AsyncNotifierProvider.autoDispose<CurrentUserNotifier, UserModel?>(
      () => CurrentUserNotifier(),
    );

class CurrentUserNotifier extends AutoDisposeAsyncNotifier<UserModel?> {
  final UserRepository userRepo = UserRepository();

  @override
  FutureOr<UserModel?> build() async {
    final firebaseUser = await ref.watch(authStateProvider.future);

    if (firebaseUser == null) return null;
    return userRepo.fetchUserModelByUID(firebaseUser.uid);
  }

  Future<void> reload() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final firebaseUser = await ref.read(authStateProvider.future);
      if (firebaseUser == null) return null;
      return await userRepo.fetchUserModelByUID(firebaseUser.uid);
    });
  }
}
