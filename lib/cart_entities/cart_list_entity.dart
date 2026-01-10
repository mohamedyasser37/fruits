import 'dart:convert';
import 'package:fruits/cart_entities/cart_item_entity.dart';
import 'package:fruits/core/entities/product_entity.dart';

class CartListEntity {
  List<CartItemEntity> items;

  CartListEntity({required this.items});

  void addItem(CartItemEntity item) => items.add(item);

  void removeItem(CartItemEntity item) => items.remove(item);

  void clearCart() => items.clear();

  double calculateTotalPrice() =>
      items.fold(0, (total, item) => total + item.getSubTotal());

  bool isExis(ProductEntity product) =>
      items.any((cartItem) => cartItem.product == product);

  CartItemEntity getCarItem(ProductEntity product) => items.firstWhere(
        (cartItem) => cartItem.product == product,
    orElse: () => CartItemEntity(product: product, count: 1),
  );

  // ================= JSON =================
  Map<String, dynamic> toJson() => {
    'items': items.map((e) => e.toJson()).toList(),
  };

  factory CartListEntity.fromJson(Map<String, dynamic> json) => CartListEntity(
    items: (json['items'] as List)
        .map((e) => CartItemEntity.fromJson(e))
        .toList(),
  );

  String encodeToString() => jsonEncode(toJson());

  factory CartListEntity.decodeFromString(String jsonString) =>
      CartListEntity.fromJson(jsonDecode(jsonString));
}
