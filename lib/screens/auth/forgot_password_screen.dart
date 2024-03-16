import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appBar.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/customtextfield.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/providers/auth_provider/forgot_password_provider.dart';
import 'package:patient/screens/auth/email_verification_screen.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider =
        Provider.of<ForgotPasswordProvider>(context, listen: false);
    myProvider.clearValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.whiteColor,
      appBar: appBar(StringKey.forgotPassword, false),
      body: Consumer<ForgotPasswordProvider>(
          builder: (context, myProvider, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: getText(
                  title: StringKey.enterEmailToCreateNewPassword,
                  size: 12,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.textBlackColor.withOpacity(.7),
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
              ),
              ScreenSize.height(50),
              CustomTextfield(
                controller: myProvider.emailController,
                hintText: StringKey.enterEmailAddress,
              ),
              ScreenSize.height(60),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: AppButton(
                    title: StringKey.send,
                    height: 54,
                    width: double.infinity,
                    buttonColor: AppColor.appTheme,
                    onTap: () {
                      AppRoutes.pushCupertinoNavigation(
                          const EmailVerificationScreen());
                    }),
              )
            ],
          ),
        );
      }),
    );
  }
}
