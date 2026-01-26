import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

class TestFirebaseNotifications extends StatelessWidget {
  const TestFirebaseNotifications({super.key, required this.message});

  final RemoteMessage message;
  static const String routeName = 'firebaseNotifications';

  @override
  Widget build(BuildContext context) {
    // الاستماع لحالة الـ Dark Mode من الـ Cubit الخاص بك
    final bool isDark = context.watch<CartCubit>().isDarkMode;

    // استخراج بيانات الإشعار
    String title =
        message.notification?.title ?? message.data['title'] ?? "إشعار جديد";
    String body =
        message.notification?.body ?? message.data['body'] ?? "لا يوجد تفاصيل";

    return Scaffold(
      // تغيير خلفية الصفحة بناءً على الـ Mode
      backgroundColor: isDark ? AppColors.mainBlack : AppColors.mainWhite,
      appBar: AppBar(
        title: Text(
          'التنبيهات',
          style: TextStyles.bold16.copyWith(
            color: isDark ? AppColors.mainWhite : AppColors.mainBlack,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? AppColors.mainWhite : AppColors.mainBlack,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              "assets/images/splash_bottom.svg",
              fit: BoxFit.fill,
              colorFilter: isDark
                  ? ColorFilter.mode(
                      Colors.white.withOpacity(0.05),
                      BlendMode.srcIn,
                    )
                  : null,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // اللوجو الخاص بك
                SvgPicture.asset("assets/images/logo.svg", width: 100),
                const SizedBox(height: 40),

                // حاوية محتوى الإشعار (Card)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    // لون الكارت يتغير بناءً على الـ Mode
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withOpacity(0.3)
                            : Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: isDark
                            ? Colors.greenAccent
                            : const Color(0xFF1B5E20),
                        size: 40,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyles.bold19.copyWith(
                          color: isDark
                              ? Colors.greenAccent
                              : const Color(0xFF1B5E20),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Divider(
                        thickness: 1,
                        height: 20,
                        color: isDark
                            ? Colors.white24
                            : Colors.grey.withOpacity(0.2),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        body,
                        textAlign: TextAlign.center,
                        style: TextStyles.semiBold16.copyWith(
                          color: isDark
                              ? AppColors.mainWhite
                              : Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
