import 'package:equatable/equatable.dart';
import 'package:fruits/core/entities/review_entity.dart';

import 'package:equatable/equatable.dart';
import 'review_entity.dart' hide ReviewEntity;

class ProductEntity extends Equatable {
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
  final List<ReviewEntity> reviews;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.reviews,
    required this.expirationsMonths,
    required this.numberOfCalories,
    required this.unitAmount,
    required this.sellingCount,
    required this.isFeatured,
    this.imageUrl,
    this.isOrganic = false,
    this.avgRating = 0,
    this.ratingCount = 0,
    required this.code,
  });

  // هذه الدالة هي السر في تحديث الواجهة فوراً بدون Restart
  ProductEntity copyWith({
    String? id,
    String? code,
    String? name,
    String? description,
    num? price,
    bool? isFeatured,
    String? imageUrl,
    int? expirationsMonths,
    bool? isOrganic,
    int? numberOfCalories,
    int? unitAmount,
    int? sellingCount,
    num? avgRating,
    num? ratingCount,
    List<ReviewEntity>? reviews,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      isFeatured: isFeatured ?? this.isFeatured,
      imageUrl: imageUrl ?? this.imageUrl,
      expirationsMonths: expirationsMonths ?? this.expirationsMonths,
      isOrganic: isOrganic ?? this.isOrganic,
      numberOfCalories: numberOfCalories ?? this.numberOfCalories,
      unitAmount: unitAmount ?? this.unitAmount,
      sellingCount: sellingCount ?? this.sellingCount,
      avgRating: avgRating ?? this.avgRating,
      ratingCount: ratingCount ?? this.ratingCount,
      reviews: reviews ?? this.reviews,
    );
  }

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      isFeatured: json['isFeatured'],
      imageUrl: json['imageUrl'],
      expirationsMonths: json['expirationsMonths'],
      isOrganic: json['isOrganic'] ?? false,
      numberOfCalories: json['numberOfCalories'],
      unitAmount: json['unitAmount'],
      sellingCount: json['sellingCount'] ?? 0,
      avgRating: json['avgRating'] ?? 0,
      ratingCount: json['ratingCount'] ?? 0,
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((x) => ReviewEntity.fromJson(x))
          .toList(),
      code: json['code'] ?? '',
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
      'reviews': reviews.map((r) => r.toJson()).toList(),
      'code': code,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    reviews,
    avgRating,
    ratingCount,
  ]; // أضفنا الحقول المتغيرة لضمان تحديث الـ UI عند تغيرها
}


// class ProductEntity extends Equatable {
//   final String id;
//   final String name;
//   final String code;
//   final String description;
//   final num price;
//   final bool isFeatured;
//   final String? imageUrl;
//   final int expirationsMonths;
//   final bool isOrganic;
//   final int numberOfCalories;
//   final num avgRating;
//   final num ratingCount;
//   final int unitAmount;
//   final List<ReviewEntity> reviews;
//
//   const ProductEntity({
//     required this.id,
//     required this.name,
//     required this.code,
//     required this.description,
//     required this.price,
//     required this.reviews,
//     required this.expirationsMonths,
//     required this.numberOfCalories,
//     required this.unitAmount,
//     this.isOrganic = false,
//     required this.isFeatured,
//     this.imageUrl,
//     this.avgRating = 0,
//     this.ratingCount = 0,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'code': code,
//     'description': description,
//     'price': price,
//     'reviews': reviews.map((x) => x.toJson()).toList(),
//     'expirationsMonths': expirationsMonths,
//     'numberOfCalories': numberOfCalories,
//     'unitAmount': unitAmount,
//     'isOrganic': isOrganic,
//     'isFeatured': isFeatured,
//     'imageUrl': imageUrl,
//     'avgRating': avgRating,
//     'ratingCount': ratingCount,
//   };
//
//   factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
//     id: json['id'],
//     name: json['name'],
//     code: json['code'],
//     description: json['description'],
//     price: json['price'],
//     reviews: (json['reviews'] as List<dynamic>)
//         .map((x) => ReviewEntity.fromJson(x))
//         .toList(),
//     expirationsMonths: json['expirationsMonths'],
//     numberOfCalories: json['numberOfCalories'],
//     unitAmount: json['unitAmount'],
//     isOrganic: json['isOrganic'] ?? false,
//     isFeatured: json['isFeatured'],
//     imageUrl: json['imageUrl'],
//     avgRating: json['avgRating'] ?? 0,
//     ratingCount: json['ratingCount'] ?? 0,
//   );
//
//   @override
//   List<Object?> get props => [code];
// }
