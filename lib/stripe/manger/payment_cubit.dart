import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/payment_intent_input_model.dart';
import '../repos/payment_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.paymentRepo) : super(PaymentInitial());
  final PaymentRepo paymentRepo;

  void makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    emit(PaymentLoading());
    var result = await paymentRepo.makePayment(
      paymentIntentInputModel: paymentIntentInputModel,
    );

    result.fold(
      (failure) {
        emit(PaymentFailure(failure.message));
      },
      (success) {
        emit(PaymentSuccess());
      },
    );
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
