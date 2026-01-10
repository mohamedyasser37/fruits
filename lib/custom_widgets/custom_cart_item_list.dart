import 'package:flutter/material.dart';
import 'package:fruits/cart_entities/cart_list_entity.dart';
import 'package:fruits/custom_widgets/custom_cart_item.dart';

class CustomCartItemList extends StatelessWidget {
  const CustomCartItemList({super.key, required this.cartListEntity});

  final CartListEntity cartListEntity;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
          );
        },
      itemCount: cartListEntity.items.length,
        itemBuilder:(context, index) {
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCartItem(cartItemEntity: cartListEntity.items[index]),
          );
        },);
  }
}
