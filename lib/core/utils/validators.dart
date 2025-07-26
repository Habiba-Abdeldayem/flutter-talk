import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/core/constants/app_validation_messages.dart';

String? validateEmail(String? value) {
  if (value == null ||
      !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
    return AppStrings.pleaseEnterYourValidEmail;
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return 'Include at least one special character';
  }
  return null;
}

// Closure:	A function that returns another function, and "remembers" values from where it was created
// originalPassword → comes from the controller of the first field (you passed it).
// confirmPassword → comes from the current TextFormField value (Flutter gives it to the validator).
String? Function(String? value)  validateConfirmPassword(String? originalPassword) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  };
}


String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return AppStrings.pleaseEnterYourName;
  }
  if (value.trim().length < 2) {
    return AppValidationMessages.nameTooShort;
  }
  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.trim().isEmpty) {
    return AppValidationMessages.phoneRequired;
  }
  final trimmed = value.trim();
  if (!RegExp(r'^\d{10,15}$').hasMatch(trimmed)) {
    return AppValidationMessages.enterValidPhone;
  }
  return null;
}

String? validateBio(String? value) {
  if (value != null && value.length > 200) {
    return AppValidationMessages.bioTooLong;
  }
  return null;
}
