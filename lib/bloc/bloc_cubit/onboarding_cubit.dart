// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:patient/bloc/bloc_state/onboarding_state.dart';
// import 'package:patient/helper/appimages.dart';
// import 'package:patient/languages/string_key.dart';

// class OnboardingCubit extends Cubit<OnboardingState> {
//   OnboardingCubit()
//       : super(OnboardingState(onboardingList: [], title: '', subTitle: ''));

//   final onboardingList = [
//     {
//       'img': AppImages.onboarding1Image,
//       'title': StringKey.findYourNurse,
//       'subTitle':
//           'Lorem Ipsum is simply dummy text of the printing and for typesetting industry. '
//     },
//     {
//       'img': AppImages.onboarding2Image,
//       'title': StringKey.chooseBestNurse,
//       'subTitle':
//           'Lorem Ipsum is simply dummy text of the printing and for typesetting industry. '
//     },
//     {
//       'img': AppImages.onboarding3Image,
//       'title': StringKey.smartBookingSystem,
//       'subTitle':
//           'Lorem Ipsum is simply dummy text of the printing and for typesetting industry. '
//     },
//   ];

//   int currentIndex = 0;
//   String title = '';
//   String subTitle = '';

//   void loadOnboardingData() {
//     emit(OnboardingState(
//         onboardingList: onboardingList, title: title, subTitle: subTitle));
//   }

//   update(index) {
//     // emit(LoginChangePasswordVisibilityLoadingState());
//     print(index);
//     // edit = !edit;
//     // suffixIcon =
//     //     isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
//     // emit(LoginChangePasswordVisibilitySuccessState());
//   }
// }
