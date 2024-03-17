import 'package:patient/utils/utils.dart';

class AppValidation {
  static String? emailValidator(val) {
    RegExp regExp = RegExp(Utils.emailPattern.trim());
    if (val.isEmpty) {
      return 'Enter your email';
    } else if (!regExp.hasMatch(val)) {
      return 'Enter valid email';
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? passwordValidator(val) {
    RegExp regExp = RegExp(Utils.passwordPattern.trim());
    if (val.isEmpty) {
      return 'Enter your password';
    } else if (!regExp.hasMatch(val)) {
      return 'Password should contain at least one upper case, one lower case, one digit, one Special character';
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }
}
