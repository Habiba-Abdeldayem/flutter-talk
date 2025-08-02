import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/components/shared/app_error_widget.dart';
import 'package:flutter_talk/core/components/shared/app_loading_widget.dart';
import 'package:flutter_talk/features/auth/presentation/pages/login_or_register_screen.dart';
import 'package:flutter_talk/features/auth/providers/auth_state_provider.dart';
import 'package:flutter_talk/features/user/presentation/widgets/current_user_handler.dart';

class AuthStateHandler extends ConsumerWidget {
  const AuthStateHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authStateProvider);

    return userState.when(
        error: (error, stackTrace) {
          return AppErrorWidget(error.toString());
        },
        loading: () {
          return AppLoadingWidget();
        },
        data: (firebaseUser) {
          if (firebaseUser != null) {
            return CurrentUserHandler(firebaseUser: firebaseUser,);
          }
          return const LoginOrRegisterPage();
        },
      );
  }
}