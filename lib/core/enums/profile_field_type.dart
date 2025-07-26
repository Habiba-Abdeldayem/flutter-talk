import 'package:flutter_talk/core/constants/app_hints.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/core/models/user_model.dart';
import 'package:flutter_talk/core/utils/validators.dart';

enum ProfileFieldType { name, phone, bio }

extension ProfileFieldTypeExtension on ProfileFieldType {
  String get label {
    switch (this) {
      case ProfileFieldType.name:
        return AppStrings.name;
      case ProfileFieldType.phone:
        return AppStrings.phone;
      case ProfileFieldType.bio:
        return AppStrings.bio;
    }
  }

  String get description {
    switch (this) {
      case ProfileFieldType.name:
        return AppHints.nameFieldDescription;
      case ProfileFieldType.phone:
        return AppHints.phoneFieldDescription;
      case ProfileFieldType.bio:
        return AppHints.bioFieldDescription;
    }
  }

  String? Function(String?) get validator {
    switch (this) {
      case ProfileFieldType.name:
        return validateName;
      case ProfileFieldType.phone:
        return validatePhone;
      case ProfileFieldType.bio:
        return validateBio;
    }
  }

  String? getInitialValue(UserModel user) {
    switch (this) {
      case ProfileFieldType.name:
        return user.displayName;
      case ProfileFieldType.phone:
        return user.phone;
      case ProfileFieldType.bio:
        return user.bio;
    }
  }
}
