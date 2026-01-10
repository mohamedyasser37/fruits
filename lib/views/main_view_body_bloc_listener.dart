import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/helper/show_scaffoldBar.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/home/main_view_body.dart';

class MainViewBodyBlocListener extends StatelessWidget {
  const MainViewBodyBlocListener({super.key, required this.currentViewIndex});

  final int currentViewIndex;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartItemAdded) {
          showScaffoldBar(context, 'تم اضافة المنتج الى السلة');
        }
        if (state is CartItemRemoved) {
          showScaffoldBar(context, 'تم حذف المنتج من السلة');
        }
      },
      child: MainViewBody(currentViewIndex: currentViewIndex),
    );
  }
}
