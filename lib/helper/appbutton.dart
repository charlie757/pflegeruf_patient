import 'package:flutter/material.dart';
import 'package:patient/helper/fontfamily.dart';
import 'package:patient/helper/getText.dart';

class AppButton extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final Color buttonColor;
  final Color textColor;
  final Function() onTap;
  const AppButton({
    super.key,
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: widget.height,
        width: widget.width,
        child: getText(
            title: widget.title,
            size: 16,
            fontFamily: FontFamily.poppinsSemiBold,
            color: widget.textColor,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
