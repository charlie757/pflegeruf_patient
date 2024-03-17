import 'package:flutter/material.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/providers/dashboard_provider/dashboard_provider.dart';
import 'package:patient/screens/dashboard/bookings/bookings_screen.dart';
import 'package:patient/screens/dashboard/home/home_screen.dart';
import 'package:patient/screens/dashboard/profile_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List screenList = [
    const HomeScreen(),
    const BookingsScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: screenList[myProvider.selectedIndex],
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(color: AppColor.whiteColor, boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 20,
                color: AppColor.shadowColor)
          ]),
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomNavigationItems(AppImages.bottomIcon1, 0, myProvider, () {
                myProvider.updateSelectedIndex(0);
              }),
              bottomNavigationItems(AppImages.bottomIcon2, 1, myProvider, () {
                myProvider.updateSelectedIndex(1);
              }),
              bottomNavigationItems(AppImages.bottomIcon3, 2, myProvider, () {
                myProvider.updateSelectedIndex(2);
              }),
            ],
          ),
        ),
      );
    });
  }

  bottomNavigationItems(
      String icon, int index, DashboardProvider provider, Function() onTap) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                icon,
                height: 24,
                width: 24,
                color: provider.selectedIndex == index
                    ? AppColor.appTheme
                    : const Color(0xffA9A9A9),
              ),
              ScreenSize.height(11),
              Container(
                height: 4,
                width: 51,
                decoration: BoxDecoration(
                    color: provider.selectedIndex == index
                        ? AppColor.appTheme
                        : AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
