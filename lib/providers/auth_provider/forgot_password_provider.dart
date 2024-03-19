import 'package:flutter/material.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/screens/auth/email_verification_screen.dart';
import 'package:patient/utils/app_validation.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  bool isLoading = false;

  /// to show the textfield error
  String? emailValidationMsg = '';

  clearValues() {
    emailController.clear();
  }

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  checkValidation() {
    if (emailValidationMsg == null) {
      callApiFunction();
    } else {
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
    }
  }

  callApiFunction() {
    updateLoading(true);
    var data = {
      "username": emailController.text,
    };
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(ApiUrl.forgotPasswordUrl, body,
            checkApiMethod(httpMethod.post), true)
        .then((value) {
      updateLoading(false);
      if (value != null) {
        AppRoutes.pushCupertinoNavigation(EmailVerificationScreen(
          email: emailController.text,
        ));
      }
    });
  }
}
