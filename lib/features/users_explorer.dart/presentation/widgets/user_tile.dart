import 'package:flutter/material.dart';
import 'package:flutter_talk/core/models/user_model.dart';
import 'package:flutter_talk/core/themes/app_sizes.dart';

class UserTile extends StatelessWidget {
  final UserModel userModel;
  const UserTile({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(AppSizes.medium),
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(AppSizes.radius),
              child: Image.asset(
                "lib/core/images/user_avatar.png",
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(width: AppSizes.medium),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userModel.displayName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSizes.xs),
                      Text(
                        userModel.email,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Icon(Icons.message),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
