import 'package:flutter/material.dart';

class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(height: 180, color: Colors.teal[100]),
            Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width / 2 - 50,
              bottom: -80,
              child: InkWell(
                onTap: () {
                  // TODO show image/image picker
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(
                      "lib/core/images/user_avatar.png",
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
  }
}