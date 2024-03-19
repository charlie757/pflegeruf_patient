import 'dart:io';

import 'package:flutter/material.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';

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
  bool isLoading = false;
  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  clearValues() {
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
  callApiFunction(String email) {
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
        // AppRoutes.pushCupertinoNavigation(EmailVerificationScreen(
        //   email: emailController.text,
        // ));
      }
    });
  }
}
