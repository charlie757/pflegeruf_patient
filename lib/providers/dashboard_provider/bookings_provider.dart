import 'package:flutter/material.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/model/booking_model.dart';
import 'package:patient/utils/enum_booking_status.dart';
import 'package:patient/utils/showcircleprogessdialog.dart';
import 'package:patient/utils/utils.dart';

class BookingsProvier extends ChangeNotifier {
  BookingModel? activeModel;
  BookingModel? pendingModel;
  List pendingList = [];
  List activeList = [];
  bool isLoading = false;
  int isSelectedTabBar = 0;
  updateSelectedTabBar(value) {
    isSelectedTabBar = value;
    notifyListeners();
  }

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  callApiFunction() {
    var data = {'': ''};
    showCircleProgressDialog(navigatorKey.currentContext!);
    updateLoading(true);
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.bookingListUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      pendingList.clear();
      activeList.clear();
      Navigator.pop(navigatorKey.currentContext!);
      updateLoading(false);
      if (value != null) {
        for (int i = 0; i < value['data']['myListing'].length; i++) {
          if (value['data']['myListing'][i]['booking_status'] == "NEW") {
            pendingList.add(value['data']['myListing'][i]);
          } else {
            activeList.add(value['data']['myListing'][i]);
          }
        }
        notifyListeners();
      } else {
        pendingList.clear();
        activeList.clear();
      }
    });
  }
}
