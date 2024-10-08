import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appBar.dart';
import 'package:patient/helper/appbutton.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';
import 'package:patient/helper/screensize.dart';
import 'package:patient/languages/language_constants.dart';
import 'package:patient/providers/dashboard_provider/view_service_provider.dart';
import 'package:patient/screens/dashboard/home/required_question_screen.dart';
import 'package:get/get.dart';
import 'package:patient/utils/utils.dart';
import 'package:provider/provider.dart';

class ViewServiceScreen extends StatefulWidget {
  final id;
  const ViewServiceScreen({super.key, this.id});

  @override
  State<ViewServiceScreen> createState() => _ViewServiceScreenState();
}

class _ViewServiceScreenState extends State<ViewServiceScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<ViewServiceProvider>(context, listen: false);
    provider.model = null;
    Future.delayed(Duration.zero, () {
      provider.callApiFunction(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewServiceProvider>(builder: (context, myProvider, child) {
      return MediaQuery(
        data: mediaQuery,
        child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: appBar('', true),
          body: Stack(
            children: [
              myProvider.model != null && myProvider.model!.data != null
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          myProvider.model!.data != null &&
                                  myProvider.model!.data!.category != null &&
                                  myProvider.model!.data!.category!
                                          .categoryImage !=
                                      null
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${myProvider.model!.data!.category!.categoryPath}${myProvider.model!.data!.category!.categoryImage}',
                                    height: 300,
                                    width: double.infinity,
                                  ))
                              : Image.asset('assets/images/woundImg.png'),
                          ScreenSize.height(32),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getText(
                                    title:
                                        myProvider.model!.data!.category != null
                                            ? myProvider.model!.data!.category!
                                                    .categoryName ??
                                                ''
                                            : '',
                                    size: 27,
                                    fontFamily: FontFamily.poppinsRegular,
                                    color: AppColor.appTheme,
                                    fontWeight: FontWeight.w600),
                                // ScreenSize.height(15),
                                // const getText(
                                //     title:
                                //         'Apply gentle pressure to stop bleeding',
                                //     size: 16,
                                //     fontFamily: FontFamily.poppinsRegular,
                                //     color: AppColor.lightTextColor,
                                //     fontWeight: FontWeight.w400),
                                ScreenSize.height(27),
                                getText(
                                    title:
                                        getTranslated('description', context)!
                                            .tr,
                                    size: 18,
                                    fontFamily: FontFamily.poppinsRegular,
                                    color: AppColor.appTheme,
                                    fontWeight: FontWeight.w600),
                                ScreenSize.height(7),
                                getText(
                                  title:
                                      myProvider.model!.data!.category != null
                                          ? myProvider.model!.data!.category!
                                                  .description ??
                                              ''
                                          : '',
                                  size: 14,
                                  fontFamily: FontFamily.poppinsRegular,
                                  color: AppColor.lightTextColor,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .3,
                                  lineHeight: 1.5,
                                ),
                                ScreenSize.height(15),
                                Text.rich(TextSpan(
                                  text: "${getTranslated('bookForFree', context)!}: ",
                                  style: TextStyle(
                                    fontSize: 13,color: AppColor.blackColor,
                                    fontWeight: FontWeight.w600,fontFamily: FontFamily.poppinsSemiBold
                                  ),children: [
                                    TextSpan(
                                      text: '35 Euro ',
                                      style: TextStyle( fontSize: 14,color: AppColor.blackColor,
                                    fontWeight: FontWeight.w600,fontFamily: FontFamily.poppinsSemiBold),
                                    children: [
                                    TextSpan(
                                      text: getTranslated('inklMwst', context)!,
                                      style: TextStyle(
                                        fontSize: 13,color: AppColor.blackColor,
                                    fontWeight: FontWeight.w600,fontFamily: FontFamily.poppinsSemiBold
                                      )
                                    )  
                                    ]
                                    ),
                                  ]
                                )),
                                ScreenSize.height(50),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7, right: 17, bottom: 40),
                                  child: AppButton(
                                      title: getTranslated(
                                              'continueTitle', context)!
                                          .tr,
                                      height: 54,
                                      width: double.infinity,
                                      buttonColor: AppColor.appTheme,
                                      onTap: () {
                                        AppRoutes.pushCupertinoNavigation(
                                            RequiredQuestionScreen(
                                          id: myProvider.model!.data!.category!
                                              .categoryId,
                                          title: myProvider.model!.data!
                                              .category!.categoryName,
                                        ));
                                      }),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    });
  }
}
