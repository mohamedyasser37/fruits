import 'package:dartz/dartz.dart';
import 'package:fruits/errors/faliures.dart';

import '../models/payment_intent_input_model.dart';

abstract class PaymentRepo {
  Future<Either<Failure, void>> makePayment({required PaymentIntentInputModel paymentIntentInputModel});

}


class Failure {
  final String message;

  Failure(this.message);
}