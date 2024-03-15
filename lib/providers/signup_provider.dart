import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();

  bool isChecked = false;
  bool isVisiblePassword = false;
  bool isVisibleReEnterPassword = false;

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
}
