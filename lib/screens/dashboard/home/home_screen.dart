import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/string_key.dart';
import 'package:patient/screens/dashboard/home/notification_screen.dart';
import 'package:patient/screens/dashboard/home/view_service_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List serviceList = [
    {'img': 'assets/images/bandaged-finger 1.png', 'title': 'Wound care'},
    {'img': 'assets/images/leg 1.png', 'title': 'Compression stockings'},
    {'img': 'assets/images/catheter 1.png', 'title': 'Catheter supply'},
    {'img': 'assets/images/abdominal-pain 1.png', 'title': 'Stoma care'},
    {'img': 'assets/images/medicine 1.png', 'title': 'Weekly Box'},
    {'img': 'assets/images/syringe 1.png', 'title': 'Injections'},
  ];
  List imgList = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [headerWidget(), ScreenSize.height(40), serviceWidget()],
          ),
        ),
      ),
    );
  }

  headerWidget() {
    return Container(
      // height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
          color: AppColor.appTheme,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      padding: const EdgeInsets.only(top: 55, bottom: 60),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/dummyProfile.png',
                  height: 40,
                  width: 40,
                ),
                ScreenSize.width(10),
                getText(
                    title: '${StringKey.welcome}, Alexandra',
                    size: 16,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    AppRoutes.pushCupertinoNavigation(
                        const NotificationScreen());
                  },
                  child: SizedBox(
                    height: 32,
                    width: 32,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            AppImages.bellIcon,
                            height: 26,
                            width: 26,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            height: 16,
                            width: 16,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColor.appTheme,
                                borderRadius: BorderRadius.circular(8)),
                            child: getText(
                                title: '2',
                                size: 9,
                                fontFamily: FontFamily.poppinsBold,
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          ScreenSize.height(48),
          SizedBox(
            height: 168,
            // color: Colors.red,
            child: CarouselSlider.builder(
              itemCount: imgList.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return Container(
                  margin: const EdgeInsets.only(
                    right: 15,
                  ),
                  child: Image.asset(
                    imgList[itemIndex],
                    fit: BoxFit.fill,
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                scrollDirection: Axis.horizontal,
                // enlargeCenterPage: true,
                viewportFraction: .9,
                aspectRatio: 2.0,
                initialPage: 0,
                autoPlayCurve: Curves.ease,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 400),
                autoPlayInterval: const Duration(seconds: 2),
              ),
            ),
          )
        ],
      ),
    );
  }

  serviceWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: getText(
              title: StringKey.serviceForYou,
              size: 22,
              fontFamily: FontFamily.poppinsSemiBold,
              color: AppColor.textBlackColor,
              fontWeight: FontWeight.w600),
        ),
        ScreenSize.height(28),
        GridView.builder(
            padding: const EdgeInsets.only(left: 32, right: 32),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.4),
                crossAxisCount: 3,
                mainAxisSpacing: 24,
                crossAxisSpacing: 20),
            itemCount: serviceList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  AppRoutes.pushCupertinoNavigation(const ViewServiceScreen());
                },
                child: Column(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 2),
                                color: AppColor.shadowColor,
                                blurRadius: 10)
                          ]),
                      alignment: Alignment.center,
                      child: Image.asset(
                        serviceList[index]['img'],
                        height: 40,
                        width: 40,
                      ),
                    ),
                    ScreenSize.height(8),
                    Text(
                      serviceList[index]['title'],
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: AppColor.appTheme,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              );
            })
      ],
    );
  }
}
