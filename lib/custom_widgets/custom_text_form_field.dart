import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.hintText,
    this.onSaved = null,
    required this.suffixIcon,
    required this.keyboardType,
    this.isObscure = false,
    this.controller,
    this.fillColor = Colors.white,
    this.hintColor = Colors.grey, this.style,
  });

  final Color fillColor, hintColor;
  final String hintText;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final bool isObscure;
  final TextEditingController? controller;
  void Function(String?)? onSaved;
  final TextStyle? style;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      controller: widget.controller,
      obscureText: widget.isObscure,
      validator: (value) {
        if (value!.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      keyboardType: widget.keyboardType,
      style:widget.style ?? TextStyles.regular16.copyWith(
        color: context.read<CartCubit>().isDarkMode
            ? AppColors.mainWhite
            : AppColors.mainBlack,
      ),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        filled: true,
        hintStyle: TextStyle(color: widget.hintColor),
        suffixIcon: widget.suffixIcon,
        fillColor: widget.fillColor,

        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffE6E9EA)),
        ),
      ),
    );
  }
}
