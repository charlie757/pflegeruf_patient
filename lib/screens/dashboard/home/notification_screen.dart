import 'package:flutter/material.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:get/get.dart';
import 'package:patient/languages/language_constants.dart';
import 'package:patient/providers/dashboard_provider/notification_provider.dart';
import 'package:patient/utils/no_data.dart';
import 'package:patient/utils/time_format.dart';
import 'package:patient/utils/utils.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    callIniFunction();
    super.initState();
  }

  callIniFunction() async {
    final provider = Provider.of<NotificationProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      provider.getNotificationApiFunction();
      provider.readNotificationApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child:
          Consumer<NotificationProvider>(builder: (context, myProvider, child) {
        return Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColor.whiteColor,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
            leading: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 18),
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: AppColor.appTheme,
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: AppColor.whiteColor,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: true,
            title: getText(
                title: getTranslated('notification', context)!.tr,
                size: 20,
                fontFamily: FontFamily.poppinsSemiBold,
                color: AppColor.textBlackColor,
                fontWeight: FontWeight.w600),
          ),
          body: myProvider.model != null
              ? myProvider.model!.data!.isEmpty||myProvider.model!.data==null
                  ? Align(alignment: Alignment.center, child: noDataWidget())
                  : ListView.separated(
                      separatorBuilder: (context, sp) {
                        return ScreenSize.height(25);
                      },
                      padding: const EdgeInsets.only(top: 15, bottom: 30),
                      itemCount: myProvider.model!.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return notificationWidget(index, myProvider);
                      })
              : Container(),
        );
      }),
    );
  }

  notificationWidget(int index, NotificationProvider provider) {
    var model = provider.model!.data![index];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 21),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 43,
                width: 43,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 10,
                          color: AppColor.textBlackColor.withOpacity(.2))
                    ]),
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.bellIcon,
                  color: AppColor.appTheme,
                  height: 20,
                  width: 20,
                ),
              ),
              ScreenSize.width(19),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(
                        title: model.msg ?? "",
                        size: 15,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: AppColor.textBlackColor,
                        fontWeight: FontWeight.w600),
                    ScreenSize.height(10),
                    getText(
                        title: model.notificationCreatedAt != null
                            ? TimeFormat.convertNotificationDate(
                                model.notificationCreatedAt)
                            : "",
                        size: 14,
                        fontFamily: FontFamily.poppinsRegular,
                        color: Color(0xff606573),
                        fontWeight: FontWeight.w400)
                  ],
                ),
              )
            ],
          ),
        ),
        ScreenSize.height(25),
        Container(
          height: 1,
          color: AppColor.borderColor,
        )
      ],
    );
  }
}
