import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/custom_widgets/custom_bottom_nav_bar.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/main_view_body_bloc_listener.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const String routeName = 'mainView';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cubit = context.read<CartCubit>();

        return Scaffold(
          backgroundColor: cubit.isDarkMode
              ? AppColors.mainBlack
              : AppColors.mainWhite,
          body: SafeArea(
            child: Container(
              color: cubit.isDarkMode
                  ? AppColors.mainBlack
                  : AppColors.mainWhite,
              child: MainViewBodyBlocListener(
                currentViewIndex: currentViewIndex,
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            onValueChanged: (index) {
              setState(() {
                currentViewIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}
