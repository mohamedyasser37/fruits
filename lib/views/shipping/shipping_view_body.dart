import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/custom_widgets/custom_button.dart';
import 'package:fruits/helper/process_pyment.dart';
import 'package:fruits/helper/show_scaffoldBar.dart';
import 'package:fruits/stripe/manger/payment_cubit.dart';
import 'package:fruits/stripe/models/payment_intent_input_model.dart';
import 'package:fruits/views/products/products_app_bar.dart';
import 'package:fruits/views/shipping/add_order_cubit/add_order_cubit.dart';
import 'package:fruits/views/shipping/paypal_payment_entity/paypal_payment_entity.dart';
import 'package:fruits/views/shipping/shipping%20_entites/order_entity.dart';
import 'package:fruits/views/shipping/shipping_page_view.dart';
import 'package:fruits/views/shipping/top_shiiping_list.dart';

class ShippingViewBody extends StatefulWidget {
  const ShippingViewBody({super.key});

  @override
  State<ShippingViewBody> createState() => _ShippingViewBodyState();
}

class _ShippingViewBodyState extends State<ShippingViewBody>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> formKey = GlobalKey();
  PageController pageController = PageController();
  int currentIndex = 0;
  ValueNotifier<AutovalidateMode> autoValidateMode = ValueNotifier(
    AutovalidateMode.disabled,
  );

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    autoValidateMode.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          CustomAppBar(
            actionButton: false,
            arrowBack: true,
            title: shippingList()[currentIndex],
          ),
          const SizedBox(height: 20),
          TopShippingList(
            formKey: formKey,
            onTap: (index) {
              if (index < currentIndex) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                );
              } else {
                if (currentIndex == 0) {
                  // تعديل الفحص ليعتمد على paymentMethod الجديد
                  if (context.read<OrderEntity>().paymentMethod != null) {
                    pageController.animateToPage(
                      currentIndex + 1,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn,
                    );
                  } else {
                    showScaffoldBar(context, 'يرجي تحديد طريقه الدفع');
                  }
                } else {
                  handleAddressValidation();
                }
              }
            },
            currentIndex: currentIndex,
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ShippingPageView(
              valueListenable: autoValidateMode,
              formKey: formKey,
              pageController: pageController,
            ),
          ),

          // بخش الـ Stripe
          Visibility(
            visible: currentIndex == 2,
            child: BlocConsumer<PaymentCubit, PaymentState>(
              listener: (context, state) {
                if (state is PaymentSuccess) {
                  showScaffoldBar(context, 'تم الدفع بنجاح');

                  // تحديث الـ Entity وتخزين الأوردر بعد نجاح الدفع
                  var orderEntity = context.read<OrderEntity>();
                  orderEntity.paymentMethod = 'Stripe';

                  context.read<AddOrderCubit>().addOrder(order: orderEntity);
                }

                if (state is PaymentFailure) {
                  showScaffoldBar(context, 'حدث خطأ في عملية الدفع');
                }
              },
              builder: (context, state) {
                if (state is PaymentLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return CustomButton(
                  text: 'الدفع باستخدام Stripe',
                  onPressed: () {
                    payWithStripe(context);
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // بخش الـ PayPal أو التالي
          CustomButton(
            onPressed: () {
              if (currentIndex == 0) {
                handleShippingValidation(context);
              } else if (currentIndex == 1) {
                handleAddressValidation();
              } else {
                // دفع PayPal
                var orderEntity = context.read<OrderEntity>();
                orderEntity.paymentMethod = 'Paypal';
                processPaypalPayment(context);
                // ملاحظة: تأكد أن ميثود processPaypalPayment تستدعي addOrder عند النجاح أيضاً
              }
            },
            text: currentIndex == 2 ? 'الدفع باستخدام PayPal' : 'التالي',
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void payWithStripe(BuildContext context) {
    final orderEntity = context.read<OrderEntity>();
    final total = orderEntity.calculateTotalPriceAfterDiscountAndShipping();
    final stripeAmount = (total * 100).round();

    // نكتفي بطلب الدفع فقط، والـ Listener سيتولى إضافة الأوردر عند النجاح
    context.read<PaymentCubit>().makePayment(
      paymentIntentInputModel: PaymentIntentInputModel(
        customerId: 'cus_TnvzphY3JDWTc1',
        amount: stripeAmount.toString(),
        currency: 'USD',
      ),
    );
  }

  void handleAddressValidation() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.bounceIn,
      );
    }
  }

  void handleShippingValidation(BuildContext context) {
    // تعديل الفحص ليتوافق مع الـ paymentMethod
    if (context.read<OrderEntity>().paymentMethod != null) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.bounceIn,
      );
    } else {
      showScaffoldBar(context, 'يرجي تحديد طريقه الدفع');
    }
  }

  @override
  bool get wantKeepAlive => true;
}









// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fruits/custom_widgets/custom_button.dart';
// import 'package:fruits/helper/process_pyment.dart';
// import 'package:fruits/helper/show_scaffoldBar.dart';
// import 'package:fruits/stripe/manger/payment_cubit.dart';
// import 'package:fruits/stripe/models/payment_intent_input_model.dart';
// import 'package:fruits/views/products/products_app_bar.dart';
// import 'package:fruits/views/shipping/add_order_cubit/add_order_cubit.dart';
// import 'package:fruits/views/shipping/paypal_payment_entity/paypal_payment_entity.dart';
// import 'package:fruits/views/shipping/shipping%20_entites/order_entity.dart';
// import 'package:fruits/views/shipping/shipping_page_view.dart';
// import 'package:fruits/views/shipping/top_shiiping_list.dart';
//
// class ShippingViewBody extends StatefulWidget {
//   const ShippingViewBody({super.key});
//
//   @override
//   State<ShippingViewBody> createState() => _ShippingViewBodyState();
// }
//
// class _ShippingViewBodyState extends State<ShippingViewBody>
//     with AutomaticKeepAliveClientMixin {
//   GlobalKey<FormState> formKey = GlobalKey();
//
//   PageController pageController = PageController();
//   int currentIndex = 0;
//   ValueNotifier<AutovalidateMode> autoValidateMode = ValueNotifier(
//     AutovalidateMode.disabled,
//   );
//
//   bool ispaiedTrue = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     pageController = PageController();
//     pageController.addListener(() {
//       setState(() {
//         currentIndex = pageController.page!.toInt();
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     autoValidateMode.dispose();
//     super.dispose();
//     pageController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         children: [
//           CustomAppBar(
//             actionButton: false,
//             arrowBack: true,
//             title: shippingList()[currentIndex],
//           ),
//           SizedBox(height: 20),
//
//           TopShippingList(
//             formKey: formKey,
//             onTap: (index) {
//               if (index < currentIndex) {
//                 pageController.animateToPage(
//                   index,
//                   duration: const Duration(milliseconds: 100),
//                   curve: Curves.easeInOut,
//                 );
//               } else {
//                 if (currentIndex == 0) {
//                   if (context.read<OrderEntity>().payWithCash != null) {
//                     pageController.animateToPage(
//                       currentIndex + 1,
//                       duration: const Duration(milliseconds: 100),
//                       curve: Curves.bounceIn,
//                     );
//                   } else {
//                     showScaffoldBar(context, 'يرجي تحديد طريقه الدفع');
//                   }
//                 } else if (index == 1) {
//                   var orderEntity = context.read<OrderEntity>();
//
//                   if (orderEntity.payWithCash != null) {
//                     pageController.animateToPage(
//                       index,
//                       duration: const Duration(milliseconds: 100),
//                       curve: Curves.bounceIn,
//                     );
//                   } else {
//                     showScaffoldBar(context, 'يرجي تحديد طريقه الدفع');
//                   }
//                 } else {
//                   handleAddressValidation();
//                 }
//               }
//             },
//             currentIndex: currentIndex,
//           ),
//           SizedBox(height: 32),
//           Expanded(
//             child: ShippingPageView(
//               valueListenable: autoValidateMode,
//
//               formKey: formKey,
//               pageController: pageController,
//             ),
//           ),
//
//
//
//
//
//           Visibility(
//             visible: currentIndex == 2,
//             child: BlocConsumer<PaymentCubit, PaymentState>(
//               listener: (context, state) {
//                 if (state is PaymentSuccess) {
//
//                   showScaffoldBar(context, 'تم الدفع بنجاح');
//
//                 }
//
//                 if (state is PaymentFailure) {
//
//                   showScaffoldBar(context, ' حدث خطأ ما ');
//
//                 }
//               },
//               builder: (context, state) {
//                 if (state is PaymentLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 return CustomButton(
//                   text: 'الدفع باستخدام Stripe',
//                   onPressed: () {
//                     payWithStripe(context);
//                   },
//                 );
//               },
//             ),
//           ),
//
//           SizedBox(height: 24),
//           CustomButton(
//             onPressed: () {
//               if (currentIndex == 0) {
//                 handleShippingValidation(context);
//               } else if (currentIndex == 1) {
//                 handleAddressValidation();
//               } else {
//                 processPaypalPayment(context);
//               }
//             },
//             text: currentIndex == 2 ? 'الدفع باستخدام PayPal' : 'التالي',
//           ),
//
//           SizedBox(height: 24),
//         ],
//       ),
//     );
//   }
//
//   void payWithStripe(BuildContext context) {
//
//     var orderEntity = context.read<OrderEntity>();
//     PaypalPaymentEntity paypalPaymentEntity = PaypalPaymentEntity.fromEntity(
//       orderEntity,
//     );
//     var addOrderCubit = context.read<AddOrderCubit>();
//
//     final total = context.read<OrderEntity>()
//         .calculateTotalPriceAfterDiscountAndShipping();
//
//
//     final stripeAmount = (total * 100).round();
//
//      context.read<PaymentCubit>().makePayment(
//       paymentIntentInputModel: PaymentIntentInputModel(
//         customerId: 'cus_TnvzphY3JDWTc1',
//         amount:stripeAmount.toString(),
//         currency: 'USD',
//       ),
//
//
//     );
//     addOrderCubit.addOrder(order: orderEntity);
//
//   }
//
//   void handleAddressValidation() {
//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.save();
//       pageController.nextPage(
//         duration: Duration(milliseconds: 200),
//         curve: Curves.bounceIn,
//       );
//     }
//   }
//
//   void handleShippingValidation(BuildContext context) {
//     if (context.read<OrderEntity>().payWithCash != null) {
//       pageController.nextPage(
//         duration: Duration(milliseconds: 200),
//         curve: Curves.bounceIn,
//       );
//     } else {
//       showScaffoldBar(context, 'يرجي تحديد طريقه الدفع');
//     }
//   }
//
//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }
