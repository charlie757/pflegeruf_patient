import 'package:flutter/material.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/customtextfield.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/providers/dashboard_provider/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<ProfileProvider>(context, listen: false);
    myProvider.clearValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: getText(
            title: StringKey.profile,
            size: 20,
            fontFamily: FontFamily.poppinsSemiBold,
            color: AppColor.textBlackColor,
            fontWeight: FontWeight.w600),
        actions: [
          GestureDetector(
            onTap: () {
              openBottomSheetOptions();
              // Navigator.pop(context);
            },
            child: Container(
              width: 60,
              alignment: Alignment.center,
              child: Icon(
                Icons.more_vert_outlined,
                color: AppColor.textBlackColor.withOpacity(.5),
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ProfileProvider>(builder: (context, myProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.58, right: 20, bottom: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileImageWidget(),
                ScreenSize.height(27),
                getText(
                    title: StringKey.firstName,
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.textBlackColor.withOpacity(.6),
                    fontWeight: FontWeight.w400),
                ScreenSize.height(5),
                CustomTextfield(
                  controller: myProvider.firstNameController,
                  hintText: StringKey.enterFirstName,
                  icon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.edit,
                      color: AppColor.textBlackColor.withOpacity(.3),
                      size: 20,
                    ),
                  ),
                ),
                ScreenSize.height(20),
                getText(
                    title: StringKey.lastName,
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.textBlackColor.withOpacity(.6),
                    fontWeight: FontWeight.w400),
                ScreenSize.height(5),
                CustomTextfield(
                  controller: myProvider.lastNameController,
                  hintText: StringKey.enterLastName,
                  icon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.edit,
                      color: AppColor.textBlackColor.withOpacity(.3),
                      size: 20,
                    ),
                  ),
                ),
                ScreenSize.height(20),
                getText(
                    title: StringKey.email,
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.textBlackColor.withOpacity(.6),
                    fontWeight: FontWeight.w400),
                ScreenSize.height(5),
                CustomTextfield(
                  controller: myProvider.emailController,
                  hintText: StringKey.enterYourEmail,
                  icon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.edit,
                      color: AppColor.textBlackColor.withOpacity(.3),
                      size: 20,
                    ),
                  ),
                ),
                ScreenSize.height(20),
                getText(
                    title: StringKey.phoneNumber,
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.textBlackColor.withOpacity(.6),
                    fontWeight: FontWeight.w400),
                ScreenSize.height(5),
                CustomTextfield(
                  controller: myProvider.phoneController,
                  hintText: StringKey.enterYourPhonenUmber,
                  icon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.edit,
                      color: AppColor.textBlackColor.withOpacity(.3),
                      size: 20,
                    ),
                  ),
                ),
                ScreenSize.height(20),
                getText(
                    title: StringKey.password,
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.textBlackColor.withOpacity(.6),
                    fontWeight: FontWeight.w400),
                ScreenSize.height(5),
                CustomTextfield(
                  controller: myProvider.passwordController,
                  hintText: StringKey.enterYourPasword,
                  isObscureText: myProvider.isVisiblePassword,
                  icon: GestureDetector(
                    onTap: () {
                      if (myProvider.isVisiblePassword) {
                        myProvider.updateIsVisiblePassword(false);
                      } else {
                        myProvider.updateIsVisiblePassword(true);
                      }
                    },
                    child: Icon(
                      myProvider.isVisiblePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColor.textBlackColor.withOpacity(.3),
                      size: 20,
                    ),
                  ),
                ),
                ScreenSize.height(50),
                Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17),
                  child: AppButton(
                      title: StringKey.saveChanges,
                      height: 54,
                      width: double.infinity,
                      buttonColor: AppColor.appTheme,
                      onTap: () {}),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  profileImageWidget() {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/dummyProfile.png',
            height: 100,
            width: 100,
          ),
          Positioned(
            right: 0,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Icon(
                Icons.edit,
                color: AppColor.textBlackColor.withOpacity(.3),
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  openBottomSheetOptions() {
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: OutlineInputBorder(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            borderSide: BorderSide(color: AppColor.whiteColor)),
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    openDialogBox(
                        isLogout: true,
                        title: StringKey.youWantToLogout,
                        noTap: () {
                          Navigator.pop(context);
                        },
                        yesTap: () {
                          Navigator.pop(context);
                        });
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getText(
                            title: StringKey.logout,
                            size: 16,
                            fontFamily: FontFamily.poppinsMedium,
                            color: AppColor.textBlackColor,
                            fontWeight: FontWeight.w400),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColor.appTheme,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
                ScreenSize.height(13),
                Container(
                  height: 1,
                  color: const Color(0xffDDE0E4),
                ),
                ScreenSize.height(13),
                GestureDetector(
                  onTap: () {
                    openDialogBox(
                        isLogout: false,
                        title: StringKey.youWantToDeleteAccount,
                        noTap: () {
                          Navigator.pop(context);
                        },
                        yesTap: () {
                          Navigator.pop(context);
                        });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getText(
                            title: StringKey.deleteAccount,
                            size: 16,
                            fontFamily: FontFamily.poppinsMedium,
                            color: AppColor.textBlackColor,
                            fontWeight: FontWeight.w400),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColor.appTheme,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void openDialogBox(
      {required bool isLogout,
      required String title,
      required Function() noTap,
      required Function() yesTap}) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Stack(
          children: [
            Center(
              child: Container(
                // height: 394,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 35, left: 20, right: 20, bottom: 33),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: AppColor.textBlackColor,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      ScreenSize.height(47),
                      Row(
                        children: [
                          Flexible(
                            child: AppButton(
                                title: StringKey.no,
                                height: 50,
                                width: double.infinity,
                                buttonColor: AppColor.whiteColor,
                                textColor: AppColor.textBlackColor,
                                onTap: noTap),
                          ),
                          ScreenSize.width(20),
                          Flexible(
                            child: AppButton(
                                title: StringKey.yes,
                                height: 50,
                                width: double.infinity,
                                buttonColor: AppColor.appTheme,
                                onTap: yesTap),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                right: 0 + 33,
                top: isLogout
                    ? MediaQuery.of(context).size.height / 2.8
                    : MediaQuery.of(context).size.height / 2.9,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    AppImages.closeIcon,
                    height: 25,
                    width: 25,
                  ),
                ))
          ],
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