import 'package:flutter/material.dart';
import 'package:patient/screens/dashboard/dashboard_screen.dart';
import 'package:patient/utils/app_validation.dart';
import '../../config/approutes.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
    notifyListeners();
  }

  checkValidation() {
    if (emailValidationMsg == null && passwordValidationMsg == null) {
      AppRoutes.pushCupertinoNavigation(const DashboardScreen());
    } else {
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
      passwordValidationMsg =
          AppValidation.passwordValidator(passwordController.text);
    }
    notifyListeners();
  }
}
