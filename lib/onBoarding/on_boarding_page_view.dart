import 'package:flutter/material.dart';
import 'package:fruits/custom_widgets/custom_page_view.dart';
import 'package:fruits/helper/app_text_styles.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return  PageView(
      controller: pageController,

      children: [
        CustomPageView(
          showSkip: (pageController.hasClients ? pageController.page!.toInt() : 0) == 0,
            onBoardingBackgound: "assets/images/onboarding_background1.svg",
            onBoardingImage: "assets/images/onboarding_image1.svg",
            onBoardingTitle: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(

                style: TextStyles.bold28,
                children: [
                  TextSpan(text: "مرحبًا بك في "),
                  TextSpan(text: "Fruit", style: TextStyle(color: Colors.green)),
                  TextSpan(text: "HUB", style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),
            onBoardingSubTitle: "اكتشف تجربة تسوق فريدة مع FruitHUB. استكشف مجموعتنا الواسعة من الفواكه الطازجة الممتازة واحصل على أفضل العروض والجودة العالية.",
           ),
        CustomPageView(
          showSkip: false,
          onBoardingBackgound: "assets/images/onboarding_background2.svg",
          onBoardingImage: "assets/images/onboarding_image2.svg",
          onBoardingTitle:Text('ابحث وتسوق', style: TextStyles.bold23.copyWith(color: Colors.black),),
          onBoardingSubTitle: "نقدم لك أفضل الفواكه المختارة بعناية. اطلع على التفاصيل والصور والتقييمات لتتأكد من اختيار الفاكهة المثالية",
        ),



      ],
    );
  }
}
