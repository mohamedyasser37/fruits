import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/core/models/product_model.dart';
import 'package:fruits/custom_widgets/custom_best_seller_item.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/home/favourits_cubit/favourites_cubit.dart';

class PersonalFavourite extends StatelessWidget {
  const PersonalFavourite({super.key, });


  static const String routeName = 'personalFavourite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.read<CartCubit>().isDarkMode
          ? AppColors.mainBlack
          : AppColors.mainWhite,
      appBar:
      AppBar(
        title: Text(
          'المفضلة ❤️',
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




      body: BlocBuilder<FavoritesCubit, List<ProductModel>>(
        builder: (context, favorites) {
          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد منتجات مفضلة',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 163 / 214,
            ),
            itemBuilder: (context, index) {
              return CustomBestSellerItem(

                product: favorites[index],
              );
            },
          );
        },
      ),
    );
  }
}






