import 'package:flutter/material.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/utils/showcircleprogessdialog.dart';
import 'package:patient/utils/utils.dart';

class ViewBookingProvider extends ChangeNotifier {
  callApiFunction(String id) async {
    // model = null;
    // updateLoading(true);
    // showCircleProgressDialog(navigatorKey.currentContext!);
    var map = {
      'booking_id': id,
    };
    ApiService.multiPartApiMethod(
            url: ApiUrl.bookingDetailsUrl, body: map, isErrorMessageShow: true)
        .then((value) {
      // updateLoading(false);
      // Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        print('value..$value');
        // notifyListeners();
      }
    });
  }
}
