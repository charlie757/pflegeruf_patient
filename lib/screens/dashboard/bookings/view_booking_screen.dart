import 'package:flutter/material.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/widgets/ratingwidget.dart';
import 'package:get/get.dart';

class ViewBookingScreen extends StatefulWidget {
  const ViewBookingScreen({super.key});

  @override
  State<ViewBookingScreen> createState() => _ViewBookingScreenState();
}

class _ViewBookingScreenState extends State<ViewBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 43),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/nurseProfile.png',
                    fit: BoxFit.fitHeight,
                  ),
                  ScreenSize.height(34),
                  userDetails(),
                  ScreenSize.height(50),
                  Padding(
                    padding: const EdgeInsets.only(left: 38, right: 38),
                    child: AppButton(
                        title: StringKey.giveReview.tr,
                        height: 54,
                        width: double.infinity,
                        buttonColor: AppColor.appTheme,
                        onTap: () {
                          openRatingBottomSheet();
                        }),
                  )
                ],
              ),
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

  userDetails() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  'Masia Glura',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w600),
                )),
                SizedBox(
                  height: 34,
                  child: VerticalDivider(
                    color: AppColor.textBlackColor.withOpacity(.2),
                  ),
                ),
                ScreenSize.width(30),
                ratingWidget(17)
              ],
            ),
          ),
        ),
        ScreenSize.height(20),
        const Padding(
          padding: EdgeInsets.only(left: 31, right: 22),
          child: getText(
              title: 'I’ll be there in 1 hour, I’m stuck in traffic',
              size: 16,
              fontFamily: FontFamily.poppinsRegular,
              color: Color(0xff606573),
              fontWeight: FontWeight.w400),
        ),
        ScreenSize.height(42),
        bookingDetailsWidget(),
      ],
    );
  }

  bookingDetailsWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 14),
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                color: AppColor.blackColor.withOpacity(.2),
                blurRadius: 10)
          ]),
      padding: const EdgeInsets.only(left: 20, top: 30, bottom: 30, right: 20),
      child: Column(
        children: [
          customRowDetailsWidget(
              title: StringKey.bookingDate.tr, subTitle: '08 Dec 2022'),
          ScreenSize.height(14),
          customRowDetailsWidget(
              title: StringKey.bookedFor.tr, subTitle: 'Wound Care'),
          ScreenSize.height(14),
          customRowDetailsWidget(
              title: StringKey.patientName.tr, subTitle: 'Alexandra Will'),
          ScreenSize.height(14),
          customRowDetailsWidget(
              title: StringKey.patientAddress.tr, subTitle: 'Berlin, Germany'),
        ],
      ),
    );
  }

  openRatingBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 30,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 2),
                              color: AppColor.textBlackColor.withOpacity(.2),
                              blurRadius: 10)
                        ]),
                    padding: const EdgeInsets.only(
                        left: 20, bottom: 22, top: 15, right: 15),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/Rectangle 31.png',
                            height: 100,
                            width: 100,
                          ),
                        ),
                        ScreenSize.width(21),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getText(
                                  title: 'Masia Glura',
                                  size: 18,
                                  fontFamily: FontFamily.poppinsSemiBold,
                                  color: AppColor.textBlackColor,
                                  fontWeight: FontWeight.w600),
                              ScreenSize.height(4),
                              const getText(
                                  title: 'Sr. Psychologist',
                                  size: 16,
                                  fontFamily: FontFamily.poppinsMedium,
                                  color: Color(0xff606573),
                                  fontWeight: FontWeight.w400),
                              ScreenSize.height(11),
                              Row(
                                children: [
                                  ratingWidget(17),
                                  ScreenSize.width(9),
                                  const Flexible(
                                      child: Text(
                                    '(20 reviews)',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: FontFamily.poppinsMedium,
                                        color: Color(0xff606573),
                                        fontWeight: FontWeight.w400),
                                  )),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  ScreenSize.height(30),
                  getText(
                      title: StringKey.leaveAReview.tr,
                      size: 22,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w600),
                  ScreenSize.height(6),
                  getText(
                      title: StringKey.howYourRateAndExperience.tr,
                      size: 13,
                      fontFamily: FontFamily.poppinsRegular,
                      color: const Color(0xff606573),
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(19),
                  getText(
                      title: '5 Star Rating',
                      size: 18,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.appTheme,
                      fontWeight: FontWeight.w600),
                  ScreenSize.height(12),
                  ratingWidget(33),
                  ScreenSize.height(35),
                  getText(
                      title: StringKey.yourComment.tr,
                      size: 15,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.appTheme,
                      fontWeight: FontWeight.w600),
                  ScreenSize.height(7),
                  commentBoxWidget(),
                  ScreenSize.height(40),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 17,
                      right: 17,
                    ),
                    child: AppButton(
                        title: StringKey.submitYourReview.tr,
                        height: 54,
                        width: double.infinity,
                        buttonColor: AppColor.appTheme,
                        onTap: () {}),
                  ),
                  ScreenSize.height(20)
                ],
              ),
            ),
          );
        });
  }

  commentBoxWidget() {
    return TextFormField(
      maxLines: 5,
      cursorColor: AppColor.appTheme,
      style: TextStyle(
          fontSize: 14,
          color: AppColor.textBlackColor,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.poppinsMedium),
      decoration: InputDecoration(
          hintText: 'ex. you guys are awsome',
          hintStyle: TextStyle(
              fontSize: 11,
              color: AppColor.textBlackColor.withOpacity(.6),
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.poppinsRegular),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xffDCDCDC))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xffDCDCDC)))),
    );
  }

  customRowDetailsWidget({required String title, required String subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getText(
            title: title,
            size: 14,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.textBlackColor,
            fontWeight: FontWeight.w500),
        ScreenSize.width(20),
        Flexible(
          child: getText(
              title: subTitle,
              size: 14,
              fontFamily: FontFamily.poppinsMedium,
              color: const Color(0xff606573),
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
