import 'package:dartz/dartz.dart';
import 'package:fruits/core/entities/product_entity.dart';
import 'package:fruits/errors/faliures.dart';


abstract class ProductsRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProducts();
}
