import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/screens/auth/change_password_screen.dart';
import 'package:patient/utils/showcircleprogessdialog.dart';
import 'package:patient/utils/utils.dart';

class EmailVerificationProvider extends ChangeNotifier {
  final otp1Controller = TextEditingController();
  final otp2Controller = TextEditingController();
  final otp3Controller = TextEditingController();
  final otp4Controller = TextEditingController();
  FocusNode controller1Focus = FocusNode();
  FocusNode controller2Focus = FocusNode();
  FocusNode controller3Focus = FocusNode();
  FocusNode controller4Focus = FocusNode();
  bool showUnderlineOtp1 = false;
  bool showUnderlineOtp2 = false;
  bool showUnderlineOtp3 = false;
  bool showUnderlineOtp4 = false;

  int resendCounter = 0;

// resend otp
  bool resend = false;
  int counter = 60;
  late Timer _timer;

  bool isLoading = false;
  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  void startTimer() {
    resendCounter += 1;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter > 1) {
        counter--;
        resend = true;
      } else {
        _timer.cancel();
        resend = false;
        counter = 60;
      }
      notifyListeners();
    });
  }

  clearValues() {
    resend = false;
    counter = 60;
    otp1Controller.clear();
    otp2Controller.clear();
    otp3Controller.clear();
    otp4Controller.clear();
    showUnderlineOtp1 = false;
    showUnderlineOtp2 = false;
    showUnderlineOtp3 = false;
    showUnderlineOtp4 = false;
  }

  checkValidation() {}

  resendApiFunction(String email) {
    Utils.hideTextField();
    showCircleProgressDialog(navigatorKey.currentContext!);
    var data = {
      "username": email,
    };
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(ApiUrl.forgotPasswordUrl, body,
            checkApiMethod(httpMethod.post), true)
        .then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        startTimer();
      }
    });
  }

  callApiFunction(String email) {
    Utils.hideTextField();
    updateLoading(true);
    var data = {
      "username": email,
      "verification_code": otp1Controller.text +
          otp2Controller.text +
          otp3Controller.text +
          otp4Controller.text,
      // "device": Platform.isIOS ? 'ios' : 'android'
    };
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(ApiUrl.forgotVerificationUrl, body,
            checkApiMethod(httpMethod.post), true)
        .then((value) {
      updateLoading(false);
      if (value != null) {
        AppRoutes.pushReplacementNavigation(ChangePasswordScreen(
          email: email,
          verificationCode: otp1Controller.text +
              otp2Controller.text +
              otp3Controller.text +
              otp4Controller.text,
        ));
        // AppRoutes.pushCupertinoNavigation(EmailVerificationScreen(
        //   email: emailController.text,
        // ));
      }
    });
  }
}
