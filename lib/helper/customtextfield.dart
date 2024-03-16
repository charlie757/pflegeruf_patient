import 'package:flutter/material.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';

class CustomTextfield extends StatelessWidget {
  final hintText;
  final TextEditingController controller;
  final icon;
  final isObscureText;
  final isReadOnly;
  const CustomTextfield(
      {super.key,
      this.hintText,
      required this.controller,
      this.icon,
      this.isObscureText = false,
      this.isReadOnly = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 15,
                spreadRadius: 0,
                offset: const Offset(0, 2),
                color: AppColor.shadowColor
                //  AppColor.blackColor.withOpacity(.2)
                )
          ]),
      child: TextFormField(
        controller: controller,
        readOnly: isReadOnly,
        cursorColor: AppColor.appTheme,
        obscureText: isObscureText,
        style: TextStyle(
            fontSize: 14,
            color: AppColor.textBlackColor,
            fontWeight: FontWeight.w500,
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
