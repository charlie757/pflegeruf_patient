import 'package:flutter/widgets.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/screens/choose_login_type_screen.dart';
import 'package:get/get.dart';

class OnboardingProvider extends ChangeNotifier {
  List onboardingList = [
    {
      'img': AppImages.onboarding1Image,
      'title': StringKey.findYourNurse.tr,
      'subTitle':
          'Lorem Ipsum is simply dummy text of the printing and for typesetting industry. '
    },
    {
      'img': AppImages.onboarding2Image,
      'title': StringKey.chooseBestNurse.tr,
      'subTitle':
          'Lorem Ipsum is simply dummy text of the printing and for typesetting industry. '
    },
    {
      'img': AppImages.onboarding3Image,
      'title': StringKey.smartBookingSystem.tr,
      'subTitle':
          'Lorem Ipsum is simply dummy text of the printing and for typesetting industry. '
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
