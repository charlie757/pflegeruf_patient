import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/screens/dashboard/home/required_question_screen.dart';

class ViewServiceScreen extends StatefulWidget {
  const ViewServiceScreen({super.key});

  @override
  State<ViewServiceScreen> createState() => _ViewServiceScreenState();
}

class _ViewServiceScreenState extends State<ViewServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/woundImg.png'),
                ScreenSize.height(32),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getText(
                          title: 'Wound Care',
                          size: 27,
                          fontFamily: FontFamily.poppinsRegular,
                          color: AppColor.appTheme,
                          fontWeight: FontWeight.w600),
                      ScreenSize.height(15),
                      const getText(
                          title: 'Apply gentle pressure to stop bleeding',
                          size: 16,
                          fontFamily: FontFamily.poppinsRegular,
                          color: AppColor.lightTextColor,
                          fontWeight: FontWeight.w400),
                      ScreenSize.height(27),
                      getText(
                          title: StringKey.description,
                          size: 18,
                          fontFamily: FontFamily.poppinsRegular,
                          color: AppColor.appTheme,
                          fontWeight: FontWeight.w600),
                      ScreenSize.height(7),
                      const getText(
                        title:
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of time and scrambled it.',
                        size: 14,
                        fontFamily: FontFamily.poppinsRegular,
                        color: AppColor.lightTextColor,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .3,
                        lineHeight: 1.5,
                      ),
                      ScreenSize.height(50),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 17, bottom: 40),
                        child: AppButton(
                            title: StringKey.continueTitle,
                            height: 54,
                            width: double.infinity,
                            buttonColor: AppColor.appTheme,
                            onTap: () {
                              AppRoutes.pushCupertinoNavigation(
                                  const RequiredQuestionScreen());
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 32,
              width: 32,
              margin: const EdgeInsets.only(left: 16, top: 45),
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(16)),
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
