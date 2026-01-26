import 'package:fruits/views/shipping/data/models/order_product_model.dart';
import 'package:fruits/views/shipping/data/models/shipping_address_model.dart';
import 'package:fruits/views/shipping/shipping%20_entites/order_entity.dart';
import 'package:uuid/uuid.dart';

class OrderModel {
  final double totalPrice;
  final String uId;
  final ShippingAddressModel shippingAddressModel;
  final List<OrderProductModel> orderProducts;
  final String paymentMethod;
  final String orderId;

  OrderModel({
    required this.totalPrice,
    required this.uId,
    required this.orderId,
    required this.shippingAddressModel,
    required this.orderProducts,
    required this.paymentMethod,
  });

  factory OrderModel.fromEntity(OrderEntity orderEntity) {
    return OrderModel(
      orderId: const Uuid().v4(),
      // نستخدم السعر النهائي شامل الشحن والخصم
      totalPrice: orderEntity.calculateTotalPriceAfterDiscountAndShipping(),
      uId: orderEntity.uID,
      shippingAddressModel:
      ShippingAddressModel.fromEntity(orderEntity.shippingAddress),
      orderProducts: orderEntity.cartItems.items
          .map((e) => OrderProductModel.fromEntity(
        cartItemEntity: e,
      ))
          .toList(),
      // تعديل: نأخذ القيمة مباشرة من الـ Entity (سواء كانت Cash أو Paypal أو Stripe)
      paymentMethod: orderEntity.paymentMethod ?? 'Cash',
    );
  }

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'totalPrice': totalPrice,
    'uId': uId,
    'status': 'pending',
    'date': DateTime.now().toString(),
    'shippingAddressModel': shippingAddressModel.toJson(),
    'orderProducts': orderProducts.map((e) => e.toJson()).toList(),
    'paymentMethod': paymentMethod,
  };
}