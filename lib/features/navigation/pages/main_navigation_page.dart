import 'package:flutter/material.dart';
import 'package:flutter_talk/core/models/user_model.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/features/home/presentation/pages/home_page.dart';
import 'package:flutter_talk/features/profile/presentation/pages/profile_screen.dart';

class MainNavigationPage extends StatefulWidget {
  final UserModel currentUser;
  const MainNavigationPage({super.key, required this.currentUser});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomePage(currentUser: widget.currentUser),
      ProfileScreen(currentUser: widget.currentUser),
      PlaceholderScreen(title: "Settings"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (newIndex) => setState(() => _selectedIndex = newIndex),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: AppStrings.chats,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppStrings.profile,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppStrings.settings,
          ),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('$title screen coming soon...')));
  }
}
