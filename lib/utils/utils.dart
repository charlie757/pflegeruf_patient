import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/providers/dashboard_provider/home_provider.dart';
import 'package:patient/providers/dashboard_provider/profile_provider.dart';
import 'package:patient/screens/auth/login_screen.dart';
import 'package:patient/utils/session_manager.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
MediaQueryData mediaQuery = MediaQuery.of(navigatorKey.currentState!.context)
    .copyWith(textScaleFactor: 1.0);

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class Utils {
  static hideTextField() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static const emailPattern =
      r'^(([^<>()[\]\\.,;:@\"]+(\.[^<>()[\]\\.,;:@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const passwordPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  static successSnackBar(
    String title,
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.appTheme.withOpacity(.9)),
            borderRadius: BorderRadius.circular(3)),
        // margin: EdgeInsets.only(left: 20, right: 20,),
        backgroundColor: AppColor.appTheme.withOpacity(.9),
        content: Text(
          title,
          style: TextStyle(color: AppColor.whiteColor),
        )));
  }

  static internetSnackBar(
    context,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor.withOpacity(.8)),
            borderRadius: BorderRadius.circular(3)),
        //  margin: EdgeInsets.only(left: 20,right: 20,bottom: bottom),
        backgroundColor: AppColor.redColor.withOpacity(.8),
        content: Text(
          'No Internet',
          style: TextStyle(color: AppColor.whiteColor),
        )));
  }

  static errorSnackBar(
    String title,
    context,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor.withOpacity(.8)),
            borderRadius: BorderRadius.circular(3)),
        //  margin: EdgeInsets.only(left: 20,right: 20,bottom: bottom),
        backgroundColor: AppColor.redColor.withOpacity(.8),
        content: Text(
          title,
          style: TextStyle(color: AppColor.whiteColor),
        )));
  }

  static logOut() {
    final homeProvider =
        Provider.of<HomeProvider>(navigatorKey.currentContext!, listen: false);
    final profileProvider = Provider.of<ProfileProvider>(
        navigatorKey.currentContext!,
        listen: false);
    homeProvider.clearValues();
    profileProvider.clearValuesOnLogout();
    SessionManager.setToken = '';
    AppRoutes.pushReplacementNavigation(const LoginScreen());
  }

  static deleteAcount() {
    SessionManager.setToken = '';
    SessionManager.setKeepMySignedIn = false;
    SessionManager.setUserEmail = '';
    SessionManager.setuserPassword = '';
    AppRoutes.pushReplacementNavigation(const LoginScreen());
  }
}
