import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:patient/utils/session_manager.dart';
import 'package:patient/utils/utils.dart';

enum httpMethod { post, get, delete, put }

checkApiMethod(type) {
  switch (type) {
    case httpMethod.post:
      return 'POST';
    case httpMethod.get:
      return 'GET';
    case httpMethod.delete:
      return 'DELETE';
    case httpMethod.put:
      return 'PUT';
    default:
      print('Unknown color');
  }
}

class ApiService {
  static Future apiMethod(
      {required String url,
      required var body,
      required String method,
      bool isErrorMessageShow = true,
      bool isBodyNotRequired = false}) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final request = http.Request(
            method,
            Uri.parse(url),
          );
          if (!isBodyNotRequired) {
            request.body = body;
          }
          request.headers['Content-Type'] = 'application/x-www-form-urlencoded';
          request.headers['Authorization'] = "Bearer ${SessionManager.token}";
          // request.encoding Encoding.getByName('utf-8');
          final client = http.Client();
          final streamedResponse = await client.send(request);
          final response = await http.Response.fromStream(streamedResponse);
          print(response.request);
          log(response.body);
          print(response.statusCode);
          return _handleResponse(response, isErrorMessageShow);
        } on Exception catch (_) {
          rethrow;
        }
      } else {}
    } on SocketException catch (_) {
      Utils.internetSnackBar(navigatorKey.currentContext!);
      // print('not connected');
    }
  }

  static Future multiPartApiMethod(
      {required String url,
      required var body,
      bool isErrorMessageShow = true,
      bool isBodyNotRequired = false}) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          Map<String, String> headers = {
            "Authorization": "Bearer ${SessionManager.token}"
          };

          var request = http.MultipartRequest('POST', Uri.parse(url));
          request.headers.addAll(headers);
          request.fields.addAll(body);
          var res = await request.send();
          var vb = await http.Response.fromStream(res);
          print(request.url);
          log(vb.body);
          return _handleResponse(vb, isErrorMessageShow);
        } on Exception catch (_) {
          rethrow;
        }
      } else {}
    } on SocketException catch (_) {
      Utils.internetSnackBar(navigatorKey.currentContext!);
      // print('not connected');
    }
  }

  // Helper method to handle API response
  static Map<String, dynamic>? _handleResponse(
      http.Response response, isErrorMessageShow) {
    if (response.statusCode == 200) {
      /// checking status code inside of "response status code"
      var dataAll = json.decode(response.body);
      if (dataAll['code'] == 200) {
        return json.decode(response.body);
      } else {
        isErrorMessageShow
            ? Utils.errorSnackBar(
                dataAll['message'], navigatorKey.currentContext)
            : null;
      }
      return null;
    } else if (response.statusCode == 401) {
      var dataAll = json.decode(response.body);
      // SessionManager.unauthorizedUser(navigatorKey.currentState!.context);
      isErrorMessageShow
          ? Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext)
          : null;
      return null;
    } else {
      var dataAll = json.decode(response.body);
      isErrorMessageShow
          ? Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext)
          : null;
      return null;
    }
  }
}
