import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:fruits/custom_widgets/custom_button.dart';
import 'package:fruits/stripe/api_keys.dart';
import 'package:fruits/stripe/manger/payment_cubit.dart';
import 'package:fruits/stripe/models/payment_intent_input_model.dart';



class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({super.key,});


  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            BlocBuilder<PaymentCubit, PaymentState>(
              builder: (context, state) {
                return CustomButton(
                  text: 'OK',
                  onPressed: () {
                    context.read<PaymentCubit>().makePayment(
                      paymentIntentInputModel: PaymentIntentInputModel(
                        customerId: 'cus_TnvzphY3JDWTc1',
                        amount: '9999',
                        currency: 'USD',
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

}
