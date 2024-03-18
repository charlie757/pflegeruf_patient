import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/screens/auth/login_screen.dart';
import 'package:patient/screens/auth/signup_screen.dart';
import 'package:get/get.dart';
import 'package:patient/utils/utils.dart';

class ChooseLoginTypeScreen extends StatefulWidget {
  const ChooseLoginTypeScreen({super.key});

  @override
  State<ChooseLoginTypeScreen> createState() => _ChooseLoginTypeScreenState();
}

class _ChooseLoginTypeScreenState extends State<ChooseLoginTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
        backgroundColor: AppColor.appTheme,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                  ),
                  child: Image.asset(AppImages.onlineDoctorImage),
                ),
                ScreenSize.height(32),
                getText(
                    title: StringKey.letsGetIn.tr,
                    size: 22,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 37),
                  child: AppButton(
                      title: StringKey.createAccount.tr,
                      height: 54,
                      width: double.infinity,
                      buttonColor: AppColor.whiteColor,
                      textColor: AppColor.blackColor,
                      onTap: () {
                        AppRoutes.pushCupertinoNavigation(const SignupScreen(
                          routes: 'fromLoginType',
                        ));
                      }),
                ),
                ScreenSize.height(20),
                Padding(
                  padding: const EdgeInsets.only(left: 37, right: 37),
                  child: AppButton(
                      title: StringKey.logIn.tr,
                      height: 54,
                      width: double.infinity,
                      buttonColor: AppColor.whiteColor,
                      textColor: AppColor.blackColor,
                      onTap: () {
                        AppRoutes.pushCupertinoNavigation(const LoginScreen(
                          route: 'fromLoginType',
                        ));
                      }),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
