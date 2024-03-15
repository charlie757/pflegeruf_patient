import 'package:flutter/material.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final enterNewPassword = TextEditingController();
  final reEnterNewPassword = TextEditingController();
  bool isVisibleNewPassword = false;
  bool isVisibleReEnterPassword = false;

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
}
