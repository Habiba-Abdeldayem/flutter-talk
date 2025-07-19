import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_talk/core/constants/firestore_keys.dart';
import 'package:flutter_talk/core/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  // Use injected FirebaseAuth for testability, or fallback to singleton instance
  // Use initializer list for final fields – they must be assigned before constructor body runs
  AuthRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
    : _auth = firebaseAuth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

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
      UserModel currentUser = UserModel.fromFirebaseUser(firebaseUser.user!);
      saveUserToFirestore(currentUser);
      return currentUser;
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
      // 1. Update the Firebase Auth displayName
      await firebaseUser.user!.updateDisplayName(name);

      // 2. Reload user to get the updated data
      await firebaseUser.user!.reload();
      User updatedUser = _auth.currentUser!;

      // 3. Use updatedUser to build the model
      UserModel currentUser = UserModel.fromFirebaseUser(updatedUser);

      // 4. Save to Firestore
      await saveUserToFirestore(currentUser);
      return currentUser;
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

  Future<void> saveUserToFirestore(UserModel user) async {
    _firestore.collection(FirestoreKeys.users).doc(user.uid).set(user.toMap(user));
  }
}
