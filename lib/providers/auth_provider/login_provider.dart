import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isKeepSigned = false;
  bool isVisiblePassword = false;

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
    notifyListeners();
  }
}
