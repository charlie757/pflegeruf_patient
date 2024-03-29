import 'package:flutter/material.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/model/view_service_model.dart';
import 'package:patient/utils/showcircleprogessdialog.dart';
import 'package:patient/utils/utils.dart';

class ViewServiceProvider extends ChangeNotifier {
  ViewServiceModel? model;
  callApiFunction(String id) {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var data = {'category_id': id};
    print(data);
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
      url: ApiUrl.getServiceCategoryUrl,
      body: body,
      method: checkApiMethod(httpMethod.post),
      isErrorMessageShow: false,
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        model = ViewServiceModel.fromJson(value);
        notifyListeners();
      }
    });
  }
}
