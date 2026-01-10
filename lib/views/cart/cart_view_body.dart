import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/custom_widgets/custom_button.dart';
import 'package:fruits/custom_widgets/custom_cart_item_list.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cart_item_cubit/cart_item_cubit.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/products/products_app_bar.dart';
import 'package:fruits/views/shipping/shipping_view.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CustomAppBar(
                    actionButton: false,
                    arrowBack: false,
                    title: 'السلة',
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration( color: context.read<CartCubit>().isDarkMode
                        ? Color(0xff191919)
                        : Color(0xffebf9f1)),



                    child: Center(
                      child: Text(
                        'لديك ${context
                            .watch<CartCubit>()
                            .cartListEntity
                            .items
                            .length} منتجات في سله التسوق',
                        style: TextStyles.semiBold16.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: context
                  .watch<CartCubit>()
                  .cartListEntity
                  .items
                  .isEmpty
                  ? SizedBox()
                  : Divider(height: 1),
            ),
            CustomCartItemList(
              cartListEntity: context
                  .watch<CartCubit>()
                  .cartListEntity,
            ),
            SliverToBoxAdapter(
              child: context
                  .watch<CartCubit>()
                  .cartListEntity
                  .items
                  .isEmpty
                  ? SizedBox()
                  : Divider(height: 1),
            ),
          ],
        ),
        Positioned(
          bottom: MediaQuery
              .sizeOf(context)
              .height * 0.06,
          left: 0,
          right: 0,

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocBuilder<CartItemCubit, CartItemState>(
              builder: (context, state) {
                return CustomButton(
                  onPressed: () {
                    if (context
                        .read<CartCubit>()
                        .cartListEntity
                        .items
                        .isNotEmpty) {
                      Navigator.pushNamed(context, ShippingView.routeName,arguments:
                      context
                          .read<CartCubit>()
                          .cartListEntity

                          );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("لا يوجد منتجات في السلة"),duration: Duration(seconds: 2),),
                      );
                    }

                  },

                  text:
                  'الدفع  ${context
                      .watch<CartCubit>()
                      .cartListEntity
                      .calculateTotalPrice()} جنيه',
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
