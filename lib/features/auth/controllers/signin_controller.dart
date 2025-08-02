import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/features/user/models/user_model.dart';
import 'package:flutter_talk/features/auth/providers/auth_repository_provider.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';

class SignInController extends AutoDisposeAsyncNotifier<UserModel?> {
  @override
  FutureOr<UserModel?> build() {
    return null;
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final authRepo = ref.read(authRepositoryProvider);
      final user = await authRepo.signIn(email, password);
      state = AsyncValue.data(user);
      await ref.read(currentUserProvider.notifier).reload();
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
