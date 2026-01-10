import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/custom_widgets/custom_text_form_field.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/shipping/shipping%20_entites/order_entity.dart';

class ShippingAddressSection extends StatelessWidget {
  ShippingAddressSection({
    super.key,
    required this.formKey,
    required this.valueListenable,
  });

  final GlobalKey<FormState> formKey;

  final ValueListenable<AutovalidateMode> valueListenable;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (context, value, child) {
        return Form(
          key: formKey,
          autovalidateMode: value,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  fillColor: context.watch<CartCubit>().isDarkMode
            ? AppColors.grey.withOpacity(0.1) : Colors.white,
                  onSaved: (value) {
                    context.read<OrderEntity>().shippingAddress.name = value;
                  },
            
                  hintText: 'الاسم كامل',
                  suffixIcon: SizedBox(),
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  fillColor: context.read<CartCubit>().isDarkMode
                      ? AppColors.grey.withOpacity(0.1) : Colors.white,
                  onSaved: (value) {
                    context.read<OrderEntity>().shippingAddress.email = value;
                  },
            
                  hintText: 'البريد الإلكتروني',
                  suffixIcon: SizedBox(),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  fillColor: context.read<CartCubit>().isDarkMode
                      ? AppColors.grey.withOpacity(0.1) : Colors.white,
                  onSaved: (value) {
                    context.read<OrderEntity>().shippingAddress.address = value;
                  },
            
                  hintText: 'العنوان',
                  suffixIcon: SizedBox(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  fillColor: context.read<CartCubit>().isDarkMode
                      ? AppColors.grey.withOpacity(0.1) : Colors.white,
                  onSaved: (value) {
                    context.read<OrderEntity>().shippingAddress.city = value;
                  },
            
                  hintText: 'المدينه',
                  suffixIcon: SizedBox(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  fillColor: context.read<CartCubit>().isDarkMode
                      ? AppColors.grey.withOpacity(0.1) : Colors.white,
                  onSaved: (value) {
                    context.read<OrderEntity>().shippingAddress.floor = value;
                  },
            
                  hintText: 'رقم الطابق , رقم الشقه ..',
                  suffixIcon: SizedBox(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  fillColor: context.read<CartCubit>().isDarkMode
                      ? AppColors.grey.withOpacity(0.1) : Colors.white,
                  onSaved: (value) {
                    context.read<OrderEntity>().shippingAddress.phoneNumber =
                        value;
                  },
            
                  hintText: 'رقم الموبايل',
                  suffixIcon: SizedBox(),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 12),
                // Row(
                //   children: [
                //     Switch(
                //       value: true,
                //       activeColor: Colors.white,
                //       activeTrackColor: AppColors.primary,
                //       inactiveThumbColor: Colors.grey,
                //       inactiveTrackColor: Colors.grey.shade300,
                //       onChanged: (value) {
                //         // Handle switch value change
                //       },
                //     ),
                //
                //     SizedBox(width: 8),
                //     Text(
                //       'حفظ العنوان',
                //       style: TextStyles.semiBold16.copyWith(
                //         color: Color(0xff949D9E),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
