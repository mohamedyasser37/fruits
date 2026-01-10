import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits/core/entities/product_entity.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

class FeaturedItem extends StatelessWidget {
  const FeaturedItem({super.key, });


  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width - 48;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: itemWidth,
        child: AspectRatio(
          aspectRatio: 342 / 158,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                right: itemWidth * 0.5,
                child: SvgPicture.asset(
                  'assets/images/page_view_item1_image.svg',
                  fit: BoxFit.fill,
                ),
              ),

              Positioned(
                left: itemWidth * 0.5,
                right: 0,
                top: 0,
                bottom: 0,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SvgPicture.asset(
                        'assets/images/featured_item_background.svg', // من الكود الأول
                        fit: BoxFit.cover,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'عروض العيد',
                                  style: TextStyles.regular13.copyWith(
                                    color: context.watch<CartCubit>().isDarkMode? AppColors.mainBlack: AppColors.mainWhite,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'خصم 25%',
                                  style: TextStyles.bold19.copyWith(
                                    color: AppColors.mainColor,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.mainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'تسوق الآن',
                                    style: TextStyles.bold13.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
