import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits/cart_entities/cart_item_entity.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cart_item_cubit/cart_item_cubit.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({super.key, required this.cartItemEntity});

  final CartItemEntity cartItemEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartItemCubit, CartItemState>(
      buildWhen: (previous, current) {
        if (current is CartItemUpdated) {
          return current.cartItemEntity == cartItemEntity;
        }
        return false;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة المنتج
              Container(
                padding: const EdgeInsets.all(2),
                width: 73,
                height: 92,
                decoration: BoxDecoration(
                  color: context.watch<CartCubit>().isDarkMode
                      ? const Color(0xff191919)
                      : const Color(0xffebf9f1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.network(
                  '${cartItemEntity.product.imageUrl}',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم المنتج وحذف
                    Row(
                      children: [
                        Text(
                          cartItemEntity.product.name,
                          style: TextStyles.bold13.copyWith(
                            color: context.watch<CartCubit>().isDarkMode
                                ? AppColors.mainWhite
                                : AppColors.mainBlack,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            context
                                .read<CartCubit>()
                                .removeProduct(cartItemEntity.product);
                          },
                          borderRadius: BorderRadius.circular(22),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: SvgPicture.asset(
                              'assets/images/trash.svg',
                              width: 22,
                              height: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${cartItemEntity.calculateTotalWeight()} كج',
                      style: TextStyles.regular13.copyWith(
                        color: const Color(0xffF4A91F),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<CartCubit>()
                                .increaseItem(cartItemEntity.product);
                            context
                                .read<CartItemCubit>()
                                .updateCartItem(cartItemEntity);
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.add,
                              size: 24,
                              color: AppColors.mainWhite,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '${cartItemEntity.count}',
                            style: TextStyles.bold19.copyWith(
                              color: context.read<CartCubit>().isDarkMode
                                  ? AppColors.mainWhite
                                  : AppColors.mainBlack,
                            ),
                          ),
                        ),
                        // نقص
                        InkWell(
                          onTap: () {
                            context
                                .read<CartCubit>()
                                .decreaseItem(cartItemEntity.product);
                            context
                                .read<CartItemCubit>()
                                .updateCartItem(cartItemEntity);
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: Color(0xff1f1f1f),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child:  Icon(
                              Icons.remove,
                              size: 24,
                              color: AppColors.mainWhite,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${cartItemEntity.getSubTotal()} جنيه',
                          style: TextStyles.bold16.copyWith(
                            color: const Color(0xffF4A91F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
