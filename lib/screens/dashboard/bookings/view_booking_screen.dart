import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/network_image_helper.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/providers/dashboard_provider/profile_provider.dart';
import 'package:patient/providers/dashboard_provider/view_booking_provider.dart';
import 'package:patient/utils/no_data.dart';
import 'package:patient/utils/time_format.dart';
import 'package:patient/utils/utils.dart';
import 'package:patient/widgets/ratingwidget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ViewBookingScreen extends StatefulWidget {
  final bookingId;
  const ViewBookingScreen({super.key, this.bookingId});

  @override
  State<ViewBookingScreen> createState() => _ViewBookingScreenState();
}

class _ViewBookingScreenState extends State<ViewBookingScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<ViewBookingProvider>(context, listen: false);
    provider.clearValues();
    Future.delayed(Duration.zero, () {
      provider.callApiFunction(widget.bookingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Consumer<ViewBookingProvider>(
            builder: (context, myProvider, child) {
          return Stack(
            children: [
              myProvider.model != null &&
                      myProvider.model!.data != null &&
                      myProvider.model!.data!.myListing != null
                  ? SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 43),
                          child: Column(
                            children: [
                              myProvider.model!.data!.myListing!.nurse != null
                                  ? ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15)),
                                      child: NetworkImageHelper(
                                        img: myProvider.model!.data!.myListing!
                                            .nurse!.photo,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .5,
                                        width: double.infinity,
                                      ),
                                    )
                                  : SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .5,
                                      width: double.infinity,
                                    ),
                              ScreenSize.height(34),
                              userDetails(myProvider),
                              ScreenSize.height(50),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 38, right: 38),
                                child: AppButton(
                                    title: StringKey.giveReview.tr,
                                    height: 54,
                                    width: double.infinity,
                                    buttonColor: AppColor.appTheme,
                                    onTap: () {
                                      openRatingBottomSheet(
                                          myProvider, profileProvider);
                                    }),
                              )
                            ],
                          )),
                    )
                  : Align(alignment: Alignment.center, child: noDataWidget()),
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
          );
        }),
      ),
    );
  }

  userDetails(ViewBookingProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  provider.model!.data!.myListing!.nurse != null
                      ? provider.model!.data!.myListing!.nurse!.name
                              .toString()
                              .substring(0)
                              .toUpperCase()[0] +
                          provider.model!.data!.myListing!.nurse!.name
                              .toString()
                              .substring(1)
                              .toLowerCase()
                      : '',
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
                ratingWidget(
                    size: 17,
                    initalRating: provider.model!.data!.myListing!.nurse !=
                                null &&
                            provider.model!.data!.myListing!.nurse!.rating !=
                                null
                        ? double.parse(provider
                            .model!.data!.myListing!.nurse!.rating
                            .toString())
                        : 0,
                    isGesture: true,
                    onRatingUpdate: (val) {})
              ],
            ),
          ),
        ),
        ScreenSize.height(20),
        Padding(
          padding: const EdgeInsets.only(left: 31, right: 22),
          child: getText(
              title: provider.model!.data!.myListing!.bookingMessage ?? "",
              size: 16,
              fontFamily: FontFamily.poppinsRegular,
              color: Color(0xff606573),
              fontWeight: FontWeight.w400),
        ),
        ScreenSize.height(42),
        bookingDetailsWidget(provider),
      ],
    );
  }

  bookingDetailsWidget(ViewBookingProvider provider) {
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
              title: StringKey.bookingDate.tr,
              subTitle: provider.model!.data!.myListing!.bookingDate != null
                  ? TimeFormat.convertBookingDate(
                      provider.model!.data!.myListing!.bookingDate)
                  : ''),
          ScreenSize.height(14),
          customRowDetailsWidget(
              title: StringKey.bookedFor.tr,
              subTitle: provider.model!.data!.myListing!.service != null
                  ? provider.model!.data!.myListing!.service!.name
                  : ''),
          ScreenSize.height(14),
          customRowDetailsWidget(
              title: StringKey.patientName.tr,
              subTitle: provider.model!.data!.myListing!.patient != null
                  ? provider.model!.data!.myListing!.patient!.name
                          .toString()
                          .substring(0)
                          .toUpperCase()[0] +
                      provider.model!.data!.myListing!.patient!.name
                          .toString()
                          .substring(1)
                          .toLowerCase()
                  : ''),
          ScreenSize.height(14),
          customRowDetailsWidget(
              title: StringKey.patientAddress.tr,
              subTitle: provider.model!.data!.myListing!.patient != null
                  ? "${provider.model!.data!.myListing!.patient!.address}, ${provider.model!.data!.myListing!.patient!.street ?? ""}, ${provider.model!.data!.myListing!.patient!.city ?? ""}, ${provider.model!.data!.myListing!.patient!.postalCode.toString()}"
                  : ''),
        ],
      ),
    );
  }

  openRatingBottomSheet(
      ViewBookingProvider provider, ProfileProvider profileProvider) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
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
                            child:
                                provider.model!.data!.myListing!.nurse != null
                                    ? NetworkImageHelper(
                                        img: provider.model!.data!.myListing!
                                            .nurse!.photo,
                                        height: 100.0,
                                        width: 100.0,
                                      )
                                    : Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.grey.shade300,
                                      ),
                          ),
                          ScreenSize.width(21),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.model!.data!.myListing!.nurse != null
                                      ? provider.model!.data!.myListing!.nurse!
                                              .name
                                              .toString()
                                              .substring(0)
                                              .toUpperCase()[0] +
                                          provider.model!.data!.myListing!
                                              .nurse!.name
                                              .toString()
                                              .substring(1)
                                              .toLowerCase()
                                      : '',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: FontFamily.poppinsSemiBold,
                                      color: AppColor.textBlackColor,
                                      fontWeight: FontWeight.w600),
                                ),
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
                                    ratingWidget(
                                        size: 17,
                                        initalRating: provider.model!.data!
                                                        .myListing!.nurse !=
                                                    null &&
                                                provider.model!.data!.myListing!
                                                        .nurse!.rating !=
                                                    null
                                            ? double.parse(provider.model!.data!
                                                .myListing!.nurse!.rating
                                                .toString())
                                            : 0,
                                        isGesture: true,
                                        onRatingUpdate: (val) {}),
                                    ScreenSize.width(9),
                                    Flexible(
                                        child: Text(
                                      '(${provider.model!.data!.myListing!.nurse != null && provider.model!.data!.myListing!.nurse!.rating != null ? provider.model!.data!.myListing!.nurse!.rating.toString() : ''} reviews)',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
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
                    ratingWidget(
                        size: 33,
                        initalRating: provider.ratingStar,
                        isGesture: false,
                        onRatingUpdate: (val) {
                          provider.ratingStar = val;
                          print(val);
                          state(() {});
                          setState(() {});
                        }),
                    ScreenSize.height(35),
                    getText(
                        title: StringKey.yourComment.tr,
                        size: 15,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: AppColor.appTheme,
                        fontWeight: FontWeight.w600),
                    ScreenSize.height(7),
                    commentBoxWidget(provider),
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
                          onTap: () {
                            if (provider.ratingStar < 0) {
                              Utils.errorSnackBar('Add rating', context);
                            } else if (provider
                                .commentController.text.isEmpty) {
                              EasyLoading.showToast('Enter your comment');
                            } else {
                              provider.addRatingApiFunction(
                                  provider.model!.data!.myListing!.bookingId
                                      .toString(),
                                  profileProvider
                                      .profileModel!.data!.details!.pUserId
                                      .toString());
                            }
                          }),
                    ),
                    ScreenSize.height(20)
                  ],
                ),
              ),
            );
          });
        });
  }

  commentBoxWidget(ViewBookingProvider provider) {
    return TextFormField(
      maxLines: 5,
      controller: provider.commentController,
      cursorColor: AppColor.appTheme,
      textInputAction: TextInputAction.done,
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
        SizedBox(
          width: 115,
          child: getText(
              title: title,
              size: 14,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.textBlackColor,
              fontWeight: FontWeight.w500),
        ),
        ScreenSize.width(20),
        Flexible(
          child: getText(
              title: subTitle,
              textAlign: TextAlign.end,
              size: 14,
              fontFamily: FontFamily.poppinsMedium,
              color: const Color(0xff606573),
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
