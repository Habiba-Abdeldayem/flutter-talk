import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_talk/core/constants/firestore_keys.dart';
import 'package:flutter_talk/core/models/user_model.dart';

class UsersService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<UserModel>> getOtherUsers(String currentUserId) {
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

    // Set spread operator, takee all elements without repetition
    final allDocs = {...nameQuery.docs, ...emailQuery.docs};

    return allDocs.map((doc) => UserModel.fromMap(doc.data())).toList();
  }
}
