import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_talk/core/components/shared/app_search_bar.dart';
import 'package:flutter_talk/core/constants/app_hints.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/features/user/models/user_model.dart';
import 'package:flutter_talk/features/auth/data/auth_repository.dart';
import 'package:flutter_talk/features/home/presentation/widgets/chat_list.dart';

class HomePage extends StatelessWidget {
  final UserModel currentUser;
  HomePage({super.key, required this.currentUser});
  
  final _authRepository = AuthRepository();
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.chats, style: Theme.of(context).textTheme.displayLarge),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _authRepository.signOut();
            },
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/users_explorer');
        },
        child: Icon(Icons.add),
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          AppSearchBar(
            hintText: AppHints.searchHint,
            searchByName: (value) => log(value),
            controller: controller,
          ),
          Expanded(
            child:const ChatList(
            ),
          ),
        ],
      ),
    );
  }
}
