import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fruits/stripe/models/payment_intent_input_model.dart';
import 'package:fruits/stripe/repos/payment_repo.dart';
import 'package:fruits/stripe/services/stripe_service.dart';




class PaymentRepoImpl extends PaymentRepo {
  final StripeService stripeService = StripeService();

  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  })async {
    try {
    await  stripeService.makePayment(
        paymentIntentInputModel: paymentIntentInputModel
      );

      return Future.value(Right(null));
    } on StripeException catch (e) {
      return Left(Failure(e.error.message ?? 'Oops Something went wrong'));
    } catch (e) {
      return Future.value(Left(Failure(e.toString())));
    }
  }
}
