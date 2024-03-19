import 'package:flutter/material.dart';
import 'package:patient/helper/appBar.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/customtextfield.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/providers/auth_provider/forgot_password_provider.dart';
import 'package:patient/utils/app_validation.dart';
import 'package:patient/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

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
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.whiteColor,
        appBar: appBar(StringKey.forgotPassword.tr, false),
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
                    title: StringKey.enterEmailToCreateNewPassword.tr,
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
                  hintText: StringKey.enterEmailAddress.tr,
                  errorMsg: myProvider.emailValidationMsg,
                  isReadOnly: myProvider.isLoading,
                  onChanged: (val) {
                    myProvider.emailValidationMsg =
                        AppValidation.emailValidator(val);
                    setState(() {});
                  },
                ),
                ScreenSize.height(60),
                Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17),
                  child: AppButton(
                      title: StringKey.send.tr,
                      height: 54,
                      width: double.infinity,
                      buttonColor: AppColor.appTheme,
                      isLoading: myProvider.isLoading,
                      onTap: () {
                        myProvider.checkValidation();
                        // AppRoutes.pushCupertinoNavigation(
                        //     const EmailVerificationScreen());
                      }),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
