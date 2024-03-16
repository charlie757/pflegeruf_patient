import 'package:flutter/material.dart';

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
}
