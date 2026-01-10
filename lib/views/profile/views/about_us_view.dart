import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  static const String routeName = 'aboutUsView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context
          .read<CartCubit>()
          .isDarkMode
          ? AppColors.mainBlack
          : AppColors.mainWhite,
      appBar: AppBar(
        title: Text(
          '''🍎من نحن''',
          style: TextStyles.bold19.copyWith(
            color: context
                .read<CartCubit>()
                .isDarkMode
                ? AppColors.mainWhite
                : AppColors.mainBlack,
          ),
        ),
        centerTitle: true,
        elevation: 5,
        backgroundColor: context
            .read<CartCubit>()
            .isDarkMode
            ? AppColors.mainBlack
            : AppColors.mainWhite,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: context
                .read<CartCubit>()
                .isDarkMode
                ? AppColors.mainWhite
                : AppColors.mainBlack,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [

            SizedBox(
              height: 16,
            ),
            Text(
                ''' 

نحن تطبيق متخصص في توفير أجود أنواع الفواكه الطازجة بأفضل الأسعار، مع تجربة استخدام سهلة وسريعة تناسب جميع احتياجاتك اليومية.

نسعى إلى تقديم فواكه مختارة بعناية من أفضل الموردين، لضمان الجودة، الطزاجة، والنكهة الطبيعية في كل طلب.

هدفنا هو تسهيل عملية التسوق وجعلها أكثر راحة وأمانًا، مع توصيل سريع وخدمة موثوقة.

نؤمن بأن الغذاء الصحي هو أساس الحياة الصحية، ولذلك نعمل دائمًا على تطوير خدماتنا لتلبية توقعاتك وتقديم الأفضل لك ولعائلتك.

💚 اختيارك لنا هو اختيار للجودة، الطزاجة، والراحة.
''',
                textAlign: TextAlign.start,
                style: TextStyles.semiBold16.copyWith(
                  // overflow: TextOverflow.ellipsis,
                  height:1.7,
                  color: context
                      .read<CartCubit>()
                      .isDarkMode
                      ? AppColors.mainWhite
                      : AppColors.mainBlack,
                )
            ),
          ],
        ),
      ),
    );
  }
}
