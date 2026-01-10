import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/cubit/get_products_cubit.dart';
import 'package:fruits/helper/get_it.dart';
import 'package:fruits/repos/product_repo.dart';
import 'package:fruits/views/products/products_view_body.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetProductsCubit(
        getIt<ProductRepo>(),
      ),
      child: ProductsViewBody(
      ),
    );
  }
}
