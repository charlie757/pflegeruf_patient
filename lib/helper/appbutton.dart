import 'package:flutter/material.dart';
import 'package:patient/helper/getText.dart';

class AppButton extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final Color buttonColor;
  final Color textColor;
  final Function() onTap;
  const AppButton({
    required this.title,
    required this.height,
    required this.width,
    required this.buttonColor,
    this.textColor = Colors.white,
    required this.onTap,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: widget.buttonColor,
          // primary:widget.isLoading?AppColor.greyColor.withOpacity(.9): AppColor.lightblackColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: widget.height,
        width: widget.width,
        child: getText(
            title: widget.title,
            size: 18,
            fontFamily: 'latoRegular',
            color: widget.textColor,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
