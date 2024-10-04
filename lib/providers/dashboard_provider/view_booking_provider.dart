import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/model/view_booking_model.dart';
import 'package:patient/utils/showcircleprogessdialog.dart';
import 'package:patient/utils/utils.dart';

class ViewBookingProvider extends ChangeNotifier {
  double ratingStar = 3;
  final commentController = TextEditingController();
  ViewBookingModel? model;

  clearValues() {
    ratingStar = 3;
    commentController.clear();
  }

  callApiFunction(String id, bool isLoading) async {
    if(isLoading){
      model = null;
      notifyListeners();
      showCircleProgressDialog(navigatorKey.currentContext!);

    }
    var map = {
      'booking_id': id,
    };
    ApiService.multiPartApiMethod(
            url: ApiUrl.bookingDetailsUrl, body: map, isErrorMessageShow: true)
        .then((value) {
     isLoading? Navigator.pop(navigatorKey.currentContext!):null;
      if (value != null) {
        model = ViewBookingModel.fromJson(value);
        notifyListeners();
      }
    });
  }

  addRatingApiFunction(
    String productId,
    String userId,
      String bookingId
  ) {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var data = {
      "product_id": productId,
      "user_id": userId,
      "rating_star": ratingStar.toString(),
      "remark": commentController.text
    };
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(
            url: ApiUrl.addRatingUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: true)
        .then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        Navigator.pop(navigatorKey.currentContext!);
        callApiFunction(bookingId, false);
        clearValues();
        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
      } else {
        Navigator.pop(navigatorKey.currentContext!);
        print('object$value...');
      }
    });
  }
}
