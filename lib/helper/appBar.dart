import 'package:flutter/material.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';

AppBar appBar(String title) {
  return AppBar(
    backgroundColor: AppColor.whiteColor,
    automaticallyImplyLeading: false,
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    centerTitle: true,
    title: getText(
        title: title,
        size: 20,
        fontFamily: FontFamily.poppinsSemiBold,
        color: AppColor.textBlackColor,
        fontWeight: FontWeight.w600),
  );
}
