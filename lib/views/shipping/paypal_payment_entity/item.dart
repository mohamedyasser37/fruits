
import 'package:fruits/cart_entities/cart_item_entity.dart';
import 'package:fruits/helper/get_currency.dart';

class ItemEntity {
  String? name;
  int? quantity;
  String? price;
  String? currency;

  ItemEntity({this.name, this.quantity, this.price, this.currency});

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'price': price,
        'currency': currency,
      };

  factory ItemEntity.fromEntity(CartItemEntity itemEntity) {
    return ItemEntity(
      name: itemEntity.product.name,
      quantity: itemEntity.count,
      price: itemEntity.product.price.toString(),
      currency: getCurrency(),
    );
  }
}
