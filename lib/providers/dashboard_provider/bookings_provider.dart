import 'package:flutter/material.dart';

class BookingsProvier extends ChangeNotifier {
  int isSelectedTabBar = 0;
  updateSelectedTabBar(value) {
    isSelectedTabBar = value;
    notifyListeners();
  }
}
