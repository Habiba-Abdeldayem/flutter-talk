import 'package:flutter/material.dart';
import 'package:flutter_talk/features/auth/presentation/pages/auth_gate.dart';
import 'package:flutter_talk/features/chat/presentation/pages/chat_page.dart';
import 'package:flutter_talk/features/home/presentation/pages/home_page.dart';
import 'package:flutter_talk/features/profile/presentation/pages/edit_profile_info_page.dart';
import 'package:flutter_talk/features/users_explorer.dart/presentation/pages/users_explorer_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const AuthGate());
      case '/home':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => HomePage(currentUser: args['currentUser']),
        );
      case '/users_explorer':
        return MaterialPageRoute(builder: (context) => UsersExplorerPage());
      case '/chat':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ChatPage(
            senderId: args['currentUserId'],
            recieverUserModel: args['otherUser'],
          ),
        );
      case '/edit_profile_info':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => EditProfileInfoPage(
            fieldType: args['fieldType'],
            currentUser: args['currentUser'],
       
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) => const AuthGate());
    }
  }
}
