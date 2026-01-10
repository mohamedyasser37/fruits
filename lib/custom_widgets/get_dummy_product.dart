import 'dart:io';

import 'package:fruits/core/entities/product_entity.dart';
import 'package:fruits/core/models/product_model.dart';

ProductModel getDummyProduct() {
  
  return ProductModel(
    name: 'Apple',
    code: '123',
    description: 'Fresh apple',
    price: 2.5,
    expirationsMonths: 6,
    numberOfCalories: 100,
    unitAmount: 1,
    isOrganic: true,
    isFeatured: true,
    imageUrl: null, id: 'fsf',
  );
}

List<ProductModel> getDummyProducts() {
  return [
    getDummyProduct(),
    getDummyProduct(),
    getDummyProduct(),
    getDummyProduct(),
    getDummyProduct(),
  ];
}


