import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appBar.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/providers/dashboard_provider/bookings_provider.dart';
import 'package:patient/screens/dashboard/bookings/view_booking_screen.dart';
import 'package:patient/widgets/ratingwidget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: appBar(StringKey.bookings.tr, false),
      body: Consumer<BookingsProvier>(builder: (context, myProvider, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              customTabBar(myProvider),
              Expanded(
                  child: myProvider.isSelectedTabBar == 0
                      ? activeBookingsWidget()
                      : pendingBookingsWidget())
            ],
          ),
        );
      }),
    );
  }

  customTabBar(BookingsProvier provier) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        children: [
          Flexible(
            child: GestureDetector(
              onTap: () {
                if (provier.isSelectedTabBar != 0) {
                  provier.updateSelectedTabBar(0);
                }
              },
              child: Column(
                children: [
                  getText(
                      title: StringKey.active.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsMedium,
                      color: provier.isSelectedTabBar == 0
                          ? AppColor.textBlackColor
                          : AppColor.textBlackColor.withOpacity(.6),
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(10),
                  Container(
                    height: 1,
                    color: provier.isSelectedTabBar == 0
                        ? AppColor.textBlackColor
                        : AppColor.borderD9Color,
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                if (provier.isSelectedTabBar != 1) {
                  provier.updateSelectedTabBar(1);
                }
              },
              child: Column(
                children: [
                  getText(
                      title: StringKey.pending.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsMedium,
                      color: provier.isSelectedTabBar == 1
                          ? AppColor.textBlackColor
                          : AppColor.textBlackColor.withOpacity(.6),
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(10),
                  Container(
                    height: 1,
                    color: provier.isSelectedTabBar == 1
                        ? AppColor.textBlackColor
                        : AppColor.borderD9Color,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  activeBookingsWidget() {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(10);
        },
        itemCount: 6,
        shrinkWrap: true,
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 40),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              AppRoutes.pushCupertinoNavigation(const ViewBookingScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 2),
                        color: AppColor.blackColor.withOpacity(.2),
                        blurRadius: 10)
                  ]),
              padding: const EdgeInsets.only(
                  left: 20, top: 20, bottom: 24, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/nurseProfile.png',
                          height: 70,
                          width: 70,
                        ),
                      ),
                      ScreenSize.width(15),
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
                      ratingWidget(12)
                    ],
                  ),
                  ScreenSize.height(20),
                  customRowDetailsWidget(
                      title: StringKey.bookingDate.tr, subTitle: '08 Dec 2022'),
                  ScreenSize.height(9),
                  customRowDetailsWidget(
                      title: StringKey.serviceName.tr, subTitle: 'Wound Care'),
                ],
              ),
            ),
          );
        });
  }

  pendingBookingsWidget() {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(10);
        },
        itemCount: 2,
        shrinkWrap: true,
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 40),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 2),
                      color: AppColor.blackColor.withOpacity(.2),
                      blurRadius: 10)
                ]),
            padding:
                const EdgeInsets.only(left: 20, top: 30, bottom: 30, right: 20),
            child: Column(
              children: [
                customRowDetailsWidget(
                    title: StringKey.bookingDate.tr, subTitle: '08 Dec 2022'),
                ScreenSize.height(14),
                customRowDetailsWidget(
                    title: StringKey.bookedFor.tr, subTitle: 'Wound Care'),
                ScreenSize.height(14),
                customRowDetailsWidget(
                    title: StringKey.patientName.tr,
                    subTitle: 'Alexandra Will'),
                ScreenSize.height(14),
                customRowDetailsWidget(
                    title: StringKey.patientAddress.tr,
                    subTitle: 'Berlin, Germany'),
              ],
            ),
          );
        });
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
