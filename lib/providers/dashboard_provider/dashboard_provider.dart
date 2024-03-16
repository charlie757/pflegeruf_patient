import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int selectedIndex = 0;

  updateSelectedIndex(value) {
    selectedIndex = value;
    notifyListeners();
  }
}
