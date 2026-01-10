import 'package:dartz/dartz.dart';
import 'package:fruits/core/entities/product_entity.dart';
import 'package:fruits/core/models/product_model.dart';
import 'package:fruits/errors/faliures.dart';

abstract class ProductRepo {

  Future<Either<Failure,List<ProductModel>>> getProducts();
  Future<Either<Failure,List<ProductEntity>>> getBestSellingProducts();

}