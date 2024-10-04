import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/languages/language_constants.dart';
import 'package:patient/screens/auth/email_verification_screen.dart';
import 'package:patient/utils/app_validation.dart';
import 'package:patient/utils/session_manager.dart';
import 'package:patient/utils/utils.dart';

class SignupProvider extends ChangeNotifier {
  bool isLoading = false;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();

  bool isChecked = false;
  bool isVisiblePassword = false;
  bool isVisibleReEnterPassword = false;

  /// to show the textfield error
  String? firstNamevalidationMsg = '';
  String? lastNamevalidationMsg = '';
  String? emailValidationMsg = '';
  String? phoneValidationMsg = '';
  String? passwordValidationMsg = '';
  String? reEnterPasswordValidationMsg = '';

  clearValues() {
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    reEnterPasswordController.clear();
    isChecked = false;
    isVisiblePassword = false;
    isVisibleReEnterPassword = false;
  }

  updateIsVisiblePassword(value) {
    isVisiblePassword = value;
    notifyListeners();
  }

  updateIsVisibleReEnterPassword(value) {
    isVisibleReEnterPassword = value;
    notifyListeners();
  }

  updateIsChecked(value) {
    isChecked = value;
    notifyListeners();
  }

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  checkValidation(String route) {
    if (AppValidation.firstNameValidator(firstNameController.text) == null &&
        AppValidation.lastNameValidator(lastNameController.text) == null &&
        AppValidation.phoneNumberValidator(phoneController.text) == null &&
        AppValidation.emailValidator(emailController.text) == null &&
        AppValidation.reEnterpasswordValidator(
                passwordController.text, reEnterPasswordController.text) ==
            null &&
        AppValidation.reEnterpasswordValidator(
                reEnterPasswordController.text, passwordController.text) ==
            null) {
      firstNamevalidationMsg =
          AppValidation.firstNameValidator(firstNameController.text);
      lastNamevalidationMsg =
          AppValidation.lastNameValidator(lastNameController.text);
      phoneValidationMsg =
          AppValidation.phoneNumberValidator(phoneController.text);
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
      passwordValidationMsg = AppValidation.reEnterpasswordValidator(
          passwordController.text, reEnterPasswordController.text);
      reEnterPasswordValidationMsg = AppValidation.reEnterpasswordValidator(
          reEnterPasswordController.text, passwordController.text);
      if (!isChecked) {
        Utils.errorSnackBar(
            getTranslated("acceptTermsCondition", navigatorKey.currentContext!)!.tr, navigatorKey.currentContext);
      } else {
        callApiFunction(route);
      }
    } else {
      firstNamevalidationMsg =
          AppValidation.firstNameValidator(firstNameController.text);
      lastNamevalidationMsg =
          AppValidation.lastNameValidator(lastNameController.text);
      phoneValidationMsg =
          AppValidation.phoneNumberValidator(phoneController.text);
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
      passwordValidationMsg = AppValidation.reEnterpasswordValidator(
          passwordController.text, reEnterPasswordController.text);
      reEnterPasswordValidationMsg = AppValidation.reEnterpasswordValidator(
          reEnterPasswordController.text, passwordController.text);
    }
    notifyListeners();
  }

  callApiFunction(String route) {
    Utils.hideTextField();
    updateLoading(true);
    var data = {
      "p_user_name": firstNameController.text,
      "p_user_surname": lastNameController.text,
      "p_user_email": emailController.text,
      "p_user_password": reEnterPasswordController.text,
      "p_user_mobile": phoneController.text,
    };
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(
      url: ApiUrl.signUpUrl,
      body: body,
      method: checkApiMethod(httpMethod.post),
    ).then((value) {
      updateLoading(false);
      if (value != null) {
        SessionManager.setUserEmail = emailController.text;
        SessionManager.setuserPassword = passwordController.text;

        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        AppRoutes.pushReplacementNavigation(EmailVerificationScreen(
          email: emailController.text,
        ));
        clearValues();
      }
    });
  }
}
