import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appBar.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/customtextfield.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/language_constants.dart';
import 'package:patient/providers/auth_provider/login_provider.dart';
import 'package:patient/screens/auth/forgot_password_screen.dart';
import 'package:patient/screens/auth/signup_screen.dart';
import 'package:patient/utils/app_validation.dart';
import 'package:patient/utils/location_service.dart';
import 'package:patient/utils/session_manager.dart';
import 'package:patient/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  final route;
  const LoginScreen({super.key, this.route});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    callInitFunction();
    getLocationPermission();
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<LoginProvider>(context, listen: false);
    myProvider.clearValues();
    if (SessionManager.keepMySignedIn) {
      myProvider.emailController.text = SessionManager.userEmail;
      myProvider.passwordController.text = SessionManager.userPassword;
      myProvider.isKeepSigned = SessionManager.keepMySignedIn;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.whiteColor,
        appBar: appBar(getTranslated('logIn', context)!.tr, false),
        body: Consumer<LoginProvider>(builder: (context, myProvider, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 71, left: 20, right: 20),
            child: Form(
              key: myProvider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText(
                      title: getTranslated('email', context)!.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    isReadOnly: myProvider.isLoading,

                    /// if api is calling
                    controller: myProvider.emailController,
                    hintText: getTranslated('enterYourEmail', context)!.tr,
                    textInputType: TextInputType.text,
                    errorMsg: myProvider.emailValidationMsg,
                    onChanged: (val) {
                      myProvider.emailValidationMsg =
                          AppValidation.emailValidator(val);
                      setState(() {});
                    },
                  ),
                  ScreenSize.height(25),
                  getText(
                      title: getTranslated('password', context)!.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.passwordController,
                    isReadOnly: myProvider.isLoading,

                    /// if api is calling
                    hintText: getTranslated('enterYourPasword', context)!.tr,
                    textInputType: TextInputType.text,
                    isObscureText: myProvider.isVisiblePassword,
                    errorMsg: myProvider.passwordValidationMsg,
                    onChanged: (val) {
                      myProvider.passwordValidationMsg =
                          AppValidation.passwordValidator(val);
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
                  ScreenSize.height(31),
                  Row(
                    children: [
                      customRadioButton(myProvider),
                      ScreenSize.width(9.5),
                      getText(
                          title: getTranslated('keepMeSignIn', context)!.tr,
                          size: 12,
                          fontFamily: FontFamily.poppinsSemiBold,
                          color: AppColor.textBlackColor.withOpacity(.7),
                          fontWeight: FontWeight.w500),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          AppRoutes.pushCupertinoNavigation(
                              const ForgotPasswordScreen());
                        },
                        child: getText(
                            title:
                                "${getTranslated('forgotPassword', context)!.tr}?",
                            size: 14,
                            fontFamily: FontFamily.poppinsBold,
                            color: AppColor.appTheme,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  ScreenSize.height(49),
                  AppButton(
                      title: getTranslated('logIn', context)!.tr,
                      height: 54,
                      width: double.infinity,
                      buttonColor: AppColor.appTheme,
                      isLoading: myProvider.isLoading,
                      onTap: () {
                        getLocationPermission();
                        myProvider.isLoading
                            ? null
                            : myProvider.checkValidation();
                        // AppRoutes.pushCupertinoNavigation(
                        //     const DashboardScreen());
                      }),
                  ScreenSize.height(30),
                  Align(
                    alignment: Alignment.center,
                    child: Text.rich(TextSpan(
                        text: getTranslated('dontHaveAccount', context)!.tr,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: AppColor.textBlackColor.withOpacity(.6),
                            fontWeight: FontWeight.w300),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  widget.route == null ||
                                          widget.route == 'fromLoginType'
                                      ? AppRoutes.pushCupertinoNavigation(
                                          const SignupScreen())
                                      : Navigator.pop(context);
                                },
                              text: " ${getTranslated('signup', context)!.tr}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: FontFamily.poppinsBold,
                                  color: AppColor.appTheme,
                                  fontWeight: FontWeight.w600))
                        ])),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  customRadioButton(LoginProvider provider) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (provider.isKeepSigned) {
          provider.updateKeepSigned(false);
        } else {
          provider.updateKeepSigned(true);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color:
                provider.isKeepSigned ? AppColor.appTheme : AppColor.whiteColor,
            border: Border.all(color: AppColor.appTheme),
            borderRadius: BorderRadius.circular(10)),
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
