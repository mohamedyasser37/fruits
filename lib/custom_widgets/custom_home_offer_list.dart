import 'package:flutter/material.dart';
import 'package:fruits/custom_widgets/custom_home_offer_item.dart';
import 'package:fruits/custom_widgets/featured_item.dart';

class CustomHomeOfferList extends StatelessWidget {
  const CustomHomeOfferList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: FeaturedItem(),
          );
        }),
      ),
    );
  }}
