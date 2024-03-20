import 'package:flutter/material.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/utils/app_validation.dart';
import 'package:patient/utils/utils.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final enterNewPassword = TextEditingController();
  final reEnterNewPassword = TextEditingController();
  bool isVisibleNewPassword = false;
  bool isVisibleReEnterPassword = false;
  bool isLoading = false;

  String? passwordValidationMsg = '';
  String? reEnterPasswordValidationMsg = '';

  clearValues() {
    enterNewPassword.clear();
    reEnterNewPassword.clear();
    isVisibleNewPassword = false;
    isVisibleReEnterPassword = false;
  }

  updateIsVisibleNewPassword(value) {
    isVisibleNewPassword = value;
    notifyListeners();
  }

  updateIsVisibleReEnterPassword(value) {
    isVisibleReEnterPassword = value;
    notifyListeners();
  }

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  checkValidation(String email, String code) {
    if (passwordValidationMsg == null && reEnterPasswordValidationMsg == null) {
      callApiFunction(email, code);
    } else {
      passwordValidationMsg = AppValidation.reEnterpasswordValidator(
          enterNewPassword.text, reEnterNewPassword.text);
      reEnterPasswordValidationMsg = AppValidation.reEnterpasswordValidator(
          reEnterNewPassword.text, enterNewPassword.text);
    }
    notifyListeners();
  }

  callApiFunction(String email, String code) {
    Utils.hideTextField();
    updateLoading(true);
    var data = {
      "username": email,
      "verification_code": code,
      "new_password": reEnterNewPassword.text,
    };
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(ApiUrl.setNewPasswordUrl, body,
            checkApiMethod(httpMethod.post), true)
        .then((value) {
      updateLoading(false);
      if (value != null) {
        // AppRoutes.pushCupertinoNavigation(
        //     const DashboardScreen());
        // AppRoutes.pushReplacementNavigation(ChangePasswordScreen(
        //   email: email,
        // ));
        // AppRoutes.pushCupertinoNavigation(EmailVerificationScreen(
        //   email: emailController.text,
        // ));
      }
    });
  }
}
