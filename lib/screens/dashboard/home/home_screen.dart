import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/network_image_helper.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/language_constants.dart';
import 'package:patient/providers/dashboard_provider/dashboard_provider.dart';
import 'package:patient/providers/dashboard_provider/home_provider.dart';
import 'package:patient/providers/dashboard_provider/notification_provider.dart';
import 'package:patient/providers/dashboard_provider/profile_provider.dart';
import 'package:patient/screens/dashboard/home/notification_screen.dart';
import 'package:patient/screens/dashboard/home/view_service_screen.dart';
import 'package:patient/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<HomeProvider>(context, listen: false);
    myProvider.homeApiFunction();
    Provider.of<NotificationProvider>(context, listen: false)
        .unreadNotificationApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    return MediaQuery(
      data: mediaQuery,
      child:
          Consumer<HomeProvider>(builder: (context, myProvider, childcontext) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.appTheme,
            scrolledUnderElevation: 0.0,
            title: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Row(
                children: [
                  profileProvider.profileModel != null &&
                          profileProvider.profileModel!.data != null &&
                          profileProvider.profileModel!.data!.details != null &&
                          profileProvider.profileModel!.data!.details!
                              .displayProfileImage.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            dashboardProvider.updateSelectedIndex(2);
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: NetworkImageHelper(
                                img: profileProvider.profileModel!.data!
                                    .details!.displayProfileImage,
                                height: 40.0,
                                width: 40.0,
                                isAnotherColorOfLodingIndicator: true,
                              )),
                        )
                      : Image.asset(
                          'assets/images/dummyProfile.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                  ScreenSize.width(10),
                  Flexible(
                    child: getText(
                        title:
                            '${getTranslated('welcome', context)!.tr}, ${profileProvider.profileModel != null && profileProvider.profileModel!.data != null && profileProvider.profileModel!.data!.details != null ? (profileProvider.profileModel!.data!.details!.firstName.toString().substring(0).toUpperCase()[0] + profileProvider.profileModel!.data!.details!.firstName.toString().substring(1)) : ''}',
                        size: 16,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
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
                        Provider.of<NotificationProvider>(context)
                                    .unreadNotificationCount ==
                                0
                            ? Container()
                            : Positioned(
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
                                      title: Provider.of<NotificationProvider>(
                                                      context)
                                                  .unreadNotificationCount >
                                              99
                                          ? "+99"
                                          : Provider.of<NotificationProvider>(
                                                  context)
                                              .unreadNotificationCount
                                              .toString(),
                                      size: 9,
                                      fontFamily: FontFamily.poppinsBold,
                                      color: AppColor.whiteColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerWidget(myProvider),
                  ScreenSize.height(40),
                  serviceWidget(myProvider)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  headerWidget(HomeProvider provider) {
    return provider.homeModel != null &&
            provider.homeModel!.data != null &&
            provider.homeModel!.data!.banners!.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
                color: AppColor.appTheme,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            padding: const EdgeInsets.only(top: 18, bottom: 35),
            child: Column(
              children: [
                SizedBox(
                  height: 168,
                  // color: Colors.red,
                  child: CarouselSlider.builder(
                    itemCount: provider.homeModel!.data!.banners!.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return Container(
                        margin: const EdgeInsets.only(
                          right: 15,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: NetworkImageHelper(
                              img:
                                  "${provider.homeModel!.data!.bannerPath}${provider.homeModel!.data!.banners![itemIndex].bannerImage}",
                              height: 168.0,
                              width: double.infinity,
                              isAnotherColorOfLodingIndicator: true,
                            )),
                      );
                    },
                    options: CarouselOptions(
                        autoPlay: true,
                        scrollDirection: Axis.horizontal,
                        // enlargeCenterPage: true,
                        viewportFraction: 1,
                        aspectRatio: 2.0,
                        initialPage: 0,
                        autoPlayCurve: Curves.ease,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 400),
                        autoPlayInterval: const Duration(seconds: 2),
                        onPageChanged: (val, _) {
                          provider.updateSliderIndex(val);
                        }),
                  ),
                ),
                ScreenSize.height(20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        provider.homeModel!.data!.banners!.length, (index) {
                      return provider.currentSliderIndex == index
                          ? indicator(true)
                          : indicator(false);
                    }))
              ],
            ),
          )
        : Container();
  }

  serviceWidget(HomeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: getText(
              title: getTranslated('serviceForYou', context)!.tr,
              size: 22,
              fontFamily: FontFamily.poppinsSemiBold,
              color: AppColor.textBlackColor,
              fontWeight: FontWeight.w600),
        ),
        ScreenSize.height(28),
        provider.homeModel != null &&
                provider.homeModel!.data != null &&
                provider.homeModel!.data!.category!.isNotEmpty
            ? GridView.builder(
                padding: const EdgeInsets.only(left: 32, right: 32),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.2),
                    crossAxisCount: 3,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 20),
                itemCount: provider.homeModel!.data!.category!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      AppRoutes.pushCupertinoNavigation(ViewServiceScreen(
                        id: provider
                            .homeModel!.data!.category![index].categoryId
                            .toString(),
                      ));
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
                            child: NetworkImageHelper(
                              img:
                                  "${provider.homeModel!.data!.categoryPath}${provider.homeModel!.data!.category![index].categoryImage}",
                              height: 40.0,
                              width: 40.0,
                            )),
                        ScreenSize.height(7),
                        Text(
                          provider
                              .homeModel!.data!.category![index].categoryName,
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
            : const SizedBox.shrink()
      ],
    );
  }

  Widget indicator(bool isActive) {
    return SizedBox(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 3.0),
        height: isActive ? 5 : 7.0,
        width: isActive ? 25 : 7.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isActive
              ? AppColor.whiteColor
              : AppColor.whiteColor.withOpacity(.5),
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
