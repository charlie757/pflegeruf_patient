import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static late final SharedPreferences sharedPrefs;
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  Future<void> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  // static bool get isFirstTime => _sharedPrefs.getBool(Constants.IS_FIRST_TIME) ?? false;
  // static set isFirstTime(bool value) {
  //   _sharedPrefs.setBool(Constants.IS_FIRST_TIME, value);
  // }

  // static String get token => _sharedPrefs.getString(Constants.TOKEN) ?? "";
  // static set token(String value) {
  //   _sharedPrefs.setString(Constants.TOKEN, value);
  // }
}
