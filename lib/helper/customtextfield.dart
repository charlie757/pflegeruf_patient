import 'package:flutter/material.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';

class CustomTextfield extends StatelessWidget {
  final hintText;
  final TextEditingController controller;
  final icon;
  final isObscureText;
  const CustomTextfield(
      {super.key,
      this.hintText,
      required this.controller,
      this.icon,
      this.isObscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(0, 2),
                color: Color(0xff504DE4).withOpacity(.2)
                //  AppColor.blackColor.withOpacity(.2)
                )
          ]),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColor.appTheme,
        obscureText: isObscureText,
        style: TextStyle(
            fontSize: 14,
            color: AppColor.textBlackColor,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.poppinsMedium),
        decoration: InputDecoration(
            suffixIcon: icon,
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: 11,
                color: AppColor.textBlackColor.withOpacity(.6),
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.poppinsMedium),
            fillColor: AppColor.whiteColor,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.whiteColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.whiteColor))),
      ),
    );
  }
}
