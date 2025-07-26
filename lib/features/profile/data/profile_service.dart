import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_talk/core/constants/firestore_keys.dart';
import 'package:flutter_talk/core/enums/profile_field_type.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
