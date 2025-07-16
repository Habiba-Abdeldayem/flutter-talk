import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_talk/features/auth/data/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  // Use injected FirebaseAuth for testability, or fallback to singleton instance
  AuthRepository({FirebaseAuth? firebaseAuth})
    : _auth = firebaseAuth ?? FirebaseAuth.instance;

  UserModel? getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      UserCredential firebaseUser = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(firebaseUser.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseCodeToMessage(e.code));
    }
  }

  Future<UserModel> signUp(String email, String password) async {
    try {
      UserCredential firebaseUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(firebaseUser.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Translate Firebase error codes
  String _mapFirebaseCodeToMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'invalid-credential':
        return 'Invalid email or password';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
