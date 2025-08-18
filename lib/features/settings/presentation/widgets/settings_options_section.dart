import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/core/themes/modes/theme_notifier.dart';
import 'package:flutter_talk/features/auth/providers/auth_repository_provider.dart';
import 'package:flutter_talk/features/home/providers/selected_tab_provider.dart';
import 'package:flutter_talk/features/settings/presentation/widgets/settings_button.dart';

class SettingsOptionsSection extends StatelessWidget {
  const SettingsOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsButton(
          icon: Icons.edit,
          label: AppStrings.editProfile,
          onTap: () => Navigator.pushNamed(context, '/profile'),
        ),
        Consumer(
          builder: (context, ref, child) {
            final themeMode = ref.watch(themeNotifierProvider);
            return SwitchListTile(
              secondary: Icon(
                themeMode == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
                // color: Theme.of(context).primaryColor,
              ),
              title: const Text(AppStrings.darkMode),
              value: themeMode == ThemeMode.dark,
              onChanged: (value) {
                ref.read(themeNotifierProvider.notifier).toggleTheme();
              },
            );
          },
        ),
        SettingsButton(
          icon: Icons.notifications,
          label: AppStrings.notifications,
          onTap: () => Navigator.pushNamed(context, '/notifications'),
        ),
        SettingsButton(
          icon: Icons.lock,
          label: AppStrings.privacy,
          onTap: () => Navigator.pushNamed(context, '/privacy'),
        ),
        Consumer(
          builder: (context, ref, child) {
            return SettingsButton(
              icon: Icons.logout,
              label: AppStrings.logout,
              onTap: () async {
                await ref.read(authRepositoryProvider).signOut();
                ref.read(selectedTabProvider.notifier).state = 0;
                if (!context.mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (_) => false,
                );
              },
              color: Colors.red,
            );
          },
        ),
      ],
    );
  }
}
