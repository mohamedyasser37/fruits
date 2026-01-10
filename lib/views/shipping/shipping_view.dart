import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/cart_entities/cart_item_entity.dart';
import 'package:fruits/cart_entities/cart_list_entity.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/get_it.dart';
import 'package:fruits/helper/get_user_data.dart';
import 'package:fruits/helper/show_scaffoldBar.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/shipping/add_order_cubit/add_order_cubit.dart';
import 'package:fruits/views/shipping/repos/orders_repo/orders_repo.dart';
import 'package:fruits/views/shipping/shipping%20_entites/order_entity.dart';
import 'package:fruits/views/shipping/shipping_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ShippingView extends StatelessWidget {
  const ShippingView({super.key, required this.cartItems});

  static const String routeName = 'shipping';
  final CartListEntity cartItems;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddOrderCubit(getIt<OrdersRepo>()),

      child: Scaffold(
          backgroundColor: context.watch<CartCubit>().isDarkMode? AppColors.mainBlack: AppColors.mainWhite,
          body: Provider.value(
              value: OrderEntity(cartItems: cartItems, uID: getUser().uid),
              child: BlocConsumer<AddOrderCubit, AddOrderState>(
                listener: (context, state) {
                if(state is AddOrderSuccess) {
                  showScaffoldBar(context,'تمت العملية بنجاح');
                }if(state is AddOrderFailure) {
                  showScaffoldBar(context, 'حدث خطأ ما, برجأ المحاوله لاحقا');
                }
                },
                builder: (context, state) {
                  return ModalProgressHUD(inAsyncCall: state is AddOrderLoading,
                  child: ShippingViewBody());
                },
              ))),
    );
  }




}


