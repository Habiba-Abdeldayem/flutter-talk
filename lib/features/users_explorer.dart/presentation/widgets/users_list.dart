import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/app_sizes.dart';
import 'package:flutter_talk/features/users_explorer.dart/data/users_service.dart';
import 'package:flutter_talk/features/users_explorer.dart/presentation/widgets/user_tile.dart';

class UsersList extends StatelessWidget {
  final String currentUserId;
  UsersList({super.key, required this.currentUserId});
  final _usersService = UsersService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _usersService.getOtherUsers(currentUserId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(AppSizes.medium),
          child: ListView(
            children: snapshot.data!
                .map<Widget>(
                  (userData) => UserTile(
                    userModel: userData,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/chat',
                        arguments: {
                          'currentUserId': currentUserId,
                          'otherUser': userData,
                        },
                      );
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
