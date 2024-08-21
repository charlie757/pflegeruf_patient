import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appBar.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/customtextfield.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/providers/auth_provider/signup_provider.dart';
import 'package:patient/screens/auth/login_screen.dart';
import 'package:patient/utils/app_validation.dart';
import 'package:patient/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  final routes;
  const SignupScreen({super.key, this.routes});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<SignupProvider>(context, listen: false);
    myProvider.clearValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.whiteColor,
      appBar: appBar(StringKey.signup.tr, false),
      body: Consumer<SignupProvider>(builder: (context, myProvider, child) {
        return SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 71, left: 20, right: 20, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText(
                      title: StringKey.firstName.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.firstNameController,
                    hintText: StringKey.enterFirstName.tr,
                    isReadOnly: myProvider.isLoading,
                    textInputAction: TextInputAction.next,
                    errorMsg: myProvider.firstNamevalidationMsg,
                    onChanged: (val) {
                      myProvider.firstNamevalidationMsg =
                          AppValidation.firstNameValidator(val);
                      setState(() {});
                    },
                  ),
                  ScreenSize.height(25),
                  getText(
                      title: StringKey.lastName.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.lastNameController,
                    hintText: StringKey.enterLastName.tr,
                    isReadOnly: myProvider.isLoading,
                    errorMsg: myProvider.lastNamevalidationMsg,
                    textInputAction: TextInputAction.next,
                    onChanged: (val) {
                      myProvider.lastNamevalidationMsg =
                          AppValidation.lastNameValidator(val);
                      setState(() {});
                    },
                  ),
                  ScreenSize.height(25),
                  getText(
                      title: StringKey.email.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.emailController,
                    hintText: StringKey.enterYourEmail.tr,
                    isReadOnly: myProvider.isLoading,
                    errorMsg: myProvider.emailValidationMsg,
                    textInputAction: TextInputAction.next,
                    onChanged: (val) {
                      myProvider.emailValidationMsg =
                          AppValidation.emailValidator(val);
                      setState(() {});
                    },
                  ),
                  ScreenSize.height(25),
                  getText(
                      title: StringKey.phoneNumber.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.phoneController,
                    hintText: StringKey.enterYourPhonenUmber.tr,
                    isReadOnly: myProvider.isLoading,
                    textInputAction: TextInputAction.next,
                    textInputType: Platform.isAndroid? TextInputType.phone:const TextInputType.numberWithOptions(signed: true, decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12)
                    ],
                    errorMsg: myProvider.phoneValidationMsg,
                    onChanged: (val) {
                      myProvider.phoneValidationMsg =
                          AppValidation.phoneNumberValidator(val);
                      setState(() {});
                    },
                  ),
                  ScreenSize.height(25),
                  getText(
                      title: StringKey.password.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.passwordController,
                    hintText: StringKey.enterYourPasword.tr,
                    isReadOnly: myProvider.isLoading,
                    textInputAction: TextInputAction.next,
                    isObscureText: myProvider.isVisiblePassword,
                    errorMsg: myProvider.passwordValidationMsg,
                    onChanged: (val) {
                      myProvider.passwordValidationMsg =
                          AppValidation.reEnterpasswordValidator(
                              val, myProvider.reEnterPasswordController.text);
                      setState(() {});
                    },
                    icon: GestureDetector(
                      onTap: () {
                        if (myProvider.isVisiblePassword) {
                          myProvider.updateIsVisiblePassword(false);
                        } else {
                          myProvider.updateIsVisiblePassword(true);
                        }
                      },
                      child: Icon(
                        myProvider.isVisiblePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColor.textBlackColor.withOpacity(.3),
                      ),
                    ),
                  ),
                  ScreenSize.height(25),
                  getText(
                      title: StringKey.reEnterPassword.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.reEnterPasswordController,
                    hintText: StringKey.reEnterYourPassword.tr,
                    isReadOnly: myProvider.isLoading,
                    textInputAction: TextInputAction.done,
                    isObscureText: myProvider.isVisibleReEnterPassword,
                    errorMsg: myProvider.reEnterPasswordValidationMsg,
                    onChanged: (val) {
                      myProvider.reEnterPasswordValidationMsg =
                          AppValidation.reEnterpasswordValidator(
                              val, myProvider.passwordController.text);
                      setState(() {});
                    },
                    icon: GestureDetector(
                      onTap: () {
                        if (myProvider.isVisibleReEnterPassword) {
                          myProvider.updateIsVisibleReEnterPassword(false);
                        } else {
                          myProvider.updateIsVisibleReEnterPassword(true);
                        }
                      },
                      child: Icon(
                        myProvider.isVisibleReEnterPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColor.textBlackColor.withOpacity(.3),
                      ),
                    ),
                  ),
                  ScreenSize.height(20),
                  Row(
                    children: [
                      customCheckBox(myProvider),
                      ScreenSize.width(10),
                      Flexible(
                        child: getText(
                            title: StringKey.acceptTermsAndPrivacyPolicy.tr,
                            size: 9,
                            fontFamily: FontFamily.poppinsMedium,
                            color: AppColor.textBlackColor.withOpacity(.7),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  ScreenSize.height(60),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: AppButton(
                        title: StringKey.signup.tr,
                        height: 54,
                        width: double.infinity,
                        isLoading: myProvider.isLoading,
                        buttonColor: AppColor.appTheme,
                        onTap: () {
                          myProvider.isLoading
                              ? null
                              : myProvider.checkValidation(widget.routes ?? '');
                          // myProvider.callApiFunction();
                          // AppRoutes.pushCupertinoNavigation(
                          //     const DashboardScreen());
                        }),
                  ),
                  ScreenSize.height(30),
                  Align(
                    alignment: Alignment.center,
                    child: Text.rich(TextSpan(
                        text: StringKey.alredyHaveAccount.tr,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: AppColor.textBlackColor.withOpacity(.6),
                            fontWeight: FontWeight.w300),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  widget.routes == 'fromSignUpType'
                                      ? AppRoutes.pushCupertinoNavigation(
                                          const LoginScreen())
                                      : Navigator.pop(context);
                                },
                              text: " ${StringKey.logIn.tr}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: FontFamily.poppinsSemiBold,
                                  color: AppColor.appTheme,
                                  fontWeight: FontWeight.w600))
                        ])),
                  ),
                ],
              )),
        );
      }),
    );
  }

  customCheckBox(SignupProvider provider) {
    return GestureDetector(
      onTap: () {
        if (provider.isChecked) {
          provider.updateIsChecked(false);
        } else {
          provider.updateIsChecked(true);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: provider.isChecked ? AppColor.appTheme : AppColor.whiteColor,
            border: Border.all(
                color: provider.isChecked
                    ? AppColor.appTheme
                    : AppColor.textBlackColor.withOpacity(.3)),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 20,
                  color: AppColor.blackColor.withOpacity(.2))
            ]),
        alignment: Alignment.center,
        child: Icon(
          Icons.check,
          size: 15,
          color: AppColor.whiteColor,
        ),
      ),
    );
  }
}
