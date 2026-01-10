import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits/core/models/product_model.dart';
import 'package:fruits/custom_widgets/custom_button.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/helper/show_scaffoldBar.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/products/product_review.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductModel product;


  const ProductDetailsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<CartCubit>().isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.mainBlack : AppColors.mainWhite,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark? Color(0xff191919) : Colors.white,
                ),),),
                Positioned(
                  top: 60,
                  right: 30,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                        backgroundColor: isDark? Color(0xff191919) : Colors.white,
                        child: Icon(Icons.arrow_back_ios_new_outlined,color: isDark? Colors.white : Colors.black,)),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 100),
                    Center(
                      child: product.imageUrl != null
                          ? Image.network(
                              product.imageUrl!,
                              height: 220,
                              fit: BoxFit.contain,
                            )
                          : const Icon(Icons.image, size: 150),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      product.name,
                      style: TextStyles.bold19.copyWith(
                        color: isDark
                            ? AppColors.mainWhite
                            : AppColors.mainBlack,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,

                    subtitle: Text(
                      '${product.price} جنيه / الكيلو',
                      style: TextStyles.bold16.copyWith(
                        color: AppColors.darkOrange,
                      ),
                    ),
                  ),


                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/star.svg',
                      ),
                      const SizedBox(width: 10  ),
                      Text('4.8',style: TextStyles.semiBold16.copyWith(
                        color: isDark
                            ? AppColors.mainWhite
                            : AppColors.mainBlack,

                      ),),
                      const SizedBox(width: 10),
                      Text('(30+)',style: TextStyles.semiBold16.copyWith(
                        color: Colors.grey,
                      ),),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ProductReview.routeName);
                        },
                        child: Text(
                          'المراجعه',
                          style: TextStyles.bold16.copyWith(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary,
                            decorationThickness: 1.5,
                          ),
                          ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    product.description,
                    style: TextStyles.semiBold16.copyWith(
                      color: isDark ? AppColors.mainWhite : AppColors.mainBlack,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(.7),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${product.expirationsMonths.toString()}شهر ',
                                    style: TextStyles.bold19.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    'الصلاحيه',
                                    style: TextStyles.regular16.copyWith(
                                      color:
                                          context.read<CartCubit>().isDarkMode
                                          ? AppColors.mainWhite
                                          : AppColors.mainBlack,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Center(
                                child: SvgPicture.asset(
                                  'assets/images/calender.svg',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(.7),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '100%',
                                    style: TextStyles.bold19.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    'اوجانيك',
                                    style: TextStyles.regular16.copyWith(
                                      color:
                                          context.read<CartCubit>().isDarkMode
                                          ? AppColors.mainWhite
                                          : AppColors.mainBlack,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),

                              Center(
                                child: SvgPicture.asset(
                                  'assets/images/organic.svg',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(.7),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${product.numberOfCalories.toString()}كالوري ',
                                    style: TextStyles.bold19.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    '${product.numberOfCalories.toString()} جرام ',
                                    style: TextStyles.regular16.copyWith(
                                      color:
                                          context.read<CartCubit>().isDarkMode
                                          ? AppColors.mainWhite
                                          : AppColors.mainBlack,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Center(
                                child: SvgPicture.asset(
                                  'assets/images/calory.svg',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(.7),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '4.8',
                                    style: TextStyles.bold19.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    'Reviews  ',
                                    style: TextStyles.regular16.copyWith(
                                      color:
                                          context.read<CartCubit>().isDarkMode
                                          ? AppColors.mainWhite
                                          : AppColors.mainBlack,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),

                              Center(
                                child: SvgPicture.asset(
                                  'assets/images/star.svg',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: CustomButton(
            onPressed: () {
              context.read<CartCubit>().addItem(product.toEntity());
              showScaffoldBar(context, 'تمت اضافه المنج الي السله بنجاح');
            },
            text: 'أضف إلى السلة',
          ),
        ),
      ),
    );
  }
}
