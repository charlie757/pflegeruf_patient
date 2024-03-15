import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final emailController = TextEditingController();

  clearValues() {
    emailController.clear();
  }
}
