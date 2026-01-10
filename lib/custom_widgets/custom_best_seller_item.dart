import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/cart_entities/cart_item_entity.dart';
import 'package:fruits/core/entities/product_entity.dart';
import 'package:fruits/core/models/product_model.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/helper/show_scaffoldBar.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/home/favourits_cubit/favourites_cubit.dart';
import 'package:fruits/views/products/product_details.dart';

class CustomBestSellerItem extends StatelessWidget {
  final ProductModel product;

  const CustomBestSellerItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<CartCubit>().isDarkMode;

    return AspectRatio(
      aspectRatio: 163 / 214,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailsView(product: product),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? Color(0xff171717) : AppColors.mainWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: product.imageUrl != null
                              ? Image.network(
                                  product.imageUrl!,
                                  fit: BoxFit.contain,
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  maxRadius: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 8,
                      right: 6,
                      child: BlocBuilder<FavoritesCubit, List<ProductModel>>(
                        builder: (context, favorites) {
                          final isFav = context
                              .read<FavoritesCubit>()
                              .isFavorite(product);
                          return GestureDetector(
                            onTap: () {
                              context.read<FavoritesCubit>().toggleFavorite(
                                product,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(
                                  0.9,
                                ), // خلفية شبه شفافة
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: isFav ? Colors.red : Colors.black,
                                size: 26,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.semiBold16.copyWith(
                                color: isDark
                                    ? AppColors.mainWhite
                                    : AppColors.mainBlack,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  '${product.price} جنيه / الكيلو',
                                  style: TextStyles.bold13.copyWith(
                                    color: AppColors.darkOrange,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    final cartCubit = context.read<CartCubit>();

                                    if (cartCubit.isInCart(
                                      product.toEntity(),
                                    )) {
                                      cartCubit.removeProduct(
                                        product.toEntity(),

                                      );
                                      showScaffoldBar(
                                        context,
                                        'تم حذف المنتج من السله بنجاح',
                                      );
                                    } else {
                                      cartCubit.addItem(product.toEntity());
                                      showScaffoldBar(
                                        context,
                                        'تمت اضافه المنتج الي السله بنجاح',
                                      );
                                    }
                                  },
                                  child: BlocBuilder<CartCubit, CartState>(
                                    builder: (context, state) {
                                      final isInCart = context
                                          .read<CartCubit>()
                                          .isInCart(product.toEntity());

                                      return Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: isInCart
                                              ? Colors.green
                                              : AppColors.primary,
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                        ),
                                        child: Icon(
                                          isInCart ? Icons.check : Icons.add,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
