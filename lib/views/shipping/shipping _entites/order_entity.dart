import 'package:fruits/cart_entities/cart_item_entity.dart';
import 'package:fruits/cart_entities/cart_list_entity.dart';
import 'package:fruits/views/shipping/shipping%20_entites/shipping_address_entity.dart';

class OrderEntity {
  final String uID;
  final CartListEntity cartItems;

  // تعديل: نستخدم String لتحديد طريقة الدفع بدقة
  // القيم المتوقعة: 'Cash', 'Paypal', 'Stripe'
  String? paymentMethod;

  ShippingAddressEntity shippingAddress = ShippingAddressEntity();

  OrderEntity({required this.cartItems, this.paymentMethod, required this.uID});

  double calculateShippingCost() {
    // إذا كان كاش، مصاريف الشحن 30، غير ذلك (Stripe أو Paypal) مجاناً
    if (paymentMethod == 'Cash') {
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
    return 'OrderEntity{uID: $uID, cartEntity: $cartItems, paymentMethod: $paymentMethod, shippingAddressEntity: $shippingAddress}';
  }
}