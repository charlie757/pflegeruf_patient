import 'package:flutter/material.dart';
import 'package:patient/helper/appcolor.dart';

class RequiredQuestionScreen extends StatefulWidget {
  const RequiredQuestionScreen({super.key});

  @override
  State<RequiredQuestionScreen> createState() => _RequiredQuestionScreenState();
}

class _RequiredQuestionScreenState extends State<RequiredQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
