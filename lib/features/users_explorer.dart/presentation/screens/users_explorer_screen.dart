import 'package:flutter/material.dart';
import 'package:flutter_talk/core/components/shared/app_search_bar.dart';
import 'package:flutter_talk/core/constants/app_hints.dart';
import 'package:flutter_talk/core/providers/search_query_provider.dart';
import 'package:flutter_talk/features/users_explorer.dart/presentation/widgets/users_list.dart';

class UsersExplorerPage extends StatelessWidget {
  const UsersExplorerPage({super.key});

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
            hintText: AppHints.searchUsersByNameOrEmail,
            searchContext: SearchContext.users,
          ),
          Expanded(child: UsersList()),
        ],
      ),
    );
  }
}
