import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient/utils/utils.dart';

class AppRoutes {
  static pushCupertinoNavigation(
    route,
  ) {
    Navigator.push(navigatorKey.currentContext!,
        CupertinoPageRoute(builder: (context) => route));
  }

  static pushMaterialNavigation(
    route,
  ) {
    Navigator.push(navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => route));
  }

  static pushReplacementNavigation(
    route,
  ) {
    Navigator.pushReplacement(navigatorKey.currentContext!,
        CupertinoPageRoute(builder: (context) => route));
  }
}