import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/custom_widgets/custom_text_form_field.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/helper/get_user_data.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

class PersonalProfile extends StatelessWidget {
  const PersonalProfile({super.key});

  static const String routeName = 'personalProfile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.read<CartCubit>().isDarkMode
          ? AppColors.mainBlack
          : AppColors.mainWhite,
      appBar: AppBar(
        title: Text(
          'الملف الشخصي',
          style: TextStyles.bold19.copyWith(
            color: context.read<CartCubit>().isDarkMode
                ? AppColors.mainWhite
                : AppColors.mainBlack,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: context.read<CartCubit>().isDarkMode
            ? AppColors.mainBlack
            : AppColors.mainWhite,
        leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: context.read<CartCubit>().isDarkMode
                      ? AppColors.mainWhite
                      : AppColors.mainBlack,
                ),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'المعلومات الشخصيه',
              style: TextStyles.semiBold16.copyWith(
                color: context.read<CartCubit>().isDarkMode
                    ? AppColors.mainWhite
                    : AppColors.mainBlack,
              ),
            ),
            SizedBox(height: 16),
            CustomTextFormField(
              hintColor: context.read<CartCubit>().isDarkMode
                  ? AppColors.mainWhite
                  : AppColors.mainBlack,
              fillColor: context.read<CartCubit>().isDarkMode
                  ? Color(0xff171717)
                  : Color(0xfff9fafa),
              hintText: getUser().name,
              suffixIcon: Icon(Icons.edit),
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 16),
            CustomTextFormField(
              hintColor: context.read<CartCubit>().isDarkMode
                  ? AppColors.mainWhite
                  : AppColors.mainBlack,
              fillColor: context.read<CartCubit>().isDarkMode
                  ? Color(0xff171717)
                  : Color(0xfff9fafa),
              hintText: getUser().email,
              suffixIcon: Icon(Icons.edit),
              keyboardType: TextInputType.name,
            ),

          ],
        ),
      ),
    );
  }
}
