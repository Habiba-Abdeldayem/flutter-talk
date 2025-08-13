import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_talk/core/constants/firestore_keys.dart';
import 'package:flutter_talk/core/enums/profile_field_type.dart';
import 'package:flutter_talk/features/user/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserModel?> fetchUserModelByUID(String uid) async {
    final doc = await _firestore.collection(FirestoreKeys.users).doc(uid).get();

    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    } else {
      return null;
    }
  }

  Future<void> saveUserToFirestore(UserModel user) async {
    await _firestore
        .collection(FirestoreKeys.users)
        .doc(user.uid)
        .set(user.toMap(user));
  }

    Future<void> updateUserField({
    required String userId,
    required ProfileFieldType fieldType,
    required String newValue,
  }) async {
    final fieldName = _getFieldNameInFirestore(fieldType);
    await _firestore.collection(FirestoreKeys.users).doc(userId).update({
      fieldName: newValue,
    });
  }

  Stream<List<UserModel>> fetchAllUsersExcluding(String currentUserId) {
    return _firestore
        .collection(FirestoreKeys.users)
        .where(FirestoreKeys.uid, isNotEqualTo: currentUserId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => UserModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<UserModel?> getUserById(String id) async {
    final doc = await _firestore.collection(FirestoreKeys.users).doc(id).get();
    if (!doc.exists) return null;

    return UserModel.fromMap(doc.data()!);
  }

  Future<List<UserModel>> getUserByNameOrEmail(String query) async {
    final nameQuery = await _firestore
        .collection(FirestoreKeys.users)
        .where(FirestoreKeys.displayName, isGreaterThanOrEqualTo: query)
        .where(FirestoreKeys.displayName, isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    final emailQuery = await _firestore
        .collection(FirestoreKeys.users)
        .where(FirestoreKeys.email, isGreaterThan: query)
        .where(FirestoreKeys.displayName, isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    // Set spread operator, take all elements without repetition
    final allDocs = {...nameQuery.docs, ...emailQuery.docs};

    return allDocs.map((doc) => UserModel.fromMap(doc.data())).toList();
  }
  
String _getFieldNameInFirestore(ProfileFieldType fieldType) {
  switch (fieldType) {
    case ProfileFieldType.name:
      return FirestoreKeys.displayName;
    case ProfileFieldType.phone:
      return FirestoreKeys.phone;
    case ProfileFieldType.bio:
      return FirestoreKeys.bio;
  }
}

}
