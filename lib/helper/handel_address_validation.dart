import 'package:flutter/animation.dart';

void handleAddressValidation(dynamic formKey) {
  if (formKey.currentState!.validate()) {
    formKey.currentState!.save();
    var pageController;
    pageController.nextPage(
      duration: Duration(milliseconds: 200),
      curve: Curves.bounceIn,
    );
  }
}
