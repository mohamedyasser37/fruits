import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/cubit/get_products_cubit.dart';
import 'package:fruits/custom_widgets/best_seller_grid_bloc_consumer.dart';
import 'package:fruits/custom_widgets/custom_home_offer_list.dart';
import 'package:fruits/custom_widgets/custom_home_search.dart';
import 'package:fruits/custom_widgets/home_app_bar.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/home/search_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}



class _HomeViewBodyState extends State<HomeViewBody> {
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
                SizedBox(
                    child: HomeAppBar()),
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
                CustomHomeOfferList(),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الأكثر مبيعًا',
                      style: TextStyles.bold16.copyWith(
                        color:context.watch<CartCubit>().isDarkMode? AppColors.mainWhite: AppColors.mainBlack,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text('المزيد', style: TextStyles.regular13.copyWith(
                        color:context.read<CartCubit>().isDarkMode? AppColors.mainWhite: AppColors.mainBlack,
                      ),

                      ),
                    ),
                  ],
                ),
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
