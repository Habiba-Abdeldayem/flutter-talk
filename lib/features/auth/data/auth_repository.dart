import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_talk/features/user/data/user_repository.dart';
import 'package:flutter_talk/features/user/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final UserRepository _userRepo;
  // Use injected FirebaseAuth for testability, or fallback to singleton instance
  // Use initializer list for final fields – they must be assigned before constructor body runs
  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    UserRepository? userRepo,
  }) : _auth = firebaseAuth ?? FirebaseAuth.instance,
       _userRepo = userRepo ?? UserRepository();

  Stream<User?> authStateChanges() => _auth.authStateChanges();

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

      final uid = firebaseUser.user!.uid;

      // Get user data from firestore
      final user = await _userRepo.fetchUserModelByUID(uid);

      if (user != null) {
        return user;
      } else {
        throw Exception("User data not found in Firestore");
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseCodeToMessage(e.code));
    }
  }

  Future<UserModel> signUp(String email, String password, String name) async {
    try {
      UserCredential firebaseUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = firebaseUser.user!.uid;
      UserModel tempUser = UserModel(
        uid: uid,
        email: email,
        displayName: name,
        bio: null,
        phone: null,
        photoUrl: null,
      );

      await _userRepo.saveUserToFirestore(tempUser);
      return tempUser;
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
