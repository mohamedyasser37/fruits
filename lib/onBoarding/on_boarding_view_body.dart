import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fruits/auth/signin/signin_view.dart';
import 'package:fruits/custom_widgets/custom_button.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/constants.dart';
import 'package:fruits/helper/shared_prefrence.dart';
import 'package:fruits/onBoarding/on_boarding_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  var currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState

    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: OnBoardingPageView(pageController: pageController)),
        DotsIndicator(
          dotsCount: 2,
          position: currentPage.toDouble(),
          decorator: DotsDecorator(
            spacing: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            activeColor: AppColors.primary,
            color: currentPage == 0
                ? AppColors.primary.withOpacity(0.5)
                : AppColors.primary,
            size: const Size(12, 12),
            activeSize: const Size(12, 12),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),

        const SizedBox(height: 20),
        Visibility(
          visible: currentPage == 1,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              onPressed: () {
                Prefs.setBool(kOnboardinIsSeen, true);
                Navigator.pushReplacementNamed(context, SignInView.routeName);
              },
              text: 'ابدأ الان',
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
