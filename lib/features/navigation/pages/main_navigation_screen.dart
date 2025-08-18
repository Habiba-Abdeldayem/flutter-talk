import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/features/home/providers/selected_tab_provider.dart';
import 'package:flutter_talk/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter_talk/features/user/models/user_model.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_talk/features/profile/presentation/screens/profile_screen.dart';

class MainNavigationPage extends ConsumerStatefulWidget {
  final UserModel currentUser;
  const MainNavigationPage({super.key, required this.currentUser});

  @override
  ConsumerState<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends ConsumerState<MainNavigationPage> {
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomePage(currentUser: widget.currentUser),
      ProfileScreen(),
      SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedTabProvider);
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex) => setState(
          () => ref.read(selectedTabProvider.notifier).state = newIndex,
        ),
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
