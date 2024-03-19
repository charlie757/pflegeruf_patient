import 'package:flutter/material.dart';
import 'package:patient/utils/customcircleprogressdialog.dart';

showCircleProgressDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: CustomCircularProgressIndicator(),
        );
      });
}
