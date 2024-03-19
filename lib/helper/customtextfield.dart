// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';

class CustomTextfield extends StatelessWidget {
  final hintText;
  final TextEditingController controller;
  final icon;
  final isObscureText;
  final isReadOnly;
  final errorMsg;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;
  const CustomTextfield(
      {super.key,
      this.hintText,
      required this.controller,
      this.icon,
      this.isObscureText = false,
      this.isReadOnly = false,
      this.inputFormatters,
      this.textInputType = TextInputType.name,
      this.errorMsg = '',
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
            inputFormatters: inputFormatters,
            readOnly: isReadOnly,
            cursorColor: AppColor.appTheme,
            obscureText: isObscureText,
            keyboardType: textInputType,
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
                    borderSide: BorderSide(
                        color: errorMsg == '' || errorMsg == null
                            ? AppColor.whiteColor
                            : AppColor.redColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: errorMsg == '' || errorMsg == null
                            ? AppColor.whiteColor
                            : AppColor.redColor))),
            onChanged: onChanged,
          ),
        ),
        errorMsg == '' || errorMsg == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(left: 4, top: 5),
                child: getText(
                    title: errorMsg.toString(),
                    size: 12,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.redColor,
                    fontWeight: FontWeight.w500),
              )
      ],
    );
  }
}
