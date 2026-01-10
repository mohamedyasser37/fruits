import 'package:bloc/bloc.dart';
import 'package:fruits/views/shipping/repos/orders_repo/orders_repo.dart';
import 'package:fruits/views/shipping/shipping%20_entites/order_entity.dart';
import 'package:meta/meta.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit(this.ordersRepo) : super(AddOrderInitial());

  final OrdersRepo ordersRepo;

  void addOrder({required OrderEntity order}) async {
    emit(AddOrderLoading());
    var result = await ordersRepo.addOrder(order: order);
    result.fold((failure) {
      emit(AddOrderFailure(failure.message));
      return;
    }, (success) {
      emit(AddOrderSuccess());
    });

  }


}
