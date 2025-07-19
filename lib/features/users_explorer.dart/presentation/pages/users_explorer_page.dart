import 'package:flutter/material.dart';
import 'package:flutter_talk/core/components/shared/app_search_bar.dart';
import 'package:flutter_talk/features/auth/data/auth_repository.dart';
import 'package:flutter_talk/features/users_explorer.dart/presentation/widgets/users_list.dart';

class UsersExplorerPage extends StatelessWidget {
  UsersExplorerPage({super.key});
  final TextEditingController controller = TextEditingController();
  final _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users", style: Theme.of(context).textTheme.displayLarge),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          AppSearchBar(
            hintText: 'Search',
            searchByName: (value) => print(value),
            controller: controller,
          ),
          Expanded(
            child: UsersList(
              currentUserId: _authRepository.getCurrentUser()!.uid,
            ),
          ),
        ],
      ),
    );
  }
}
