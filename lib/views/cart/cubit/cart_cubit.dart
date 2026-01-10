import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:fruits/cart_entities/cart_item_entity.dart';
import 'package:fruits/cart_entities/cart_list_entity.dart';
import 'package:fruits/core/entities/product_entity.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/shared_prefrence.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    _loadTheme();
    _loadCart();
  }

  CartListEntity cartListEntity = CartListEntity(items: []);
  bool isDarkMode = false;

  // ================== ADD ITEM ==================
  void addItem(ProductEntity productEntity) {
    if (cartListEntity.isExis(productEntity)) {
      cartListEntity.getCarItem(productEntity).increaseCount();
    } else {
      cartListEntity.addItem(CartItemEntity(product: productEntity));
    }
    _saveCart();
    emit(CartUpdated());
  }

  // ================== REMOVE ITEM ==================
  void removeProduct(ProductEntity productEntity) {
    if (cartListEntity.isExis(productEntity)) {
      final item = cartListEntity.getCarItem(productEntity);
      cartListEntity.removeItem(item);
      _saveCart();
      emit(CartUpdated());
    }
  }

  // ================== INCREASE / DECREASE ==================
  void increaseItem(ProductEntity productEntity) {
    if (cartListEntity.isExis(productEntity)) {
      cartListEntity.getCarItem(productEntity).increaseCount();
      _saveCart();
      emit(CartUpdated());
    }
  }

  void decreaseItem(ProductEntity productEntity) {
    if (cartListEntity.isExis(productEntity)) {
      final item = cartListEntity.getCarItem(productEntity);
      final didDecrease = item.decreaseCount();
      if (!didDecrease) {
        cartListEntity.removeItem(item);
      }
      _saveCart();
      emit(CartUpdated());
    }
  }

  bool isInCart(ProductEntity productEntity) {
    return cartListEntity.isExis(productEntity);
  }

  // ================= THEME =================
  void _loadTheme() {
    isDarkMode = Prefs.getBool('isDarkMode') ?? false;
    _updateColors();
    emit(ChangeMode(isDarkMode));
  }

  void changeMode(bool value) {
    isDarkMode = value;
    Prefs.setBool('isDarkMode', isDarkMode);
    _updateColors();
    emit(ChangeMode(isDarkMode));
  }

  void _updateColors() {
    AppColors.mainColor = isDarkMode ? AppColors.mainBlack : AppColors.mainWhite;
  }

  // ================== SAVE / LOAD CART ==================
  void _saveCart() {
    final jsonList = cartListEntity.items.map((e) => e.toJson()).toList();
    Prefs.setString('cartItems', jsonEncode(jsonList));
  }

  void _loadCart() {
    final cartJsonString = Prefs.getString('cartItems') ?? '';

    if (cartJsonString.isEmpty) {
      cartListEntity = CartListEntity(items: []);
      emit(CartUpdated());
      return;
    }

    try {
      final List<dynamic> jsonList = jsonDecode(cartJsonString);
      cartListEntity = CartListEntity(
        items: jsonList.map((item) {
          final map = item as Map<String, dynamic>;
          final cartItem = CartItemEntity.fromJson(map);
          cartItem.count = map['count'] ?? 1; // ✅ count محفوظ
          return cartItem;
        }).toList(),
      );
      emit(CartUpdated());
    } catch (e) {
      cartListEntity = CartListEntity(items: []);
      emit(CartUpdated());
    }
  }
}
