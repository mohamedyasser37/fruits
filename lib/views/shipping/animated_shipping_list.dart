import 'package:flutter/material.dart';
import 'package:fruits/views/shipping/top_shiiping_list.dart';

class AnimatedShippingList extends StatelessWidget {
  const AnimatedShippingList({
    super.key,
    required this.title,
    required this.index,
    required this.isactive, required this.currentIndex,
  });

  final String title, index;
  final bool isactive;
  final int currentIndex;


  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: InActiveItem(title: title, index: index),
      secondChild: ActiveItem(title: title),
      crossFadeState: currentIndex+1 >= int.parse(index)
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: Duration(milliseconds: 300),
    );
  }
}
