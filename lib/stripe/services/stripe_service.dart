import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fruits/stripe/api_keys.dart';

import '../models/Payment_intent_model.dart';
import '../models/ephemeral/Ephemeral_key.dart';
import '../models/payment_intent_input_model.dart';
import '../models/payment_sheet/init_payment_sheet_model.dart';
import 'api_service.dart';

class StripeService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInputModel,
  ) async {
    var response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.stripeToken,
    );

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

    return paymentIntentModel;
  }

  Future initPaymentSheet({
    required InitPaymentSheetModel initiPaymentSheetModel,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: initiPaymentSheetModel.clientSecret,
        customerEphemeralKeySecret: initiPaymentSheetModel.ephemeralKeySecret,
        customerId: initiPaymentSheetModel.customerId,
        merchantDisplayName: 'tharwat',
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralKeyModel = await createEphemeralKey(
      customerId: paymentIntentInputModel.customerId,
    );
    var initPaymentSheetInputModel = InitPaymentSheetModel(
      clientSecret: paymentIntentModel.clientSecret!,
      customerId: paymentIntentInputModel.customerId,
      ephemeralKeySecret: ephemeralKeyModel.secret!,
    );
    await initPaymentSheet(initiPaymentSheetModel: initPaymentSheetInputModel);
    await displayPaymentSheet();
  }

  Future<EphemeralKey> createEphemeralKey({required String customerId}) async {
    var response = await apiService.post(
      body: {'customer': customerId},
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/ephemeral_keys',
      token: ApiKeys.stripeToken,
      headers: {
        'Authorization': "Bearer ${ApiKeys.stripeToken}",
        'Stripe-Version': '2023-08-16',
      },
    );

    var ephermeralKey = EphemeralKey.fromJson(response.data);

    return ephermeralKey;
  }
}
