import 'package:flutter/cupertino.dart';
import 'package:patient/utils/utils.dart';

class AppRoutes {
  static pushNavigation(
    route,
  ) {
    Navigator.push(navigatorKey.currentContext!,
        CupertinoPageRoute(builder: (context) => route));
  }

  static pushReplacementNavigation(
    route,
  ) {
    Navigator.pushReplacement(navigatorKey.currentContext!,
        CupertinoPageRoute(builder: (context) => route));
  }
}
