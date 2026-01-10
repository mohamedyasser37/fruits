import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';

class CustomHomeOfferItem extends StatelessWidget {
  const CustomHomeOfferItem({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: double.infinity,
        height: 158,
        child: Stack(
          children: [
            // الخلفية
            SvgPicture.asset(
              'assets/images/featured_item_background.svg',
              fit: BoxFit.cover,
            ),

            // صورة المنتج
            Positioned.fill(
              right: screenWidth * 0.5,
              child: SvgPicture.asset(
                'assets/images/page_view_item1_image.svg',
                fit: BoxFit.fill,
              ),
            ),

            // المحتوى
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'عروض العيد',
                    style: TextStyles.regular13.copyWith(
                      color: AppColors.mainWhite,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'خصم 25%',
                    style: TextStyles.bold19.copyWith(
                      color: AppColors.mainWhite,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainWhite,
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
    );
  }
}
