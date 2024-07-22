import 'package:flutter/material.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/model/booking_model.dart';
import 'package:patient/model/complete_booking_model.dart';
import 'package:patient/utils/enum_booking_status.dart';
import 'package:patient/utils/showcircleprogessdialog.dart';
import 'package:patient/utils/utils.dart';

class BookingsProvier extends ChangeNotifier {
  CompleteBookingModel? completeBookingModel;
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

  callApiFunction(bool isLoading) {
    var data = {'': ''};
    isLoading ? showCircleProgressDialog(navigatorKey.currentContext!) : null;
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
      isLoading ? Navigator.pop(navigatorKey.currentContext!) : null;
      updateLoading(false);
      if (value != null) {
        for (int i = 0; i < value['data']['myListing'].length; i++) {
          if (value['data']['myListing'][i]['booking_status'] == "NEW") {
            pendingList.add(value['data']['myListing'][i]);
          } else if (value['data']['myListing'][i]['booking_status'] ==
              "ACCEPTED") {
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

  completedBookingApiFunction(isLoading) async {
    var data = {'': ''};
    isLoading ? showCircleProgressDialog(navigatorKey.currentContext!) : null;
    updateLoading(isLoading);
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.completedBookingListUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      updateLoading(false);
      isLoading ? Navigator.pop(navigatorKey.currentContext!) : null;
      if (value != null) {
        completeBookingModel = CompleteBookingModel.fromJson(value);
        notifyListeners();
      } else {
        completeBookingModel = null;
        notifyListeners();
      }
    });
  }
}
