import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits/auth/signin/signin_view.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/helper/constants.dart';
import 'package:fruits/helper/shared_prefrence.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({
    super.key,
    required this.onBoardingImage,
    required this.onBoardingTitle,
    required this.onBoardingSubTitle,
    required this.onBoardingBackgound,
    this.showSkip = false,
  });

  final String onBoardingImage, onBoardingBackgound, onBoardingSubTitle;
  final Widget onBoardingTitle;
  final bool showSkip;

  //final Widget onBoardingButton;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(onBoardingBackgound, fit: BoxFit.fill),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SvgPicture.asset(onBoardingImage),
              ),

              Visibility(
                visible: showSkip,
                child: GestureDetector(
                  onTap: () {
                    Prefs.setBool(kOnboardinIsSeen, true);
                    Navigator.pushReplacementNamed(
                      context,
                      SignInView.routeName,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 58.0,
                      horizontal: 24,
                    ),
                    child: Text("تخط", style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        onBoardingTitle,
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            onBoardingSubTitle,
            style: TextStyles.regular16.copyWith(color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
