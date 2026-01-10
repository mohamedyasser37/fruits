import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

class CustomHomeSearch extends StatelessWidget {
  const CustomHomeSearch({
    super.key,
    this.isEnable = true,
    this.controller,
    this.onChanged,
  });

  final bool isEnable;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnable,
      controller: controller,
      onChanged: onChanged,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        isDense: true,
        fillColor: context.read<CartCubit>().isDarkMode
            ? AppColors.grey.withOpacity(0.1)
            : Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: 'ابحث عن منتج...',
        hintStyle:
        TextStyles.regular16.copyWith(color: const Color(0xff949D9E)),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.primary,
          size: 20,
        ),
      ),
    );
  }
}