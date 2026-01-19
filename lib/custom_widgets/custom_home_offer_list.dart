import 'package:flutter/material.dart';


import 'package:carousel_slider/carousel_slider.dart';
import 'featured_item.dart';

class CustomHomeOfferList extends StatelessWidget {
   CustomHomeOfferList({super.key});
  List<String> images = [
    'assets/images/mango.png',
    'assets/images/freepik--fruit-basket.png',
    'assets/images/pineapple.png',
    'assets/images/watermelon.png',
    'assets/images/Avocado.png'

  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: const EdgeInsets.only(left: 8),
          child: FeaturedItem(
            imageUrl: images[index],
          ),
        );
      },
      options: CarouselOptions(
        height: 160,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enableInfiniteScroll: true,
        viewportFraction: 1,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}



