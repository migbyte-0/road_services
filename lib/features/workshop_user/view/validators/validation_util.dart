import '../../../../core/constants/constants_exports.dart';

class ValidationUtil {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppTexts.emailEmpty; // Error message for empty email
    }
    if (!value.contains('@')) {
      return AppTexts.invalidEmail; // Error message for invalid email
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppTexts.passwordEmpty; // Error message for empty password
    }
    if (value.length < 6) {
      return AppTexts.passwordTooShort; // Error message for short password
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppTexts
          .confirmPasswordEmpty; // Error message for empty password confirmation
    }
    if (value != password) {
      return AppTexts
          .passwordsNotMatching; // Error message for mismatched passwords
    }
    return null;
  }

  // Validates phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppTexts.phoneNumberEmpty; // Error message for empty phone number
    }
    if (!RegExp(r'^5\d{8}$').hasMatch(value)) {
      return AppTexts
          .invalidPhoneNumber; // Error message for invalid phone number
    }
    return null;
  }

  // Validates username
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return AppTexts.userNameEmpty; // Error message for empty username
    }
    if (value.length < 4) {
      return AppTexts.userNameTooShort; // Error message for short username
    }
    if (!RegExp(r'^[a-zA-Z\u0621-\u064A\s]+$').hasMatch(value)) {
      return AppTexts.invalidUsername; // Error message for invalid username
    }
    return null;
  }

  // Validates workshop name
  static String? validateWorkshopName(String? value) {
    if (value == null || value.isEmpty) {
      return AppTexts
          .workshopNameEmpty; // Error message for empty workshop name
    }
    // Add any specific validation rules for workshop name, if needed
    return null;
  }

  // Validates location
  static String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return AppTexts.locationEmpty; // Error message for empty location
    }
    // Add any specific validation rules for location, if needed
    return null;
  }
}
