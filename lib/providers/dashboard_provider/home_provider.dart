import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  List serviceList = [
    {'img': 'assets/images/bandaged-finger 1.png', 'title': 'Wound care'},
    {'img': 'assets/images/leg 1.png', 'title': 'Compression stockings'},
    {'img': 'assets/images/catheter 1.png', 'title': 'Catheter supply'},
    {'img': 'assets/images/abdominal-pain 1.png', 'title': 'Stoma care'},
    {'img': 'assets/images/medicine 1.png', 'title': 'Weekly Box'},
    {'img': 'assets/images/syringe 1.png', 'title': 'Injections'},
  ];
  List imgList = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider1.png',
  ];
  int currentSliderIndex = 0;
  updateSliderIndex(value) {
    currentSliderIndex = value;
    notifyListeners();
  }
}
