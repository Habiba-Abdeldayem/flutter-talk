import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;

  const UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
  });

  // Factory to create from firebase user
  // In Dart, a factory constructor is a special type of constructor that can:
  // return an instance of the class, or even
  // return an existing instance, or
  // return a different subclass

  // It's used when you need some logic before creating an object, not just directly assigning values like in a normal constructor.
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }
}
