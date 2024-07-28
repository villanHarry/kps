import 'package:kps/utils/app_regular_expressions.dart';

extension AppValidator on String {
  //-------------- Password Validator -------------------
  get validatePass {
    if (!RegularExpressions.PASSWORD_VALID_REGIX.hasMatch(this) && isNotEmpty) {
      return "Password must be of 8 characters long and contain atleast 1 uppercase, 1 lowercase, 1 digit and 1 special character";
    } else if (isEmpty) {
      return "Password field can't be empty.";
    }
    return null;
  }

  //-------------- Email Validator -------------------
  get validateEmail {
    if (!RegularExpressions.EMAIL_VALID_REGIX.hasMatch(this) && isNotEmpty) {
      return "Please enter valid email address";
    } else if (isEmpty) {
      return "Email field cannot be empty";
    }
    return null;
  }

  //---------------- Empty Validator -----------------
  String? validateEmpty(String message) {
    if (isEmpty) {
      // return '$message field_cant_be_empty'.tr();
      String returningString = 'field cannot be empty';
      return '$message $returningString';
    } else {
      return null;
    }
  }

//---------------- OTP Validator ---------------
  get validateOtp {
    if ((this ?? "").length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }
}

extension TypeCase on String {
  String titleCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
