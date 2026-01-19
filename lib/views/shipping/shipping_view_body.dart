import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/custom_widgets/custom_button.dart';
import 'package:fruits/helper/process_pyment.dart';
import 'package:fruits/helper/show_scaffoldBar.dart';
import 'package:fruits/stripe/manger/payment_cubit.dart';
import 'package:fruits/stripe/models/payment_intent_input_model.dart';
import 'package:fruits/views/products/products_app_bar.dart';
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

  bool ispaiedTrue = false;

  @override
  void initState() {
    // TODO: implement initState
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
    // TODO: implement dispose
    autoValidateMode.dispose();
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          CustomAppBar(
            actionButton: false,
            arrowBack: true,
            title: shippingList()[currentIndex],
          ),
          SizedBox(height: 20),

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
                  if (context.read<OrderEntity>().payWithCash != null) {
                    pageController.animateToPage(
                      currentIndex + 1,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn,
                    );
                  } else {
                    showScaffoldBar(context, 'يرجي تحديد طريقه الدفع');
                  }
                } else if (index == 1) {
                  var orderEntity = context.read<OrderEntity>();

                  if (orderEntity.payWithCash != null) {
                    pageController.animateToPage(
                      index,
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
          SizedBox(height: 32),
          Expanded(
            child: ShippingPageView(
              valueListenable: autoValidateMode,

              formKey: formKey,
              pageController: pageController,
            ),
          ),





          Visibility(
            visible: currentIndex == 2,
            child: BlocConsumer<PaymentCubit, PaymentState>(
              listener: (context, state) {
                if (state is PaymentSuccess) {

                  showScaffoldBar(context, 'تم الدفع بنجاح');

                }

                if (state is PaymentFailure) {

                  showScaffoldBar(context, ' حدث خطأ ما ');

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

          SizedBox(height: 24),
          CustomButton(
            onPressed: () {
              if (currentIndex == 0) {
                handleShippingValidation(context);
              } else if (currentIndex == 1) {
                handleAddressValidation();
              } else {
                processPaypalPayment(context);
              }
            },
            text: currentIndex == 2 ? 'الدفع باستخدام PayPal' : 'التالي',
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }

  void payWithStripe(BuildContext context) {

    final total = context.read<OrderEntity>()
        .calculateTotalPriceAfterDiscountAndShipping();


    final stripeAmount = (total * 100).round();

     context.read<PaymentCubit>().makePayment(
      paymentIntentInputModel: PaymentIntentInputModel(
        customerId: 'cus_TnvzphY3JDWTc1',
        amount:stripeAmount.toString(),
        currency: 'USD',
      ),
    );
  }

  void handleAddressValidation() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      pageController.nextPage(
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceIn,
      );
    }
  }

  void handleShippingValidation(BuildContext context) {
    if (context.read<OrderEntity>().payWithCash != null) {
      pageController.nextPage(
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceIn,
      );
    } else {
      showScaffoldBar(context, 'يرجي تحديد طريقه الدفع');
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
