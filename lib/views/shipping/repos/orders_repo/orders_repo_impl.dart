import 'package:dartz/dartz.dart';
import 'package:fruits/auth/services/data_service.dart';
import 'package:fruits/errors/faliures.dart';
import 'package:fruits/services/data_service.dart';
import 'package:fruits/views/shipping/data/models/order_model.dart';
import 'package:fruits/views/shipping/repos/orders_repo/orders_repo.dart';
import 'package:fruits/views/shipping/shipping%20_entites/order_entity.dart';


class OrdersRepoImpl implements OrdersRepo {
  final DataService dataBaseService;

  OrdersRepoImpl(this.dataBaseService);
  @override
  Future<Either<Failure, void>> addOrder(
      {required OrderEntity order}) async {
    try {
      var orderModel = OrderModel.fromEntity(order);
      await dataBaseService.addData(
        docId: orderModel.orderId,
        data: orderModel.toJson(), collectionName: 'orders',
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
