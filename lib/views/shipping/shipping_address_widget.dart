import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/shipping/payment_item.dart';
import 'package:fruits/views/shipping/shipping%20_entites/order_entity.dart';


class ShippingAddressWidget extends StatelessWidget {
  const ShippingAddressWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;
  @override
  Widget build(BuildContext context) {

    return PaymentItem(
      tile: 'عنوان التوصيل',
      child: Row(
        children: [
         Icon(Icons.location_on_outlined,color: context.read<CartCubit>().isDarkMode? AppColors.mainWhite: Color(0xff4E5556),),
          const SizedBox(
            width: 8,
          ),
          Text(
            ' ${context.read<OrderEntity>().shippingAddress.address} , ${context.read<OrderEntity>().shippingAddress.city} ',
            textAlign: TextAlign.right,
            style: TextStyles.regular13.copyWith(
              color: context.watch<CartCubit>().isDarkMode? AppColors.mainWhite: Color(0xff4E5556),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.bounceIn);
            },
            child: SizedBox(
              child: Row(
                children: [
                  Icon(Icons.edit,color: context.read<CartCubit>().isDarkMode? AppColors.mainWhite: Color(0xff4E5556),),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'تعديل',
                    style: TextStyles.semiBold13.copyWith(
                      color: context.read<CartCubit>().isDarkMode? AppColors.mainWhite: Color(0xff4E5556),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
