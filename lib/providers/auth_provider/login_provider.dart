import 'dart:io';
import 'package:flutter/material.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/model/login_model.dart';
import 'package:patient/screens/auth/email_verification_screen.dart';
import 'package:patient/screens/dashboard/dashboard_screen.dart';
import 'package:patient/utils/app_validation.dart';
import 'package:patient/utils/location_service.dart';
import 'package:patient/utils/session_manager.dart';
import 'package:patient/utils/utils.dart';

class LoginProvider extends ChangeNotifier {
  LoginModel? loginModel;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isKeepSigned = false;
  bool isVisiblePassword = true;

  /// to show the textfield error
  String? emailValidationMsg = '';
  String? passwordValidationMsg = '';

  clearValues() {
    emailController.clear();
    passwordController.clear();
    isKeepSigned = false;
    isVisiblePassword = true;
  }

  updateIsVisiblePassword(value) {
    isVisiblePassword = value;
    notifyListeners();
  }

  updateKeepSigned(value) {
    /// again update value when click on login button (if user changes the value after select the "keep me signed in")
    isKeepSigned = value;
    SessionManager.setKeepMySignedIn = value;
    notifyListeners();
  }

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  checkValidation() {
    getLocationPermission();
    if (AppValidation.emailValidator(emailController.text) == null &&
        AppValidation.passwordValidator(passwordController.text) == null) {
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
      passwordValidationMsg =
          AppValidation.passwordValidator(passwordController.text);
      callApiFunction();
    } else {
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
      passwordValidationMsg =
          AppValidation.passwordValidator(passwordController.text);
    }
    notifyListeners();
  }

  callApiFunction() {
    /// set the values
    Utils.hideTextField();
    SessionManager.setUserEmail = emailController.text;
    SessionManager.setuserPassword = passwordController.text;
    updateLoading(true);
    var data = {
      "username": emailController.text,
      "password": passwordController.text,
      "device": Platform.isIOS ? 'ios' : 'android',
      'latitude': SessionManager.lat,
      'longitude': SessionManager.lng,
      'fcm_key': SessionManager.fcmToken
    };
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(
      url: ApiUrl.loginUrl,
      body: body,
      method: checkApiMethod(httpMethod.post),
    ).then((value) {
      updateLoading(false);
      if (value != null) {
        loginModel = LoginModel.fromJson(value);
        if (loginModel!.data!.status == true) {
          /// check account type
          if (loginModel!.data!.userDetails!.userAccountType == 1) {
            if (SessionManager.keepMySignedIn) {
              updateIsVisiblePassword(true);

              /// update the value
            }
            SessionManager.setToken = loginModel!.data!.token;
            AppRoutes.pushReplacementNavigation(const DashboardScreen());
          } else {
            Utils.errorSnackBar('User not found', navigatorKey.currentContext);
          }
        } else {
          AppRoutes.pushCupertinoNavigation(EmailVerificationScreen(
            email: emailController.text,
          ));
          Utils.errorSnackBar(loginModel!.message, navigatorKey.currentContext);
        }
      }
    });
  }
}
