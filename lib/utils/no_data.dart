import 'package:flutter/material.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:get/get.dart';
import 'package:patient/languages/language_constants.dart';
import 'package:patient/utils/utils.dart';

Widget noDataWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        AppImages.noDataIcon,
        height: 136,
        width: 140,
      ),
      ScreenSize.height(24),
      getText(
          title: getTranslated('noData', navigatorKey.currentContext!)!.tr,
          size: 16,
          fontFamily: FontFamily.poppinsRegular,
          color: AppColor.blackColor,
          fontWeight: FontWeight.w400)
    ],
  );
}
