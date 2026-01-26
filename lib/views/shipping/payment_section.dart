import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/shipping/shipping%20_entites/order_entity.dart';
import 'package:fruits/views/shipping/shipping_address_widget.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key, required this.pageController});
final PageController pageController ;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ملخص الطلب :',style: TextStyles.bold16.copyWith(
            color: context.watch<CartCubit>().isDarkMode? AppColors.mainWhite: Color(0xff4E5556)
          ),),
          SizedBox(height: 16,),
      
      
          Container(
            padding:  EdgeInsets.symmetric(horizontal: 8,vertical: 16),
            decoration: BoxDecoration(
              color:
                  context.watch<CartCubit>().isDarkMode? AppColors.grey.withOpacity(0.1): Color(0xfff8f8f8),
      
              borderRadius: BorderRadius.circular(8),
            ),
      
            child:Column(
              children: [
      
                Row(
                  children: [
                    Text('المجموع الفرعي :',style: TextStyles.regular16.copyWith(color:context.read<CartCubit>().isDarkMode? AppColors.mainWhite: Color(0xff4E5556)),),
                    Spacer(),
                    Text('${context.read<OrderEntity>().cartItems.calculateTotalPrice()} جنيه',style: TextStyles.semiBold16.copyWith(color:context.read<CartCubit>().isDarkMode? AppColors.mainWhite: Color(0xff4E5556)),),
      
                  ],
                ),
                Row(
                  children: [
                    Text('التوصيل  :',style: TextStyles.regular16.copyWith(color:context.read<CartCubit>().isDarkMode? AppColors.mainWhite: Color(0xff4E5556)),),
                    Spacer(),
                    Text('30 جنية',style: TextStyles.semiBold16.copyWith(color:context.read<CartCubit>().isDarkMode? AppColors.mainWhite: Color(0xff4E5556)),),
      
                  ],
                ),
                SizedBox(height: 10,),
                Divider(
                  color: Color(0xffCACECE),
                  thickness: 1,
                 indent: 30,
                  endIndent: 30,
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text( 'الكلي',style: TextStyles.bold19.copyWith(
                      color: context.read<CartCubit>().isDarkMode? AppColors.mainWhite: Color(0xff4E5556)
                    )),
                    Spacer(),
                    Text('${context.read<OrderEntity>().cartItems.calculateTotalPrice()+30} جنيه',style: TextStyles.bold16.copyWith(
                      color: context.read<CartCubit>().isDarkMode? AppColors.mainWhite: Color(0xff4E5556)
                    ),),
      
                  ],
                ),
      
      
              ],
            ) ,
          ),
          SizedBox(height: 16,),
      
          GestureDetector(
              onTap: () {
                pageController.animateToPage(1, duration: Duration(milliseconds: 200),
                    curve: Curves.bounceIn);
              },
              child: Text( 'يرجي تأكيد  طلبك',style: TextStyles.bold16.copyWith(
                color: context.read<CartCubit>().isDarkMode? AppColors.mainWhite: Color(0xff4E5556)
              ),)),
      
          ShippingAddressWidget(
            pageController: pageController,
          )
        ],
      ),
    );
  }
}
