import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';

class ProfileSection extends ConsumerWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDataProvider);
    if (currentUser == null) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profile'); 
      },
      child: Card(
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // User Photo
              CircleAvatar(
                radius: 35,
                backgroundImage:
                    (currentUser.photoUrl != null &&
                        currentUser.photoUrl!.isNotEmpty)
                    ? NetworkImage(currentUser.photoUrl!)
                    : null,
                child:
                    (currentUser.photoUrl == null ||
                        currentUser.photoUrl!.isEmpty)
                    ? const Icon(Icons.person, size: 40)
                    : null,
              ),
              const SizedBox(width: 16),
              // Text Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentUser.displayName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (currentUser.email.isNotEmpty)
                      Text(
                        currentUser.email,
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (currentUser.phone != null &&
                        currentUser.phone!.isNotEmpty)
                      Text(
                        currentUser.phone!,
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (currentUser.bio != null && currentUser.bio!.isNotEmpty)
                      Text(
                        currentUser.bio!,
                        style: TextStyle(color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
