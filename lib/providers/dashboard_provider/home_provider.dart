import 'package:flutter/material.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/model/home_model.dart';
import 'package:patient/utils/showcircleprogessdialog.dart';
import 'package:patient/utils/utils.dart';

class HomeProvider extends ChangeNotifier {
  int currentSliderIndex = 0;
  HomeModel? homeModel;
  updateSliderIndex(value) {
    currentSliderIndex = value;
    notifyListeners();
  }

  clearValues() {
    homeModel = null;
  }

  homeApiFunction() {
    var data = {'': ''};
    homeModel != null
        ? null
        : showCircleProgressDialog(navigatorKey.currentContext!);
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(
            url: ApiUrl.homeUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      homeModel != null ? null : Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        homeModel = HomeModel.fromJson(value);
        notifyListeners();
      }
    });
  }
}
