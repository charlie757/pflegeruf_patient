import 'package:flutter/material.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        leading: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
        ),
        centerTitle: true,
        title: getText(
            title: StringKey.notification,
            size: 20,
            fontFamily: FontFamily.poppinsSemiBold,
            color: AppColor.textBlackColor,
            fontWeight: FontWeight.w600),
      ),
      body: ListView.separated(
          separatorBuilder: (context, sp) {
            return ScreenSize.height(25);
          },
          padding: const EdgeInsets.only(top: 15, bottom: 30),
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return notificationWidget();
          }),
    );
  }

  notificationWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 21),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 43,
                width: 43,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 10,
                          color: AppColor.textBlackColor.withOpacity(.2))
                    ]),
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.bellIcon,
                  color: AppColor.appTheme,
                  height: 20,
                  width: 20,
                ),
              ),
              ScreenSize.width(19),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(
                        title: 'Your booking has been confirm successfully',
                        size: 15,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: AppColor.textBlackColor,
                        fontWeight: FontWeight.w600),
                    ScreenSize.height(10),
                    const getText(
                        title: '23 July 22 at 09:15 AM',
                        size: 14,
                        fontFamily: FontFamily.poppinsRegular,
                        color: Color(0xff606573),
                        fontWeight: FontWeight.w400)
                  ],
                ),
              )
            ],
          ),
        ),
        ScreenSize.height(25),
        Container(
          height: 1,
          color: AppColor.borderColor,
        )
      ],
    );
  }
}
