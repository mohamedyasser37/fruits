import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/custom_widgets/custom_home_search.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/cubit/get_products_cubit.dart';
import 'package:fruits/custom_widgets/custom_best_seller_item.dart';
import 'package:fruits/core/models/product_model.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});
  static const String routeName = 'searchView';

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController controller = TextEditingController();
  List<ProductModel> filteredProducts = [];
  @override
  void initState() {
    super.initState();
    final cubit = context.read<GetProductsCubit>();
    if (cubit.state is GetProductsSuccess) {
      filteredProducts = (cubit.state as GetProductsSuccess).products;
    }
  }

  void _filterProducts(String query, List<ProductModel> allProducts) {
    setState(() {
      filteredProducts = allProducts
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<CartCubit>().isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.mainBlack : AppColors.mainWhite,
      appBar: AppBar(
        title: Text(
          'البحث عن منتج',
          style: TextStyles.bold19
              .copyWith(color: isDark ? AppColors.mainWhite : AppColors.mainBlack),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: isDark ? AppColors.mainBlack : AppColors.mainWhite,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: isDark ? AppColors.mainWhite : AppColors.mainBlack,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextFormField(
              style: TextStyles.regular16.copyWith(color: context.read<CartCubit>().isDarkMode? AppColors.mainWhite: AppColors.mainBlack),
              //autofocus: true,
              controller: controller,
              onChanged: (value) {
                final cubit = context.read<GetProductsCubit>();
                if (cubit.state is GetProductsSuccess) {
                  _filterProducts(
                      value, (cubit.state as GetProductsSuccess).products);
                }
              },
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                isDense: true,

                fillColor: isDark ? AppColors.grey.withOpacity(0.1) : Colors.white,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                hintText: 'ابحث عن منتج...',
                hintStyle: TextStyles.regular16.copyWith(color: const Color(0xff949D9E)),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<GetProductsCubit, GetProductsState>(
                builder: (context, state) {
                  if (state is GetProductsSuccess) {
                    final productsToShow = controller.text.isEmpty
                        ? state.products
                        : filteredProducts;

                    if (productsToShow.isEmpty) {
                      return Center(
                        child: Image.asset('assets/images/filter_results.png')
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: productsToShow.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 163 / 214,
                      ),
                      itemBuilder: (context, index) {
                        return CustomBestSellerItem(product: productsToShow[index]);
                      },
                    );
                  } else if (state is GetProductsError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
