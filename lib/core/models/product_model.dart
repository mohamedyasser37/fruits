import 'package:fruits/core/entities/product_entity.dart';

import 'review_model.dart';

class ProductModel {
  final String id;
  final String code;
  final String name;
  final String description;
  final num price;
  final bool isFeatured;
  final String? imageUrl;
  final int expirationsMonths;
  final bool isOrganic;
  final int numberOfCalories;
  final int unitAmount;
  final int sellingCount;
  final num avgRating;
  final num ratingCount;
  final List<ReviewModel> reviews;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.isFeatured,
    required this.expirationsMonths,
    required this.isOrganic,
    required this.numberOfCalories,
    required this.unitAmount,
    required this.sellingCount,
    required this.avgRating,
    required this.ratingCount,
    required this.reviews,
    this.imageUrl,
    this.isFavorite = false, required this.code,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      // استخدم عامل الـ ?? لضمان عدم رجوع قيمة Null
      id: json['id']?.toString() ?? '',
      code: json['code']?.toString() ?? '', // الاحتمال الأكبر للخطأ هنا
      name: json['name']?.toString() ?? 'بدون اسم',
      description: json['description']?.toString() ?? '',
      price: json['price'] ?? 0,
      isFeatured: json['isFeatured'] ?? false,
      imageUrl: json['imageUrl'], // هذا الحقل أصلاً String? فمسموح بـ Null
      expirationsMonths: json['expirationsMonths'] ?? 0,
      isOrganic: json['isOrganic'] ?? false,
      numberOfCalories: json['numberOfCalories'] ?? 0,
      unitAmount: json['unitAmount'] ?? 0,
      sellingCount: json['sellingCount'] ?? 0,
      avgRating: json['avgRating'] ?? 0,
      ratingCount: json['ratingCount'] ?? 0,
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((x) => ReviewModel.fromJson(x)) // تأكد أن ReviewModel أيضاً محمي
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'isFeatured': isFeatured,
      'imageUrl': imageUrl,
      'expirationsMonths': expirationsMonths,
      'isOrganic': isOrganic,
      'numberOfCalories': numberOfCalories,
      'unitAmount': unitAmount,
      'sellingCount': sellingCount,
      'avgRating': avgRating,
      'ratingCount': ratingCount,
      'reviews': reviews.map((x) => x.toJson()).toList(),
      'isFavorite': isFavorite,
    };
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      isFeatured: isFeatured,
      imageUrl: imageUrl,
      expirationsMonths: expirationsMonths,
      isOrganic: isOrganic,
      numberOfCalories: numberOfCalories,
      unitAmount: unitAmount,
      sellingCount: sellingCount,
      avgRating: avgRating,
      ratingCount: ratingCount,
      reviews: reviews.map((r) => r.toEntity()).toList(), code: code,
    );
  }
}



// class ProductModel {
//   final String id;
//   final String name;
//   final String code;
//   final String description;
//   final num price;
//   final bool isFeatured;
//   String? imageUrl;
//   final int expirationsMonths;
//   final bool isOrganic;
//   final int numberOfCalories;
//   final int unitAmount;
//   bool isFavorite; // جديد: هل هذا المنتج مفضل
//
//   ProductModel({
//     required this.id,
//     required this.name,
//     required this.code,
//     required this.description,
//     required this.price,
//     required this.isFeatured,
//     this.imageUrl,
//     required this.expirationsMonths,
//     required this.isOrganic,
//     required this.numberOfCalories,
//     required this.unitAmount,
//     this.isFavorite = false,
//   });
//
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'],
//       name: json['name'],
//       code: json['code'],
//       description: json['description'],
//       price: json['price'],
//       isFeatured: json['isFeatured'],
//       imageUrl: json['imageUrl'],
//       expirationsMonths: json['expirationsMonths'],
//       isOrganic: json['isOrganic'],
//       numberOfCalories: json['numberOfCalories'],
//       unitAmount: json['unitAmount'],
//       isFavorite: json['isFavorite'] ?? false,
//     );
//   }
//
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'code': code,
//       'description': description,
//       'price': price,
//       'isFeatured': isFeatured,
//       'imageUrl': imageUrl,
//       'expirationsMonths': expirationsMonths,
//       'isOrganic': isOrganic,
//       'numberOfCalories': numberOfCalories,
//       'unitAmount': unitAmount,
//       'isFavorite': isFavorite,
//     };
//   }
//
//   ProductEntity toEntity({List<ReviewEntity> reviews = const []}) {
//     return ProductEntity(
//       id: id,
//       name: name,
//       code: code,
//       description: description,
//       price: price,
//       isFeatured: isFeatured,
//       imageUrl: imageUrl,
//       expirationsMonths: expirationsMonths,
//       isOrganic: isOrganic,
//       numberOfCalories: numberOfCalories,
//       unitAmount: unitAmount,
//       reviews: reviews,
//       avgRating: _calculateAvgRating(reviews),
//       ratingCount: reviews.length,
//     );
//   }
//
//   num _calculateAvgRating(List<ReviewEntity> reviews) {
//     if (reviews.isEmpty) return 0;
//     return reviews.map((e) => e.ratting).reduce((a, b) => a + b) / reviews.length;
//   }
//
//
//
//   factory ProductModel.fromEntity(dynamic entity) {
//     return ProductModel(
//       id: entity.id,
//       name: entity.name,
//       code: entity.code,
//       description: entity.description,
//       price: entity.price,
//       isFeatured: entity.isFeatured,
//       imageUrl: entity.imageUrl,
//       expirationsMonths: entity.expirationsMonths,
//       isOrganic: entity.isOrganic,
//       numberOfCalories: entity.numberOfCalories,
//       unitAmount: entity.unitAmount,
//       isFavorite: false,
//     );
//   }
// }
