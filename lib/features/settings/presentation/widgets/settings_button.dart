import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const SettingsButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(icon, color: color ?? colorScheme.onSurface),
      title: Text(
        label,
        style: TextStyle(color: color ?? colorScheme.onSurface),
      ),
      onTap: onTap,
    );
  }
}
