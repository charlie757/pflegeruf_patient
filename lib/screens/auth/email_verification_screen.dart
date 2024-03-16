import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appBar.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/providers/auth_provider/email_verification_provider.dart';
import 'package:patient/screens/auth/change_password_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider =
        Provider.of<EmailVerificationProvider>(context, listen: false);
    myProvider.clearValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(StringKey.emailVerification, false),
      body: Consumer<EmailVerificationProvider>(
          builder: (context, myProvider, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 37, right: 37, top: 70),
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
              ScreenSize.height(70),
              customOtpTextfield(myProvider),
              ScreenSize.height(70),
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

  customOtpTextfield(EmailVerificationProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        roundedTextField(
            controller: provider.otp1Controller,
            focusNode: provider.controller1Focus,
            showUnderline: provider.showUnderlineOtp1,
            onTap: () {},
            onChanged: (val) {
              if (val.length >= 1) {
                provider.showUnderlineOtp1 = true;
                FocusScope.of(context).requestFocus(provider.controller2Focus);
              } else {
                provider.showUnderlineOtp1 = false;
              }
              setState(() {});
            }),
        roundedTextField(
            controller: provider.otp2Controller,
            focusNode: provider.controller2Focus,
            showUnderline: provider.showUnderlineOtp2,
            onTap: () {
              if (provider.otp1Controller.text.isEmpty) {
                FocusScope.of(context).requestFocus(provider.controller1Focus);
              }
            },
            onChanged: (val) {
              if (val.isNotEmpty) {
                provider.showUnderlineOtp2 = true;
                FocusScope.of(context).requestFocus(provider.controller3Focus);
              } else {
                provider.showUnderlineOtp2 = false;
                FocusScope.of(context).requestFocus(provider.controller1Focus);
              }

              setState(() {});
            }),
        roundedTextField(
            controller: provider.otp3Controller,
            focusNode: provider.controller3Focus,
            showUnderline: provider.showUnderlineOtp3,
            onTap: () {
              if (provider.otp1Controller.text.isEmpty) {
                FocusScope.of(context).requestFocus(provider.controller1Focus);
              } else if (provider.otp2Controller.text.isEmpty) {
                FocusScope.of(context).requestFocus(provider.controller2Focus);
              }
            },
            onChanged: (val) {
              if (val.isNotEmpty) {
                provider.showUnderlineOtp3 = true;
                FocusScope.of(context).requestFocus(provider.controller4Focus);
              } else {
                provider.showUnderlineOtp3 = false;
                FocusScope.of(context).requestFocus(provider.controller2Focus);
              }
              setState(() {});
            }),
        roundedTextField(
            controller: provider.otp4Controller,
            focusNode: provider.controller4Focus,
            showUnderline: provider.showUnderlineOtp4,
            onTap: () {
              if (provider.otp1Controller.text.isEmpty) {
                FocusScope.of(context).requestFocus(provider.controller1Focus);
              } else if (provider.otp2Controller.text.isEmpty) {
                FocusScope.of(context).requestFocus(provider.controller2Focus);
              } else if (provider.otp3Controller.text.isEmpty) {
                FocusScope.of(context).requestFocus(provider.controller3Focus);
              }
            },
            onChanged: (val) {
              if (val.isNotEmpty) {
                provider.showUnderlineOtp4 = true;
              } else {
                provider.showUnderlineOtp4 = false;
                FocusScope.of(context).requestFocus(provider.controller3Focus);
              }
              setState(() {});
            }),
      ],
    );
  }

  otpTextField() {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      validator: (v) {
        if (v!.length < 3) {
          return "I'm from validator";
        } else {
          return null;
        }
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        activeBoxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: AppColor.shadowColor,
            blurRadius: 10,
          )
        ],
        inActiveBoxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: AppColor.shadowColor,
            blurRadius: 10,
          )
        ],
        activeColor: AppColor.whiteColor,
        inactiveColor: AppColor.whiteColor,
        selectedColor: AppColor.whiteColor,
        selectedFillColor: AppColor.whiteColor,
        inactiveFillColor: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 50,
        fieldWidth: 50,
        activeFillColor: Colors.white,
      ),
      cursorColor: AppColor.appTheme,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      // errorAnimationController: errorController,
      // controller: textEditingController,
      keyboardType: TextInputType.number,
      boxShadows: [
        BoxShadow(
          offset: const Offset(0, 2),
          color: AppColor.shadowColor,
          blurRadius: 10,
        )
      ],
      onCompleted: (v) {
        debugPrint("Completed");
      },
      // onTap: () {
      //   print("Pressed");
      // },
      onChanged: (value) {
        debugPrint(value);
        setState(() {
          // currentText = value;
        });
      },
      beforeTextPaste: (text) {
        debugPrint("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }

  roundedTextField(
      {required TextEditingController controller,
      required bool showUnderline,
      required FocusNode focusNode,
      required ValueChanged<String>? onChanged,
      required Function() onTap}) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                color: AppColor.shadowColor,
                blurRadius: 10)
          ]),
      padding: const EdgeInsets.only(left: 7, right: 7),
      alignment: Alignment.center,
      child: TextFormField(
        focusNode: focusNode,
        enableInteractiveSelection: true,
        controller: controller,
        textAlign: TextAlign.center,
        cursorColor: AppColor.appTheme,
        style: TextStyle(
            fontSize: 18,
            color: AppColor.textBlackColor.withOpacity(.6),
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.poppinsMedium),
        cursorOpacityAnimates: true,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
            enabledBorder: showUnderline
                ? UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: AppColor.appTheme),
                  )
                : InputBorder.none,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColor.appTheme),
            )),
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
