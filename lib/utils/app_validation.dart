import 'package:get/get.dart';
import 'package:patient/languages/language_constants.dart';
import 'package:patient/utils/utils.dart';

class AppValidation {
  static String? firstNameValidator(val) {
    if (val.isEmpty) {
      return getTranslated('enterFirstName', navigatorKey.currentContext!)!.tr;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? lastNameValidator(val) {
    if (val.isEmpty) {
      return getTranslated('enterLastName', navigatorKey.currentContext!)!.tr;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? phoneNumberValidator(val) {
    if (val.isEmpty) {
      return getTranslated(
              'enterYourPhonenUmber', navigatorKey.currentContext!)!
          .tr;
    } else if (val.length < 10) {
      return getTranslated(
              'enteValidPhoneNumber', navigatorKey.currentContext!)!
          .tr;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? emailValidator(val) {
    RegExp regExp = RegExp(Utils.emailPattern.trim());
    if (val.isEmpty) {
      return getTranslated('enterYourEmail', navigatorKey.currentContext!)!.tr;
    } else if (!regExp.hasMatch(val)) {
      return getTranslated('enterValidEmail', navigatorKey.currentContext!)!.tr;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? passwordValidator(val) {
    RegExp regExp = RegExp(Utils.passwordPattern.trim());
    if (val.isEmpty) {
      return getTranslated('enterYourPasword', navigatorKey.currentContext!)!
          .tr;
    } else if (!regExp.hasMatch(val)) {
      return getTranslated('passwordValidation', navigatorKey.currentContext!)!
          .tr;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? reEnterpasswordValidator(currentValue, previousValue) {
    RegExp regExp = RegExp(Utils.passwordPattern.trim());
    if (currentValue.isEmpty) {
      return getTranslated('enterYourPasword', navigatorKey.currentContext!)!
          .tr;
    } else if (!regExp.hasMatch(currentValue)) {
      return getTranslated('passwordValidation', navigatorKey.currentContext!)!
          .tr;
    } else if (previousValue.isNotEmpty) {
      if (currentValue != previousValue) {
        return getTranslated(
                'passwordShouldBeSame', navigatorKey.currentContext!)!
            .tr;
      }
      return null;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? nameValidator(val) {
    if (val.isEmpty) {
      return getTranslated('enterYourName', navigatorKey.currentContext!)!.tr;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? addressValidator(val) {
    if (val.isEmpty) {
      return getTranslated('enterYourAddress', navigatorKey.currentContext!)!
          .tr;
    } else {
      return null;
    }
  }

  static String? postalCodeValidator(val) {
    if (val.isEmpty) {
      return getTranslated('enterYourPostalCode', navigatorKey.currentContext!)!
          .tr;
    } else if (val.length < 5) {
      return getTranslated(
              'enterValidPostalCode', navigatorKey.currentContext!)!
          .tr;
    } else {
      return null;
    }
  }

  static String? streetValidator(val) {
    if (val.isEmpty) {
      return getTranslated('enterYourStreet', navigatorKey.currentContext!)!.tr;
    } else {
      return null;
    }
  }

  static String? cityValidator(val) {
    if (val.isEmpty) {
      return getTranslated('enterYourCity', navigatorKey.currentContext!)!.tr;
    } else {
      return null;
    }
  }

  static String? insuranceNoValidator(val) {
    if (val.isEmpty) {
      return getTranslated(
              'enterYourInsuranceNo', navigatorKey.currentContext!)!
          .tr;
    } else {
      return null;
    }
  }

  static String? birthDateValidator(val) {
    if (val.isEmpty) {
      return getTranslated('selectYourBirthDate', navigatorKey.currentContext!)!
          .tr;
    } else {
      return null;
    }
  }
}
