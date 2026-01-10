import 'package:dartz/dartz.dart';
import 'package:fruits/errors/faliures.dart';
import 'package:fruits/views/shipping/shipping%20_entites/order_entity.dart';


abstract class OrdersRepo {
  Future<Either<Failure, void>> addOrder({required OrderEntity order});
}
