import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appBar.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/network_image_helper.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/model/booking_model.dart';
import 'package:patient/providers/dashboard_provider/bookings_provider.dart';
import 'package:patient/screens/dashboard/bookings/view_booking_screen.dart';
import 'package:patient/utils/no_data.dart';
import 'package:patient/utils/time_format.dart';
import 'package:patient/utils/utils.dart';
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
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<BookingsProvier>(context, listen: false);
    provider.isSelectedTabBar=0;
    Future.delayed(Duration.zero, () {
      provider.callApiFunction(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
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
                        ? activeBookingsWidget(myProvider)
                        : myProvider.isSelectedTabBar == 1
                            ? pendingBookingsWidget(myProvider)
                            : completeBookingsWidget(myProvider))
              ],
            ),
          );
        }),
      ),
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
                  provier.callApiFunction(false);
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
                  provier.callApiFunction(false);
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
          Flexible(
            child: GestureDetector(
              onTap: () {
                if (provier.isSelectedTabBar != 2) {
                  provier.completedBookingApiFunction(false);
                  provier.updateSelectedTabBar(2);
                }
              },
              child: Column(
                children: [
                  getText(
                      title: StringKey.completed.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsMedium,
                      color: provier.isSelectedTabBar == 2
                          ? AppColor.textBlackColor
                          : AppColor.textBlackColor.withOpacity(.6),
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(10),
                  Container(
                    height: 1,
                    color: provier.isSelectedTabBar == 2
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

  activeBookingsWidget(BookingsProvier provier) {
    return provier.activeList.isEmpty
        ? Align(
            alignment: Alignment.center,
            child: noDataWidget(),
          )
        : ListView.separated(
            separatorBuilder: (context, sp) {
              return ScreenSize.height(10);
            },
            itemCount: provier.activeList.length,
            shrinkWrap: true,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 40),
            itemBuilder: (context, index) {
              var model = BookingModel.fromJson(provier.activeList[index]);
              return GestureDetector(
                onTap: () {
                  AppRoutes.pushCupertinoNavigation(ViewBookingScreen(
                    bookingId: model.bookingId.toString(),
                  )).then((val) {
                    provier.callApiFunction(false);
                  });
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
                            child: model.nurse != null
                                ? NetworkImageHelper(
                                    img: model.nurse!.photo,
                                    height: 70.0,
                                    width: 70.0,
                                  )
                                : const SizedBox(
                                    height: 70,
                                    width: 70,
                                  ),
                          ),
                          ScreenSize.width(15),
                          Expanded(
                              child: Text(
                            model.nurse != null
                                ? model.nurse!.name != null
                                    ? model.nurse!.name
                                            .toString()
                                            .substring(0)
                                            .toUpperCase()[0] +
                                        model.nurse!.name
                                            .toString()
                                            .substring(1)
                                    : ''
                                : '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: FontFamily.poppinsSemiBold,
                                color: AppColor.textBlackColor,
                                fontWeight: FontWeight.w600),
                          )),
                          ratingWidget(
                              size: 12,
                              initalRating: model.nurse!.rating != null
                                  ? double.parse(model.nurse!.rating.toString())
                                  : 0,
                              isGesture: true,
                              onRatingUpdate: (val) {})
                        ],
                      ),
                      ScreenSize.height(20),
                      customRowDetailsWidget(
                          title: StringKey.bookingDate.tr,
                          subTitle: model.bookingDate != null
                              ? TimeFormat.convertBookingDate(model.bookingDate)
                              : ''),
                      ScreenSize.height(9),
              customRowDetailsWidget(
              title: StringKey.bookingTime.tr,
              subTitle: model.bookingDate != null
              ? TimeFormat.convertBookingTime(model.bookingDate)
                  : ''),
              ScreenSize.height(9),
                      customRowDetailsWidget(
                          title: StringKey.serviceName.tr,
                          subTitle:
                              model.service != null ? model.service!.name : ''),
                    ],
                  ),
                ),
              );
            });
  }

  completeBookingsWidget(BookingsProvier provier) {
    return provier.completeBookingModel!=null&&provier.completeBookingModel!.data!=null&& provier.completeBookingModel!.data!.myListing!=null&&provier.completeBookingModel!.data!.myListing!.isNotEmpty?
        ListView.separated(
            separatorBuilder: (context, sp) {
              return ScreenSize.height(10);
            },
            itemCount: provier.completeBookingModel!.data!.myListing!.length,
            shrinkWrap: true,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 40),
            itemBuilder: (context, index) {
              var model = provier.completeBookingModel!.data!.myListing![index];
              return GestureDetector(
                onTap: () {
                  AppRoutes.pushCupertinoNavigation(ViewBookingScreen(
                    bookingId: model.bookingId.toString(),
                  )).then((val) {
                    provier.completedBookingApiFunction(false);
                  });
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
                            child: model.nurse != null
                                ? NetworkImageHelper(
                                    img: model.nurse!.displayProfileImage,
                                    height: 70.0,
                                    width: 70.0,
                                  )
                                : const SizedBox(
                                    height: 70,
                                    width: 70,
                                  ),
                          ),
                          ScreenSize.width(15),
                          Expanded(
                              child: Text(
                            model.nurse != null
                                ? "${model.nurse!.pUserName != null ? model.nurse!.pUserName.toString().substring(0).toUpperCase()[0] + model.nurse!.pUserName.toString().substring(1) : ''} ${model.nurse!.pUserSurname != null ? model.nurse!.pUserSurname.toString().substring(0).toUpperCase()[0] + model.nurse!.pUserSurname.toString().substring(1) : ''}"
                                : '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: FontFamily.poppinsSemiBold,
                                color: AppColor.textBlackColor,
                                fontWeight: FontWeight.w600),
                          )),
                          ratingWidget(
                              size: 12,
                              initalRating: model.nurse!.ratingAsBuyer != null
                                  ? double.parse(
                                      model.nurse!.ratingAsBuyer.toString())
                                  : 0,
                              isGesture: true,
                              onRatingUpdate: (val) {})
                        ],
                      ),
                      ScreenSize.height(20),
                      customRowDetailsWidget(
                          title: StringKey.bookingDate.tr,
                          subTitle: model.statusCreatedAt != null
                              ? TimeFormat.convertBookingDate(
                                  model.statusCreatedAt)
                              : ''),
                      ScreenSize.height(9),
                      customRowDetailsWidget(
                          title: StringKey.bookingTime.tr,
                          subTitle: model.statusCreatedAt != null
                              ? TimeFormat.convertBookingTime(
                              model.statusCreatedAt)
                              : ''),
                      ScreenSize.height(9),
                      customRowDetailsWidget(
                          title: StringKey.serviceName.tr,
                          subTitle: model.productTitle ?? ''),
                    ],
                  ),
                ),
              );
            }):Align(
      alignment: Alignment.center,
      child: noDataWidget(),
    );
  }

  pendingBookingsWidget(BookingsProvier provier) {
    return provier.pendingList.isEmpty
        ? Align(
      alignment: Alignment.center,
      child: noDataWidget(),
    )
        : ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(10);
        },
        itemCount: provier.pendingList.length,
        shrinkWrap: true,
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 40),
        itemBuilder: (context, index) {
          var model = BookingModel.fromJson(provier.pendingList[index]);
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
                    title: StringKey.bookingDate.tr,
                    subTitle: model.bookingDate != null
                        ? TimeFormat.convertBookingDate(model.bookingDate)
                        : ''),
                ScreenSize.height(14),
                customRowDetailsWidget(
                    title: StringKey.bookingTime.tr,
                    subTitle: model.bookingDate != null
                        ? TimeFormat.convertBookingTime(model.bookingDate)
                        : ''),
                ScreenSize.height(14),
                customRowDetailsWidget(
                    title: StringKey.bookedFor.tr,
                    subTitle: model.service != null ? model.service!.name : ''),
                ScreenSize.height(14),
                customRowDetailsWidget(
                    title: StringKey.patientName.tr,
                    subTitle:
                        model.patient != null ? model.patient!.bookingName ?? "" : ''),
                ScreenSize.height(14),
                customRowDetailsWidget(
                    title: StringKey.patientAddress.tr,
                    subTitle: model.patient != null
                        ? "${model.patient!.address}, ${model.patient!.street ?? ""}, ${model.patient!.city ?? ""}, ${model.patient!.postalCode.toString()}"
                        : ''),
              ],
            ),
          );
        });
  }

  customRowDetailsWidget({required String title, required String subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 115,
          child: getText(
              title: title,
              size: 14,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.textBlackColor,
              fontWeight: FontWeight.w500),
        ),
        ScreenSize.width(5),
        Flexible(
          child: getText(
              title: subTitle,
              size: 14,
              textAlign: TextAlign.end,
              fontFamily: FontFamily.poppinsMedium,
              color: const Color(0xff606573),
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
