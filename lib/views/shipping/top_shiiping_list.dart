import 'package:flutter/material.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/shipping/animated_shipping_list.dart';

class TopShippingList extends StatelessWidget {
  const TopShippingList({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.formKey,
  });

  final int currentIndex;
  final GlobalKey<FormState> formKey;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(shippingList().length, (index) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              onTap(index);
            },
            child: AnimatedShippingList(
              currentIndex: currentIndex,
              index: (index + 1).toString(),
              title: shippingList()[index],
              isactive: true,
            ),
          ),
        );
      }),
    );
  }
}

class InActiveItem extends StatelessWidget {
  const InActiveItem({super.key, required this.title, required this.index});

  final String title, index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Color(0xffF2F3F3),
          child: Text(index),
        ),

        SizedBox(width: 6),
        Text(
          title,
          style: TextStyles.semiBold13.copyWith(color: Color(0xffAAAAAA)),
        ),
      ],
    );
  }
}

class ActiveItem extends StatelessWidget {
  const ActiveItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.check, color: AppColors.mainWhite),
        ),
        SizedBox(width: 6),
        Text(
          title,
          style: TextStyles.bold13.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }
}

List<String> shippingList() {
  return ['الشحن', 'العنوان', 'الدفع'];
}
