import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fruits/auth/services/data_service.dart';
import 'package:fruits/core/entities/product_entity.dart';
import 'package:fruits/core/entities/review_entity.dart';
import 'package:fruits/core/models/product_model.dart';
import 'package:fruits/errors/faliures.dart';
import 'package:fruits/helper/end_points.dart';
import 'package:fruits/repos/product_repo.dart';
import 'package:fruits/services/data_service.dart';

class ProductRepoImp implements ProductRepo {
  final DataService dataService;

  ProductRepoImp({required this.dataService});

  @override
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProducts() async {
    try {
      final data = await dataService.getData(
        collectionName: EndPoints.productsEndPoint,
        query: {
          'limit': 10,
          'orderBy': 'sellingCount',
          'descending': true,
        },
      ) as List<Map<String, dynamic>>;

      final products = data.map((e) => ProductModel.fromJson(e).toEntity()).toList();

      return Right(products);
    } catch (e) {
      return Left(ServerFailure('Failed to get best selling products'));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final data = await dataService.getData(
        collectionName: EndPoints.productsEndPoint,
      ) as List<Map<String, dynamic>>;

      final products = data.map((e) => ProductModel.fromJson(e)).toList();

      return Right(products);
    } catch (e) {
      return Left(ServerFailure('Failed to get products'));
    }
  }

  @override
  Future<Either<Failure, void>> addReview({
    required String productId,
    required ReviewEntity review,
  }) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection(EndPoints.productsEndPoint)
          .doc(productId);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          throw Exception("Product not found");
        }

        final data = snapshot.data()!;
        final List reviews = data['reviews'] ?? [];

        reviews.add(review.toJson());

        final ratingCount = (data['ratingCount'] ?? 0) + 1;
        final totalRating = (data['avgRating'] ?? 0) * (data['ratingCount'] ?? 0);
        final avgRating = (totalRating + review.ratting) / ratingCount;

        transaction.update(docRef, {
          'reviews': reviews,
          'ratingCount': ratingCount,
          'avgRating': avgRating,
        });
      });

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to add review"));
    }
  }
  @override
  Future<Either<Failure, void>> increaseSellingCount(String productId) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection(EndPoints.productsEndPoint)
          .doc(productId);

      await docRef.update({
        'sellingCount': FieldValue.increment(1),
      });

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to increase selling count"));
    }
  }


}
