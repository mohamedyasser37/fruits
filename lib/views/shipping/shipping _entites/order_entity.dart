import 'package:fruits/cart_entities/cart_item_entity.dart';
import 'package:fruits/cart_entities/cart_list_entity.dart';
import 'package:fruits/views/shipping/shipping%20_entites/shipping_address_entity.dart';

class OrderEntity {
  final String uID;
  final CartListEntity cartItems;
  bool? payWithCash;
  ShippingAddressEntity shippingAddress = ShippingAddressEntity();


  OrderEntity({required this.cartItems, this.payWithCash, required this.uID});

  double calculateShippingCost() {
    if (payWithCash!) {
      return 30;
    } else {
      return 0;
    }
  }

  double calcualteShippingDiscount() {
    return 0;
  }

  double calculateTotalPriceAfterDiscountAndShipping() {
    return cartItems.calculateTotalPrice() +
        calculateShippingCost() -
        calcualteShippingDiscount();
  }

  @override
  String toString() {
    return 'OrderEntity{uID: $uID, cartEntity: $cartItems, payWithCash: $payWithCash, shippingAddressEntity: $shippingAddress}';
  }


}