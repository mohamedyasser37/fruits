import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits/auth/services/firebase_auth_service.dart';
import 'package:fruits/auth/signin/signin_view.dart';
import 'package:fruits/helper/constants.dart';
import 'package:fruits/helper/shared_prefrence.dart';
import 'package:fruits/onBoarding/on_boarding_view.dart';
import 'package:fruits/views/main_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  static const String routeName = 'splash';

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  initState() {
    super.initState();
    excuteNaviagtion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment:
                Localizations.localeOf(context).languageCode == 'ar'
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [SvgPicture.asset("assets/images/planet.svg")],
          ),
          SvgPicture.asset("assets/images/logo.svg"),
          SvgPicture.asset("assets/images/splash_bottom.svg", fit: BoxFit.fill),
        ],
      ),
    );
  }
  void excuteNaviagtion() {
    bool isOnBoardingViewSeen = Prefs.getBool(kOnboardinIsSeen);
    Future.delayed(const Duration(seconds: 1), () {
      if (isOnBoardingViewSeen) {
        var isLoggedIn = FirebaseAuthService().isLoggedIn();

        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, MainView.routeName);
        } else {
          Navigator.pushReplacementNamed(context, SignInView.routeName);
        }
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      }
    });
  }
}
