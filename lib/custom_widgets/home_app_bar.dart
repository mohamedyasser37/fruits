import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/helper/get_user_data.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/home/notifications.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset("assets/images/profile_image.png"),
      title: Text(
        'صباح الخير !..',
        style: TextStyles.regular16.copyWith(color: Color(0xff949D9E)),
      ),
      subtitle: Text(
        getUser().name,
        style: TextStyles.bold16.copyWith(color: context.read<CartCubit>().isDarkMode? AppColors.mainWhite: AppColors.mainBlack,),
      ),
      trailing: GestureDetector(
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

      onTap: () {},
    );
  }
}
