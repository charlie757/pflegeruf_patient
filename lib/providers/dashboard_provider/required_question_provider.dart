import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/language_constants.dart';
import 'package:patient/utils/app_validation.dart';
import 'package:patient/utils/session_manager.dart';
import 'package:patient/utils/showcircleprogessdialog.dart';
import 'package:patient/utils/utils.dart';
import 'package:get/get.dart';

class RequiredQuestionProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  // final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final insuranceController = TextEditingController();
  final birthDateController = TextEditingController();
  int insuranceType = 0;

  /// to show the textfield error
  String? namevalidationMsg = '';
  String? lastNameValidationMsg = '';
  String? postalCodeValidationMsg = '';
  String? streetValidationMsg = '';
  String? cityValidationMsg = '';
  String? insuranceNoValidationMsg = '';
  String? birthDateValidationMsg = '';

  clearValues() {
    namevalidationMsg = '';
    lastNameValidationMsg = '';
    postalCodeValidationMsg = '';
    streetValidationMsg = '';
    cityValidationMsg = '';
    insuranceNoValidationMsg = '';
    birthDateValidationMsg = '';
    nameController.clear();
    postalCodeController.clear();
    streetController.clear();
    cityController.clear();
    insuranceController.clear();
    birthDateController.clear();
    insuranceType = 0;
  }

  updateInsurance(value) {
    insuranceType = value;
    notifyListeners();
  }

  checkValidation(String id, String title) {
    if (AppValidation.nameValidator(nameController.text) == null &&
        AppValidation.addressValidator(lastNameController.text) == null &&
        AppValidation.postalCodeValidator(postalCodeController.text) == null &&
        AppValidation.streetValidator(streetController.text) == null &&
        AppValidation.cityValidator(cityController.text) == null &&
        AppValidation.insuranceNoValidator(insuranceController.text) == null &&
        AppValidation.birthDateValidator(birthDateController.text) == null) {
      namevalidationMsg = AppValidation.nameValidator(nameController.text);
      lastNameValidationMsg =
          AppValidation.addressValidator(lastNameController.text);
      postalCodeValidationMsg =
          AppValidation.postalCodeValidator(postalCodeController.text);
      streetValidationMsg =
          AppValidation.streetValidator(streetController.text);
      cityValidationMsg = AppValidation.cityValidator(cityController.text);
      insuranceNoValidationMsg =
          AppValidation.insuranceNoValidator(insuranceController.text);
      birthDateValidationMsg =
          AppValidation.birthDateValidator(birthDateController.text);

      if (insuranceType == 0) {
        EasyLoading.showToast(
            getTranslated('selectInsuranceType', navigatorKey.currentContext!)!
                .tr);
      } else {
        callApiFunction(id, title);
      }
    } else {
      namevalidationMsg = AppValidation.nameValidator(nameController.text);
      lastNameValidationMsg =
          AppValidation.addressValidator(lastNameController.text);
      postalCodeValidationMsg =
          AppValidation.postalCodeValidator(postalCodeController.text);
      streetValidationMsg =
          AppValidation.streetValidator(streetController.text);
      cityValidationMsg = AppValidation.cityValidator(cityController.text);
      insuranceNoValidationMsg =
          AppValidation.insuranceNoValidator(insuranceController.text);
      birthDateValidationMsg =
          AppValidation.birthDateValidator(birthDateController.text);
    }
    notifyListeners();
  }

  callApiFunction(String id, String title) {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var data = {
      'title': title,
      'service': id,
      'name': nameController.text,
      'last_name': lastNameController.text,
      'street': streetController.text,
      'postal_code': postalCodeController.text,
      'city': cityController.text,
      'insurance_type': insuranceType == 1 ? 'Private' : 'National',
      'insurance_number': insuranceController.text.toString(),
      'dob': birthDateController.text,
      'lat': SessionManager.lat,
      'lng': SessionManager.lng
    };
    print(data);
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
      url: ApiUrl.nurseBookingUrl,
      body: body,
      method: checkApiMethod(httpMethod.post),
      // isErrorMessageShow: false,
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        if (value['status'] == 'success') {
          successDialogBox(navigatorKey.currentContext!);
        }
        notifyListeners();
      }
    });
  }

  void successDialogBox(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return PopScope(
          canPop: false,
          child: Center(
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
                      getTranslated('requestSentSuccessfully', context)!.tr,
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
                          title: getTranslated('backToHome', context)!.tr,
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
