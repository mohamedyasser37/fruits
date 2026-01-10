import 'package:equatable/equatable.dart';
import 'package:fruits/core/entities/product_entity.dart';

class CartItemEntity extends Equatable {
  final ProductEntity product;
  int count;

  CartItemEntity({
    required this.product,
    this.count = 1,
  });

  void increaseCount() => count++;

  bool decreaseCount() {
    if (count > 0) {
      count--;
      return count > 0; // رجع true لو لسه >0، false لو وصل 0
    }
    return false;
  }


  num getSubTotal() => product.price * count;

  num calculateTotalWeight() => product.unitAmount * count;

  // 🔹 JSON
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'count': count,
    };
  }

  factory CartItemEntity.fromJson(Map<String, dynamic> json) {
    return CartItemEntity(
      product: ProductEntity.fromJson(json['product']),
      count: json['count'] ?? 1, // <--- هنا ناخد count من JSON
    );
  }

  @override
  List<Object?> get props => [product, count];
}
