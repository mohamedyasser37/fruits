  import 'package:flutter/material.dart';
  import 'package:fruits/core/entities/product_entity.dart';
  import 'package:fruits/core/models/product_model.dart';
  import 'package:fruits/custom_widgets/custom_best_seller_item.dart';

  class BestSellerGrid extends StatelessWidget {
    final List<ProductModel> products;

    const BestSellerGrid({super.key, required this.products});

    @override
    Widget build(BuildContext context) {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 163 / 214,
        ),
        itemBuilder: (context, index) {
          return CustomBestSellerItem(product: products[index]);
        },
      );
    }
  }
