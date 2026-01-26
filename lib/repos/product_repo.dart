import 'package:dartz/dartz.dart';
import 'package:fruits/core/entities/product_entity.dart';
import 'package:fruits/core/entities/review_entity.dart';
import 'package:fruits/core/models/product_model.dart';
import 'package:fruits/errors/faliures.dart';

abstract class ProductRepo {
  Future<Either<Failure,List<ProductModel>>> getProducts();
  Future<Either<Failure,List<ProductEntity>>> getBestSellingProducts();

  Future<Either<Failure, void>> addReview({
    required String productId,
    required ReviewEntity review,
  });

  Future<Either<Failure, void>> increaseSellingCount(String productId);
}


// abstract class ProductRepo {
//
//   Future<Either<Failure,List<ProductModel>>> getProducts();
//   Future<Either<Failure,List<ProductEntity>>> getBestSellingProducts();
//
//
//
//
//
// }