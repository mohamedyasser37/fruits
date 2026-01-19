import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:fruits/helper/show_scaffoldBar.dart';
import 'package:fruits/paypal_key.dart';
import 'package:fruits/views/shipping/add_order_cubit/add_order_cubit.dart';
import 'package:fruits/views/shipping/paypal_payment_entity/paypal_payment_entity.dart';
import 'package:fruits/views/shipping/shipping%20_entites/order_entity.dart';

void processPaypalPayment(BuildContext context) {
  var orderEntity = context.read<OrderEntity>();
  PaypalPaymentEntity paypalPaymentEntity = PaypalPaymentEntity.fromEntity(
    orderEntity,
  );
  var addOrderCubit = context.read<AddOrderCubit>();

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: PaypalKey.kPaypalClientId,
        secretKey: PaypalKey.kPaypalSecretKey,
        transactions: [paypalPaymentEntity.toJson()],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showScaffoldBar(context, 'تمت العمليه بنجاح');
          });
          Navigator.pop(context);
          addOrderCubit.addOrder(order: orderEntity);
        },
        onError: (error) {
          Navigator.pop(context);
          //log(error.toString());
          showScaffoldBar(context, 'حدث خطأ في عملية الدفع');
        },
        onCancel: () {
          print('cancelled:');
        },
      ),
    ),
  );
}
