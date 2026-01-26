import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/helper/get_user_data.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/home/notification_cubit/notifications_cubit.dart';
import 'package:fruits/views/home/notifications.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      leading: Image.asset("assets/images/profile_image.png"),
      title: Text(
        'صباح الخير !..',
        style: TextStyles.regular16.copyWith(color: const Color(0xff949D9E)),
      ),
      subtitle: Text(
        getUser().name,
        style: TextStyles.bold16.copyWith(
          color: context.read<CartCubit>().isDarkMode
              ? AppColors.mainWhite
              : AppColors.mainBlack,
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          // 1. تصفير العداد عند الضغط
          context.read<NotificationsCubit>().clearBadge();
          // 2. الذهاب لصفحة الإشعارات
          Navigator.pushNamed(context, NotificationsView.routeName);
        },
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            int count = context.read<NotificationsCubit>().unreadCount;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: context.read<CartCubit>().isDarkMode
                      ? AppColors.grey.withOpacity(0.1)
                      : const Color(0xffeef8ed),
                  child: SvgPicture.asset(
                    'assets/images/notification.svg',
                    width: 30,
                    height: 30,
                  ),
                ),
                // إذا كان هناك إشعارات، اعرض الدائرة الحمراء بالرقم
                if (count > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      onTap: () {},
    );
  }
}
