class ApiUrl {
  static String baseUrl = 'https://forthprodigital.in/demo/caringapp/Api/';
  static String pagesBaseUrl = 'https://pflegeruf.app/pages/';
  static String loginUrl = '${baseUrl}user/login';
  static String signUpUrl = '${baseUrl}user/signup';
  static String signUpResendUrl = '${baseUrl}user/resend-signup-code';
  static String forgotPasswordUrl = '${baseUrl}user/forgotpassword';
  static String forgotVerificationUrl = '${baseUrl}user/forget-verification';
  static String setNewPasswordUrl = '${baseUrl}user/set-new-password';
  static String signupVerifiactionUrl = '${baseUrl}user/signup-verification';
  static String homeUrl = '${baseUrl}home';
  static String profileDetailsUrl = '${baseUrl}profile/details';
  static String profileUpdateUrl = '${baseUrl}profile/update-profile';
  static String profilePhotoUrl = '${baseUrl}profile/update-photo';
  static String deleteAccountUrl = '${baseUrl}profile/delete-account';
  static String getServiceCategoryUrl = '${baseUrl}Category';
  static String nurseBookingUrl = '${baseUrl}Mylisting/create';
  static String bookingListUrl = '${baseUrl}Mylisting';
  static String bookingDetailsUrl = '${baseUrl}Mylisting/booking-detail';
  static String addRatingUrl = '${baseUrl}rating/add-rating';
  static String notificationurl = '${baseUrl}notification';
  static String readNotificationurl =
      '${baseUrl}Notification/read-notification';
  static String unreadNotificationCountUrl =
      '${baseUrl}notification/notification-unread-count';
  static String completedBookingListUrl =
      '${baseUrl}Mylisting/booking-list-completed-patient';
  static String logoutUrl = '${baseUrl}User/logout';
  static String privacyPolicyUrl = '${pagesBaseUrl}privacy-policy';
  static String termsConditionUrl = '${pagesBaseUrl}terms-and-conditions';
}
