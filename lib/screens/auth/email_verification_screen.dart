import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appBar.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/providers/email_verification_provider.dart';
import 'package:patient/screens/auth/change_password_screen.dart';
import 'package:provider/provider.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {
    // callInitFunction();
    super.initState();
  }

  callInitFunction() {
    // final myProvider =
    //     Provider.of<EmailVerificationProvider>(context, listen: false);
    // myProvider.clearValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(StringKey.emailVerification),
      body: Consumer<EmailVerificationProvider>(
          builder: (context, myProvider, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 37, right: 37, top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: StringKey.enterOtpReceivedOnEmail,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: FontFamily.poppinsRegular,
                          color: AppColor.textBlackColor.withOpacity(.7),
                          fontWeight: FontWeight.w400,
                        )),
                    TextSpan(
                        text: ' williamson@gmail.com',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColor.appTheme,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              ScreenSize.height(50),
              AppButton(
                  title: StringKey.verify,
                  height: 54,
                  width: double.infinity,
                  buttonColor: AppColor.appTheme,
                  onTap: () {
                    AppRoutes.pushCupertinoNavigation(
                        const ChangePasswordScreen());
                  }),
              ScreenSize.height(40),
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: StringKey.resendCode,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: FontFamily.poppinsSemiBold,
                          color: AppColor.textBlackColor.withOpacity(.5),
                          fontWeight: FontWeight.w300,
                        )),
                    TextSpan(
                        text: ' 00:59',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: FontFamily.poppinsSemiBold,
                          color: AppColor.appTheme,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }
}
