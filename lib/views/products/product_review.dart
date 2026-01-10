import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

class ProductReview extends StatelessWidget {
  const ProductReview({super.key});

  static const String routeName = 'productReview';

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
          'المراجعه',
          style: TextStyles.bold19.copyWith(
            color: context
                .read<CartCubit>()
                .isDarkMode
                ? AppColors.mainWhite
                : AppColors.mainBlack,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: context
            .watch<CartCubit>()
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: context
                      .read<CartCubit>()
                      .isDarkMode
                      ? Color(0xff1f1f1f)
                      : AppColors.mainWhite,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
          
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'اكتب التعليق..',
                  hintStyle: TextStyles.semiBold16,
                  prefixIcon: Image.asset('assets/images/review.png'),
                ),
              ),
              SizedBox(height: 16),
              Text(
                '324 مراجعه',
                style: TextStyles.bold16.copyWith(
                  color: context
                      .read<CartCubit>()
                      .isDarkMode
                      ? AppColors.mainWhite
                      : AppColors.mainBlack,
                ),
              ),
              SizedBox(height: 16),
          
              Center(
                child: Text(
                  'الملخص',
                  style: TextStyles.semiBold16.copyWith(
                    color: context
                        .read<CartCubit>()
                        .isDarkMode
                        ? AppColors.mainWhite
                        : AppColors.mainBlack,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/star.svg'),
                          SizedBox(width: 10),
                          Text('4.5', style: TextStyles.bold16.copyWith(
                            color: context
                                .read<CartCubit>()
                                .isDarkMode
                                ? AppColors.mainWhite
                                : AppColors.mainBlack,
          
                          ),),
          
          
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
          
                      Text('88%', style: TextStyles.bold16.copyWith(
                        color: context
                            .read<CartCubit>()
                            .isDarkMode
                            ? AppColors.mainWhite
                            : AppColors.mainBlack,
          
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('موصي بها', style: TextStyles.semiBold16.copyWith(
                        color: context
                            .read<CartCubit>()
                            .isDarkMode
                            ? AppColors.mainWhite
                            : AppColors.mainBlack,
                      ),),
          
                    ],
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    'assets/images/reviews_line.svg',
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 24),
          
          
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context
                      .read<CartCubit>()
                      .isDarkMode
                      ? Color(0xff1f1f1f)
                      : AppColors.mainWhite,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/preview1.png",
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
          
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name + Rating
                          Row(
                            children: [
                              Text(
                                "Ahmed Amr",
                                style: TextStyles.bold16.copyWith(
                                  color: context
                                      .read<CartCubit>()
                                      .isDarkMode
                                      ? AppColors.mainWhite
                                      : AppColors.mainBlack,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xffF4A91F),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.star,
                                        size: 14, color: Colors.white),
                                    const SizedBox(width: 3),
                                    Text(
                                      "4.8",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
          
                          const SizedBox(height: 4),
          
                          Text(
                            '20/08/2025',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
          
                          const SizedBox(height: 12),
          
                          Text(
                            'بصراحة الفواكه كانت فريش جدًا وطعمها مزبوط! التفاح كان مقرمش والمانجا مسكرة جدًا. عبّدوها في كرتونة محترمة ووصلت بسرعة. أكيد هكرر الطلب تاني 👌🍎🍑',
                            style: TextStyles.semiBold13.copyWith(
                              color: context
                                  .read<CartCubit>()
                                  .isDarkMode
                                  ? AppColors.mainWhite
                                  : AppColors.mainBlack,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
          
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context
                      .read<CartCubit>()
                      .isDarkMode
                      ? Color(0xff1f1f1f)
                      : AppColors.mainWhite,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/preview2.png",
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
          
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name + Rating
                          Row(
                            children: [
                              Text(
                                "Eslam Mousa",
                                style:  TextStyles.bold16.copyWith(
                                  color: context
                                      .read<CartCubit>()
                                      .isDarkMode
                                      ? AppColors.mainWhite
                                      : AppColors.mainBlack,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xffF4A91F),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.star,
                                        size: 14, color: Colors.white),
                                    const SizedBox(width: 3),
                                    Text(
                                      "4.6",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
          
                          const SizedBox(height: 4),
          
                          Text(
                            '22/01/2025',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
          
                          const SizedBox(height: 12),
          
                          Text(
                            'بصراحة جودة الفاكهة كانت أعلى من المتوقع! التوت والفراولة كانوا فريش جدًا وريحتم طالعة. التغليف محترم ومفيش أي ثمرة متعصرة أو بايظة. التجربة ممتازة وهطلب تاني بدون تفكير 👌🍓✨',
                            style: TextStyles.semiBold13.copyWith(
                              color: context
                                  .read<CartCubit>()
                                  .isDarkMode
                                  ? AppColors.mainWhite
                                  : AppColors.mainBlack,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
          
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context
                      .read<CartCubit>()
                      .isDarkMode
                      ? Color(0xff1f1f1f)
                      : AppColors.mainWhite,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/preview3.png",
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
          
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name + Rating
                          Row(
                            children: [
                              Text(
                                "Khaled Ahmed",
                                style:  TextStyles.bold16.copyWith(
                                  color: context
                                      .read<CartCubit>()
                                      .isDarkMode
                                      ? AppColors.mainWhite
                                      : AppColors.mainBlack,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xffF4A91F),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.star,
                                        size: 14, color: Colors.white),
                                    const SizedBox(width: 3),
                                    Text(
                                      "4.5",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
          
                          const SizedBox(height: 4),
          
                          Text(
                            '12/05/2025',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
          
                          const SizedBox(height: 12),
          
                          Text(
                            'جربت البرتقال والعنب وكان الطعم طبيعي وبدون سكر زيادة. المهم إنهم وصلوا باردين وحجمهم كبير. مقارنة بالسعر فالموضوع ممتاز جدًا 👏🍇🍊',
                            style: TextStyles.semiBold13.copyWith(
                              color: context
                                  .read<CartCubit>()
                                  .isDarkMode
                                  ? AppColors.mainWhite
                                  : AppColors.mainBlack,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          
            ],
          ),
        ),
      ),
    );
  }
}
