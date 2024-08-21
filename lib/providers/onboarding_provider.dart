import 'package:flutter/widgets.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/languages/language_constants.dart';
import 'package:patient/screens/choose_login_type_screen.dart';
import 'package:get/get.dart';
import 'package:patient/utils/utils.dart';

class OnboardingProvider extends ChangeNotifier {
  List onboardingList = [
    {
      'img': AppImages.onboarding1Image,
      'title': getTranslated('findYourNurse', navigatorKey.currentContext!)!.tr,
      'subTitle': getTranslated(
              'findYourNurseDescription', navigatorKey.currentContext!)!
          .tr
    },
    {
      'img': AppImages.onboarding2Image,
      'title':
          getTranslated('chooseBestNurse', navigatorKey.currentContext!)!.tr,
      'subTitle': getTranslated(
              'chooseBestNurseDescription', navigatorKey.currentContext!)!
          .tr
    },
    {
      'img': AppImages.onboarding3Image,
      'title':
          getTranslated('smartBookingSystem', navigatorKey.currentContext!)!.tr,
      'subTitle': getTranslated(
              'smartBookingSystemDescription', navigatorKey.currentContext!)!
          .tr
    },
  ];
  int currentIndex = 0;

  updateValues(index) {
    currentIndex = index;
    notifyListeners();
  }

  checkValidation() {
    if (currentIndex < 2) {
      updateValues(currentIndex + 1);
    } else {
      AppRoutes.pushCupertinoNavigation(const ChooseLoginTypeScreen());
    }
  }
}
