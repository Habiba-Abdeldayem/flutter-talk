import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/features/user/models/user_model.dart';
import 'package:flutter_talk/features/auth/controllers/signin_controller.dart';
import 'package:flutter_talk/features/auth/providers/auth_repository_provider.dart';



/// StreamProvider for auth state changes (login/logout)
final authStateProvider = StreamProvider<User?>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return authRepo.authStateChanges();
});

final signInControllerProvider = AsyncNotifierProvider.autoDispose<SignInController, UserModel?>(() => SignInController());