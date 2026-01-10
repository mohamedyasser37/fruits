import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/home/notifications.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.arrowBack,
    required this.actionButton,
  });

  final String title;
  final bool arrowBack;
  final bool actionButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: arrowBack ? GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined,color:context.read<CartCubit>().isDarkMode? AppColors.mainWhite: AppColors.mainBlack,)) : null,
      centerTitle: true,
      elevation: 0,
      backgroundColor: context.watch<CartCubit>().isDarkMode
          ? AppColors.mainBlack
          : AppColors.mainWhite,
      title: Text(
        title,
        style: TextStyles.bold19.copyWith(color:context.read<CartCubit>().isDarkMode? AppColors.mainWhite: AppColors.mainBlack),
      ),
      actions: [
        actionButton
            ?  CircleAvatar(
      radius: 18,
      backgroundColor:context.read<CartCubit>().isDarkMode? AppColors.grey.withOpacity(0.1): Color(0xffeef8ed),
      child:  GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, NotificationsView.routeName);
        },
        child: CircleAvatar(
          radius: 16,
          backgroundColor:context.read<CartCubit>().isDarkMode? AppColors.grey.withOpacity(0.1): Color(0xffeef8ed),
          child: SvgPicture.asset(
            'assets/images/notification.svg',
            width: 20,
            height: 20,
          ),
        ),
      ),
    )
            : SizedBox(),
      ],
    );
  }
}
