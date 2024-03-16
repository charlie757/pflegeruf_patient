import 'package:flutter/material.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/utils/utils.dart';

AppBar appBar(String title, bool showLeading) {
  return AppBar(
    backgroundColor: AppColor.whiteColor,
    automaticallyImplyLeading: false,
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    centerTitle: true,
    leading: showLeading
        ? Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(navigatorKey.currentContext!);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 18),
                  alignment: Alignment.center,
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: AppColor.appTheme,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: AppColor.whiteColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          )
        : Container(),
    title: getText(
        title: title,
        size: 20,
        fontFamily: FontFamily.poppinsSemiBold,
        color: AppColor.textBlackColor,
        fontWeight: FontWeight.w600),
  );
}
