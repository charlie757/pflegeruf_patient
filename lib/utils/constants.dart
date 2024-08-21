// ignore_for_file: non_constant_identifier_names

import 'package:patient/model/language_model.dart';

class Constants {
  static String FIRST_TIME_OPEN_APP = 'FIRST_TIME_OPEN_APP';
  static String TOKEN = 'token';
  static String KEEP_ME_SIGNED_IN = 'KEEP_ME_SIGNED_IN';
  static String EMAIL_ID = 'EMAIL_ID';
  static String PASSWORD = 'PASSWORD';
  static String LAT = "LAT";
  static String LNG = 'LNG';
  static String FCM_TOKEN = 'FCM_TOKEN';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: '',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: '',
        languageName: 'German',
        countryCode: 'DE',
        languageCode: 'de'),
    // LanguageModel(
    //     imageUrl: '',
    //     languageName: 'Arabic',
    //     countryCode: 'SA',
    //     languageCode: 'ar'),
  ];
}
