// import 'package:flutter/material.dart';
// import 'package:flutter_talk/core/models/user_model.dart';
// import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';

// class CurrentUserProfile extends StatelessWidget {
//   final UserModel currentUser;
//   const CurrentUserProfile({super.key, required this.currentUser});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Container(height: 180, color: Colors.teal[100]),
//             Positioned(
//               top: 100,
//               left: MediaQuery.of(context).size.width / 2 - 50,
//               bottom: -80,
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundColor: Colors.white,
//                 child: CircleAvatar(
//                   radius: 45,
//                   backgroundImage: AssetImage(
//                     "lib/core/images/user_avatar.png",
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 60),
//         Column(
//           children: [
//             Text(
//               currentUser.displayName,
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             Text("Bonie@k.com"),
//             Text("Joined on Aug 3, 2021"),
//             const SizedBox(height: 20),
//             // const SizedBox(height: 10),
//             Divider(height: 0.5),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(children: []),
//             ),
//           ],
//         ),
//         Column(
//           children: [
//             ListTile(leading: Icon(Icons.edit), title: Text("Edit Profile")),
//             ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
//             ListTile(leading: Icon(Icons.logout), title: Text("Logout")),
//           ],
//         ),
//       ],
//     );
//   }
// }
