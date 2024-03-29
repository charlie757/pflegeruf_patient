import 'package:patient/utils/utils.dart';

class AppValidation {
  static String? firstNameValidator(val) {
    if (val.isEmpty) {
      return 'Enter your first name';
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? lastNameValidator(val) {
    if (val.isEmpty) {
      return 'Enter your last name';
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? phoneNumberValidator(val) {
    if (val.isEmpty) {
      return 'Enter your phone number';
    } else if (val.length < 10) {
      return 'Enter valid phone number';
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

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

  static String? reEnterpasswordValidator(currentValue, previousValue) {
    RegExp regExp = RegExp(Utils.passwordPattern.trim());
    if (currentValue.isEmpty) {
      return 'Enter your password';
    } else if (!regExp.hasMatch(currentValue)) {
      return 'Password should contain at least one upper case, one lower case, one digit, one Special character';
    } else if (previousValue.isNotEmpty) {
      if (currentValue != previousValue) {
        return 'Password should be same';
      }
      return null;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? nameValidator(val) {
    if (val.isEmpty) {
      return 'Enter your name';
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? addressValidator(val) {
    if (val.isEmpty) {
      return 'Enter your address';
    } else {
      return null;
    }
  }

  static String? postalCodeValidator(val) {
    if (val.isEmpty) {
      return 'Enter your postal code';
    } else if (val.length < 6) {
      return 'Enter valid postal code';
    } else {
      return null;
    }
  }

  static String? streetValidator(val) {
    if (val.isEmpty) {
      return 'Enter your street';
    } else {
      return null;
    }
  }

  static String? cityValidator(val) {
    if (val.isEmpty) {
      return 'Enter your city';
    } else {
      return null;
    }
  }

  static String? insuranceNoValidator(val) {
    if (val.isEmpty) {
      return 'Enter your insurance no';
    } else {
      return null;
    }
  }

  static String? birthDateValidator(val) {
    if (val.isEmpty) {
      return 'Select your birth date';
    } else {
      return null;
    }
  }
}
