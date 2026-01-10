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
    return Scaffold(
      backgroundColor: context.watch<CartCubit>().isDarkMode
          ? AppColors.mainBlack
          : AppColors.mainWhite,
      appBar: AppBar(
        title: Text(
          'الاشعارات',
          style: TextStyles.bold19.copyWith(
            color: context.read<CartCubit>().isDarkMode
                ? AppColors.mainWhite
                : AppColors.mainBlack,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: context.watch<CartCubit>().isDarkMode
            ? AppColors.mainBlack
            : AppColors.mainWhite,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: context.read<CartCubit>().isDarkMode
                ? AppColors.mainWhite
                : AppColors.mainBlack,
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
              return const Center(child: Text("لا توجد إشعارات"));
            }
            return ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Card(
                      color: context.watch<CartCubit>().isDarkMode
                          ? Color(0xff1f1f1f)
                          : AppColors.mainWhite,
                      margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading:Image.asset('assets/images/sale.png'),
                        title: Text(titles[index], style: TextStyles.bold16.copyWith(
                          color: context.read<CartCubit>().isDarkMode
                              ? AppColors.mainWhite
                              : AppColors.mainBlack,),)
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
