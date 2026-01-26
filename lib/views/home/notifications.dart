import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/views/home/notification_cubit/notifications_cubit.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  static const String routeName = 'notifications';

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<CartCubit>().isDarkMode;
    context.read<NotificationsCubit>().clearBadge();

    return Scaffold(
      backgroundColor: isDark ? AppColors.mainBlack : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'الإشعارات',
          style: TextStyles.bold19.copyWith(
            color: isDark ? AppColors.mainWhite : AppColors.mainBlack,
          ),
        ),
        centerTitle: true,
        elevation: 0, // إلغاء الظل لشكل عصري أكثر
        backgroundColor: isDark ? AppColors.mainBlack : Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: isDark ? AppColors.mainWhite : AppColors.mainBlack,
          ),
        ),
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NotificationsError) {
            return Center(child: Text(state.message));
          }
          if (state is NotificationsLoaded) {
            final titles = state.titles;
            if (titles.isEmpty) {
              return _buildEmptyState(isDark);
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return NotificationItem(
                  title: titles[index],
                  index: index,
                  isDark: isDark,
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  // واجهة في حال عدم وجود إشعارات
  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "لا توجد إشعارات حتى الآن",
            style: TextStyles.semiBold16.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final int index;
  final bool isDark;

  const NotificationItem({
    super.key,
    required this.title,
    required this.index,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(title + index.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        context.read<NotificationsCubit>().deleteNotification(index);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_sweep, color: Colors.white, size: 30),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1F1F1F) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/sale.png', fit: BoxFit.contain),
            ),
          ),
          title: Text(
            title,
            style: TextStyles.bold16.copyWith(
              color: isDark ? AppColors.mainWhite : AppColors.mainBlack,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              "اضغط لمعرفة المزيد من التفاصيل",
              style: TextStyles.regular13.copyWith(color: Colors.grey),
            ),
          ),
          trailing: const Icon(Icons.circle, color: Colors.green, size: 10), // نقطة الإشعار الجديد
        ),
      ),
    );
  }
}