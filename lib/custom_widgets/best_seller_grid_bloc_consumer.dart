import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/cubit/get_products_cubit.dart';
import 'package:fruits/custom_widgets/best_seller_grid.dart';
import 'package:fruits/custom_widgets/get_dummy_product.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestSellerGridBlocConsumer extends StatelessWidget {
  const BestSellerGridBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsCubit, GetProductsState>(
      builder: (context, state) {
        if (state is GetProductsSuccess) {
          return BestSellerGrid(products: state.products);
        } else if (state is GetProductsError) {
          return Center(child: Text(state.message));
        } else {
          return Skeletonizer(
            enabled: true,
            child: BestSellerGrid(products: getDummyProducts()),
          );
        }
      },
    );
  }
}
