import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_talk/core/constants/firestore_keys.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;

  const UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
  });

  // Factory to create from firebase user
  // In Dart, a factory constructor is a special type of constructor that can:
  // return an instance of the class, or even
  // return an existing instance, or
  // return a different subclass

  // It's used when you need some logic before creating an object, not just directly assigning values like in a normal constructor.
  // Get user from FirebaseAuth.User
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoUrl: user.photoURL,
    );
  }

  // Get user from Firestore document
  factory UserModel.fromMap(Map<String, dynamic> userData) {
    return UserModel(
      uid: userData[FirestoreKeys.uid],
      email: userData[FirestoreKeys.email] ?? '',
      displayName: userData[FirestoreKeys.displayName] ?? '',
      photoUrl: userData[FirestoreKeys.photoUrl] ?? '',
    );
  }

// For saving to Firestore
  Map<String, dynamic> toMap(UserModel user) {
    return {
      FirestoreKeys.uid: user.uid,
      FirestoreKeys.displayName: user.displayName,
      FirestoreKeys.email: user.email,
      FirestoreKeys.photoUrl: user.photoUrl,
    };
  }

 /// For updating a field
  UserModel copyWith({
    final String? uid,
    final String? email,
    final String? displayName,
    final String? photoUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
