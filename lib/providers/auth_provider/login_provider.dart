import 'dart:io';
import 'package:flutter/material.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/model/login_model.dart';
import 'package:patient/screens/dashboard/dashboard_screen.dart';
import 'package:patient/utils/app_validation.dart';
import 'package:patient/utils/session_manager.dart';
import 'package:patient/utils/utils.dart';

class LoginProvider extends ChangeNotifier {
  LoginModel? loginModel;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isKeepSigned = false;
  bool isVisiblePassword = false;

  /// to show the textfield error
  String? emailValidationMsg = '';
  String? passwordValidationMsg = '';

  clearValues() {
    emailController.clear();
    passwordController.clear();
    isKeepSigned = false;
    isVisiblePassword = false;
  }

  updateIsVisiblePassword(value) {
    isVisiblePassword = value;
    notifyListeners();
  }

  updateKeepSigned(value) {
    isKeepSigned = value;
    SessionManager.setKeepMySignedIn = value;
    SessionManager.setUserEmail = emailController.text;
    SessionManager.setuserPassword = passwordController.text;
    notifyListeners();
  }

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  checkValidation() {
    if (emailValidationMsg == null && passwordValidationMsg == null) {
      callApiFunction();
    } else {
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
      passwordValidationMsg =
          AppValidation.passwordValidator(passwordController.text);
    }
    notifyListeners();
  }

  callApiFunction() {
    updateLoading(true);
    var data = {
      "username": emailController.text,
      "password": passwordController.text,
      "device": Platform.isIOS ? 'ios' : 'android'
    };
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(
            ApiUrl.loginUrl, body, checkApiMethod(httpMethod.post), true)
        .then((value) {
      updateLoading(false);
      if (value != null) {
        loginModel = LoginModel.fromJson(value);
        if (loginModel!.data!.accountStatus == 'Active') {
          SessionManager.setToken = loginModel!.data!.token;
          AppRoutes.pushReplacementNavigation(const DashboardScreen());
        } else {
          Utils.errorSnackBar(loginModel!.message, navigatorKey.currentContext);
        }
      }
    });
  }
}
