import 'package:flutter/material.dart';
import 'package:patient/helper/appBar.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/customtextfield.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/providers/dashboard_provider/required_question_provider.dart';
import 'package:patient/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class RequiredQuestionScreen extends StatefulWidget {
  const RequiredQuestionScreen({super.key});

  @override
  State<RequiredQuestionScreen> createState() => _RequiredQuestionScreenState();
}

class _RequiredQuestionScreenState extends State<RequiredQuestionScreen> {
  DateTime selectedDate = DateTime.now();
  var day, month, year;

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider =
        Provider.of<RequiredQuestionProvider>(context, listen: false);
    myProvider.clearValues();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: appBar(StringKey.requiredQuestion.tr, true),
        body: Consumer<RequiredQuestionProvider>(
            builder: (context, myProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 50, bottom: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText(
                      title: "1. ${StringKey.name.tr}",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.nameController,
                    hintText: StringKey.enterYourName.tr,
                  ),
                  ScreenSize.height(20),
                  getText(
                      title: "2. ${StringKey.address.tr}",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.addressController,
                    hintText: StringKey.enterYourAddress.tr,
                  ),
                  ScreenSize.height(20),
                  getText(
                      title: "3. ${StringKey.postalCode.tr}",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.postalCodeController,
                    hintText: StringKey.enterYourPostalCode.tr,
                  ),
                  ScreenSize.height(20),
                  getText(
                      title: "4. ${StringKey.street.tr}",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.streetController,
                    hintText: StringKey.enterYourStreet.tr,
                  ),
                  ScreenSize.height(20),
                  getText(
                      title: "5. ${StringKey.city.tr}",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.cityController,
                    hintText: StringKey.enterYourCity.tr,
                  ),
                  ScreenSize.height(20),
                  getText(
                      title: "5. ${StringKey.insurance.tr}",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(18),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            customCheckBox(
                                borderColor: myProvider.privateInsurance
                                    ? AppColor.appTheme
                                    : AppColor.textBlackColor.withOpacity(.3),
                                backgroundColor: myProvider.privateInsurance
                                    ? AppColor.appTheme
                                    : AppColor.whiteColor,
                                onTap: () {
                                  if (myProvider.privateInsurance) {
                                    myProvider.updatePrivateInsurance(false);
                                  } else {
                                    myProvider.updatePrivateInsurance(true);
                                  }
                                }),
                            ScreenSize.width(15),
                            getText(
                                title: StringKey.private.tr,
                                size: 16,
                                fontFamily: FontFamily.poppinsRegular,
                                color: AppColor.textBlackColor.withOpacity(.6),
                                fontWeight: FontWeight.w400)
                          ],
                        ),
                        Row(
                          children: [
                            customCheckBox(
                                borderColor: myProvider.nationalInsurance
                                    ? AppColor.appTheme
                                    : AppColor.textBlackColor.withOpacity(.3),
                                backgroundColor: myProvider.nationalInsurance
                                    ? AppColor.appTheme
                                    : AppColor.whiteColor,
                                onTap: () {
                                  if (myProvider.nationalInsurance) {
                                    myProvider.updateNiationalInsurance(false);
                                  } else {
                                    myProvider.updateNiationalInsurance(true);
                                  }
                                }),
                            ScreenSize.width(15),
                            getText(
                                title: StringKey.national.tr,
                                size: 16,
                                fontFamily: FontFamily.poppinsRegular,
                                color: AppColor.textBlackColor.withOpacity(.6),
                                fontWeight: FontWeight.w400)
                          ],
                        )
                      ],
                    ),
                  ),
                  ScreenSize.height(33),
                  getText(
                      title: "7. ${StringKey.insuranceNo.tr}",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.insuranceController,
                    hintText: StringKey.enterYourInsuranceNo.tr,
                  ),
                  ScreenSize.height(20),
                  getText(
                      title: "8. ${StringKey.birthDate.tr}",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.birthDateController,
                    hintText: StringKey.enterYourBirthDate.tr,
                    isReadOnly: true,
                    icon: GestureDetector(
                      onTap: () {
                        birthdayPicker(myProvider);
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        alignment: Alignment.center,
                        child: const ImageIcon(
                          AssetImage(AppImages.calendarIcon),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  ScreenSize.height(50),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: AppButton(
                        title: StringKey.submit.tr,
                        height: 54,
                        width: double.infinity,
                        buttonColor: AppColor.appTheme,
                        onTap: () {
                          successDialogBox(context);
                        }),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  customCheckBox(
      {required Color borderColor,
      required Color backgroundColor,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
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

  Future<void> birthdayPicker(RequiredQuestionProvider provider) async {
    DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData(colorSchemeSeed: AppColor.appTheme),
            child: child!,
          );
        },
        helpText: "Select Birthday Date",
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1935, 1),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedDate = picked;
        day = selectedDate.day < 10 ? '0${selectedDate.day}' : selectedDate.day;
        month = selectedDate.month < 10
            ? '0${selectedDate.month}'
            : selectedDate.month;
        year = selectedDate.year;
        print(selectedDate);
        provider.birthDateController.text = "${selectedDate.year}-$month-$day";
      });
    }
  }

  void successDialogBox(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            // height: 394,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 35, left: 20, right: 20, bottom: 33),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppImages.checkImage,
                    height: 90,
                    width: 90,
                  ),
                  ScreenSize.height(42),
                  Text(
                    StringKey.requestSentSuccessfully.tr,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 14,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: AppColor.textBlackColor,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  ScreenSize.height(47),
                  Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: AppButton(
                        title: StringKey.backToHome.tr,
                        height: 50,
                        width: double.infinity,
                        buttonColor: AppColor.appTheme,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
