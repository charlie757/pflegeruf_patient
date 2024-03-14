import 'package:flutter/material.dart';
import 'package:patient/config/approutes.dart';
import 'package:patient/helper/appimages.dart';
import 'package:patient/screens/onboarding_screen.dart';

class SplashSCreen extends StatefulWidget {
  const SplashSCreen({super.key});

  @override
  State<SplashSCreen> createState() => _SplashSCreenState();
}

class _SplashSCreenState extends State<SplashSCreen> {
  @override
  void initState() {
    callNavigate();
    super.initState();
  }

  callNavigate() {
    Future.delayed(const Duration(seconds: 3), () {
      AppRoutes.pushReplacementNavigation(const OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImages.appLogo),
      ),
    );
  }
}
