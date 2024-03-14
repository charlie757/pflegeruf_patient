import 'package:flutter/material.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';

class ChooseLoginTypeScreen extends StatefulWidget {
  const ChooseLoginTypeScreen({super.key});

  @override
  State<ChooseLoginTypeScreen> createState() => _ChooseLoginTypeScreenState();
}

class _ChooseLoginTypeScreenState extends State<ChooseLoginTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  title: StringKey.letsGetIn,
                  size: 22,
                  fontFamily: '',
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w600),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 37),
                child: AppButton(
                    title: StringKey.createAccount,
                    height: 54,
                    width: double.infinity,
                    buttonColor: AppColor.whiteColor,
                    textColor: AppColor.blackColor,
                    onTap: () {}),
              ),
              ScreenSize.height(20),
              Padding(
                padding: const EdgeInsets.only(left: 37, right: 37),
                child: AppButton(
                    title: StringKey.logIn,
                    height: 54,
                    width: double.infinity,
                    buttonColor: AppColor.whiteColor,
                    textColor: AppColor.blackColor,
                    onTap: () {}),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
