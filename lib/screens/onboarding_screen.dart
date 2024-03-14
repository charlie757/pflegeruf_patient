import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/screens/choose_login_type_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List onboardingList = [
    {
      'img': AppImages.onboarding1Image,
      'title': StringKey.findYourNurse,
      'subTitle':
          'Lorem Ipsum is simply dummy text of the printing and for typesetting industry. '
    },
    {
      'img': AppImages.onboarding2Image,
      'title': StringKey.chooseBestNurse,
      'subTitle':
          'Lorem Ipsum is simply dummy text of the printing and for typesetting industry. '
    },
    {
      'img': AppImages.onboarding3Image,
      'title': StringKey.smartBookingSystem,
      'subTitle':
          'Lorem Ipsum is simply dummy text of the printing and for typesetting industry. '
    },
  ];

  int currentIndex = 0;
  String title = '';
  String subTitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: PageView.builder(
              itemCount: onboardingList.length,
              itemBuilder: (context, index) {
                currentIndex = index;
                title = onboardingList[index]['title'];
                subTitle = onboardingList[index]['subTitle'];
                return Image.asset(onboardingList[index]['img']);
              }),
        ),
        Expanded(
          child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.appTheme,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 30, bottom: 35),
              child: Column(
                children: [
                  getText(
                      title: title,
                      size: 23,
                      fontFamily: '',
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w700),
                  ScreenSize.height(30),
                  getText(
                    title: subTitle,
                    size: 18,
                    fontFamily: '',
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                  ),
                  ScreenSize.height(40),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(onboardingList.length, (index) {
                        return currentIndex == index
                            ? indicator(false)
                            : indicator(true);
                      })),
                  const Spacer(),
                  AppButton(
                      title: StringKey.getStarted,
                      height: 54,
                      width: double.infinity,
                      buttonColor: AppColor.whiteColor,
                      textColor: AppColor.blackColor,
                      onTap: () {
                        AppRoutes.pushNavigation(ChooseLoginTypeScreen());
                      })
                ],
              )),
        )
      ],
    )));
  }

  Widget indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 10.0,
        width: isActive ? 12 : 10.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: !isActive
              ? AppColor.whiteColor.withOpacity(.5)
              : AppColor.whiteColor,
        ),
      ),
    );
  }
}
