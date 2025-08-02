import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/components/shared/app_error_widget.dart';
import 'package:flutter_talk/core/components/shared/app_loading_widget.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';
import 'package:flutter_talk/features/navigation/pages/main_navigation_screen.dart';

class CurrentUserHandler extends ConsumerWidget {
  final User? firebaseUser;
  const CurrentUserHandler({super.key, required this.firebaseUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return currentUser.when(
      loading: () {
        return AppLoadingWidget();
      },
      error: (error, stackTrace) {
        return AppErrorWidget(error.toString());
      },
      data: (data) {
        if (data == null) return AppErrorWidget('No user data found');
        return MainNavigationPage(currentUser: data);
      },
    );
  }
}
