import 'package:equatable/equatable.dart';
import 'package:fruits/core/entities/review_entity.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String code;
  final String description;
  final num price;
  final bool isFeatured;
  final String? imageUrl;
  final int expirationsMonths;
  final bool isOrganic;
  final int numberOfCalories;
  final num avgRating;
  final num ratingCount;
  final int unitAmount;
  final List<ReviewEntity> reviews;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.price,
    required this.reviews,
    required this.expirationsMonths,
    required this.numberOfCalories,
    required this.unitAmount,
    this.isOrganic = false,
    required this.isFeatured,
    this.imageUrl,
    this.avgRating = 0,
    this.ratingCount = 0,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'code': code,
    'description': description,
    'price': price,
    'reviews': reviews.map((x) => x.toJson()).toList(),
    'expirationsMonths': expirationsMonths,
    'numberOfCalories': numberOfCalories,
    'unitAmount': unitAmount,
    'isOrganic': isOrganic,
    'isFeatured': isFeatured,
    'imageUrl': imageUrl,
    'avgRating': avgRating,
    'ratingCount': ratingCount,
  };

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
    id: json['id'],
    name: json['name'],
    code: json['code'],
    description: json['description'],
    price: json['price'],
    reviews: (json['reviews'] as List<dynamic>)
        .map((x) => ReviewEntity.fromJson(x))
        .toList(),
    expirationsMonths: json['expirationsMonths'],
    numberOfCalories: json['numberOfCalories'],
    unitAmount: json['unitAmount'],
    isOrganic: json['isOrganic'] ?? false,
    isFeatured: json['isFeatured'],
    imageUrl: json['imageUrl'],
    avgRating: json['avgRating'] ?? 0,
    ratingCount: json['ratingCount'] ?? 0,
  );

  @override
  List<Object?> get props => [code];
}
