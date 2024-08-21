import 'package:flutter/material.dart';
import 'package:patient/api/apiservice.dart';
import 'package:patient/api/apiurl.dart';
import 'package:patient/model/notification_model.dart';
import 'package:patient/utils/showcircleprogessdialog.dart';
import 'package:patient/utils/utils.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationModel? model;
  int unreadNotificationCount = 0;
  getNotificationApiFunction() async {
    model =null;
    showCircleProgressDialog(navigatorKey.currentContext!);
    var data = {'': ''};
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.notificationurl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        model = NotificationModel.fromJson(value);
        notifyListeners();
      } else {
        model = null;
        notifyListeners();
      }
    });
  }

  unreadNotificationApiFunction() async {
    var data = {'': ''};
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.unreadNotificationCountUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      if (value != null) {
        unreadNotificationCount =
            int.parse(value['data']['unread_count'].toString());
        notifyListeners();
      }
    });
  }

  readNotificationApiFunction() async {
    var data = {'': ''};
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.readNotificationurl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      if (value != null) {
        unreadNotificationApiFunction();
        notifyListeners();
      }
    });
  }
}
