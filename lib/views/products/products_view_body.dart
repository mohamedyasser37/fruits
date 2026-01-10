import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/cubit/get_products_cubit.dart';
import 'package:fruits/custom_widgets/best_seller_grid_bloc_consumer.dart';
import 'package:fruits/custom_widgets/custom_home_search.dart';
import 'package:fruits/custom_widgets/home_app_bar.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/home/search_view.dart';
import 'package:fruits/views/products/products_app_bar.dart';

class ProductsViewBody extends StatefulWidget {
  const ProductsViewBody({super.key});

  @override
  State<ProductsViewBody> createState() => _ProductsViewBodyState();
}

class _ProductsViewBodyState extends State<ProductsViewBody> {
  @override
  void initState() {
    context.read<GetProductsCubit>().getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                CustomAppBar(
                  title: 'المنتجات',
                  arrowBack: false,
                  actionButton: true,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<GetProductsCubit>(),
                            child: const SearchView(),
                          ),
                        ),
                      );
                    },
                    child: CustomHomeSearch(
                      isEnable: false,
                    )),
                const SizedBox(height: 12),
                ProductsViewHeader(productsCount: context.read<GetProductsCubit>().length),
                const SizedBox(height: 12),
                BestSellerGridBlocConsumer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductsViewHeader extends StatelessWidget {
  const ProductsViewHeader({
    super.key, required this.productsCount,
  });
  final int productsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'نتائج$productsCount',
          style: TextStyles.bold16.copyWith(
            color: AppColors.mainBlack,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text('المزيد', style: TextStyles.regular13),
        ),
      ],
    );
  }
}
