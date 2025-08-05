import 'package:flutter/material.dart';
import 'package:flutter_talk/features/auth/presentation/pages/auth_gate.dart';
import 'package:flutter_talk/features/chat/presentation/screens/chat_screen.dart';
import 'package:flutter_talk/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_talk/features/profile/presentation/screens/edit_profile_info_screen.dart';
import 'package:flutter_talk/features/users_explorer.dart/presentation/screens/users_explorer_screen.dart';

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
          builder: (context) => ChatPage(recieverUserModel: args['otherUser']),
        );
      case '/edit_profile_info':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) =>
              EditProfileInfoPage(fieldType: args['fieldType']),
        );
      default:
        return MaterialPageRoute(builder: (context) => const AuthGate());
    }
  }
}
