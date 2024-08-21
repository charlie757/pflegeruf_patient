import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient/helper/appBar.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/customtextfield.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/language_constants.dart';
import 'package:patient/providers/dashboard_provider/required_question_provider.dart';
import 'package:patient/utils/app_validation.dart';
import 'package:patient/utils/location_service.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class RequiredQuestionScreen extends StatefulWidget {
  final id;
  final title;
  const RequiredQuestionScreen({super.key, this.id, this.title});

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
    getLocationPermission();
    final myProvider =
        Provider.of<RequiredQuestionProvider>(context, listen: false);
    myProvider.clearValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.whiteColor,
      appBar: appBar(getTranslated('requiredQuestion', context)!.tr, true),
      body: Consumer<RequiredQuestionProvider>(
          builder: (context, myProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(
                    title: "1. ${getTranslated('firstName', context)!.tr}",
                    size: 14,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.textBlackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(5),
                CustomTextfield(
                  controller: myProvider.nameController,
                  hintText: getTranslated('enterFirstName', context)!.tr,
                  textInputAction: TextInputAction.next,
                  errorMsg: myProvider.namevalidationMsg,
                  onChanged: (val) {
                    myProvider.namevalidationMsg =
                        AppValidation.nameValidator(val);
                    setState(() {});
                  },
                ),
                ScreenSize.height(20),
                getText(
                    title: "2. ${getTranslated('lastName', context)!.tr}",
                    size: 14,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.textBlackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(5),
                CustomTextfield(
                  controller: myProvider.lastNameController,
                  hintText: getTranslated('enterLastName', context)!.tr,
                  textInputAction: TextInputAction.next,
                  errorMsg: myProvider.lastNameValidationMsg,
                  onChanged: (val) {
                    myProvider.lastNameValidationMsg =
                        AppValidation.nameValidator(val);
                    setState(() {});
                  },
                ),
                ScreenSize.height(20),
                getText(
                    title: "3. ${getTranslated('street', context)!.tr}",
                    size: 14,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.textBlackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(5),
                CustomTextfield(
                  controller: myProvider.streetController,
                  hintText: getTranslated('enterYourStreet', context)!.tr,
                  errorMsg: myProvider.streetValidationMsg,
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    myProvider.streetValidationMsg =
                        AppValidation.streetValidator(val);
                    setState(() {});
                  },
                ),
                ScreenSize.height(20),
                getText(
                    title: "4. ${getTranslated('postalCode', context)!.tr}",
                    size: 14,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.textBlackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(5),
                CustomTextfield(
                  controller: myProvider.postalCodeController,
                  hintText: getTranslated('enterYourPostalCode', context)!.tr,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6)
                  ],
                  errorMsg: myProvider.postalCodeValidationMsg,
                  onChanged: (val) {
                    myProvider.postalCodeValidationMsg =
                        AppValidation.postalCodeValidator(val);
                    setState(() {});
                  },
                ),
                ScreenSize.height(20),
                getText(
                    title: "5. ${getTranslated('city', context)!.tr}",
                    size: 14,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.textBlackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(5),
                CustomTextfield(
                  controller: myProvider.cityController,
                  hintText: getTranslated('enterYourCity', context)!.tr,
                  textInputAction: TextInputAction.next,
                  errorMsg: myProvider.cityValidationMsg,
                  onChanged: (val) {
                    myProvider.cityValidationMsg =
                        AppValidation.cityValidator(val);
                    setState(() {});
                  },
                ),
                ScreenSize.height(20),
                getText(
                    title: "5. ${getTranslated('insurance', context)!.tr}",
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
                              borderColor: myProvider.insuranceType == 1
                                  ? AppColor.appTheme
                                  : AppColor.textBlackColor.withOpacity(.3),
                              backgroundColor: myProvider.insuranceType == 1
                                  ? AppColor.appTheme
                                  : AppColor.whiteColor,
                              onTap: () {
                                if (myProvider.insuranceType != 1) {
                                  myProvider.updateInsurance(1);
                                }
                              }),
                          ScreenSize.width(15),
                          getText(
                              title: getTranslated('private', context)!.tr,
                              size: 16,
                              fontFamily: FontFamily.poppinsRegular,
                              color: AppColor.textBlackColor.withOpacity(.6),
                              fontWeight: FontWeight.w400)
                        ],
                      ),
                      Row(
                        children: [
                          customCheckBox(
                              borderColor: myProvider.insuranceType == 2
                                  ? AppColor.appTheme
                                  : AppColor.textBlackColor.withOpacity(.3),
                              backgroundColor: myProvider.insuranceType == 2
                                  ? AppColor.appTheme
                                  : AppColor.whiteColor,
                              onTap: () {
                                if (myProvider.insuranceType != 2) {
                                  myProvider.updateInsurance(2);
                                }
                              }),
                          ScreenSize.width(15),
                          getText(
                              title: getTranslated('national', context)!.tr,
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
                    title: "7. ${getTranslated('insuranceNo', context)!.tr}",
                    size: 14,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.textBlackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(5),
                CustomTextfield(
                  controller: myProvider.insuranceController,
                  hintText: getTranslated('enterYourInsuranceNo', context)!.tr,
                  errorMsg: myProvider.insuranceNoValidationMsg,
                  textInputAction: TextInputAction.next,
                  // textInputType: TextInputType.text,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.deny(
                        RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
                  ],
                  onChanged: (val) {
                    myProvider.insuranceNoValidationMsg =
                        AppValidation.insuranceNoValidator(val);
                    setState(() {});
                  },
                ),
                ScreenSize.height(20),
                getText(
                    title: "8. ${getTranslated('birthDate', context)!.tr}",
                    size: 14,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.textBlackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(5),
                CustomTextfield(
                  controller: myProvider.birthDateController,
                  hintText: getTranslated('enterYourBirthDate', context)!.tr,
                  isReadOnly: true,
                  errorMsg: myProvider.birthDateValidationMsg,
                  textInputAction: TextInputAction.done,
                  onChanged: (val) {
                    myProvider.birthDateValidationMsg =
                        AppValidation.birthDateValidator(val);
                    setState(() {});
                  },
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
                      title: getTranslated('submit', context)!.tr,
                      height: 54,
                      width: double.infinity,
                      buttonColor: AppColor.appTheme,
                      onTap: () {
                        myProvider.checkValidation(
                            widget.id.toString(), widget.title);
                      }),
                )
              ],
            ),
          ),
        );
      }),
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
}
