import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fruits/views/shipping/payment_section.dart';
import 'package:fruits/views/shipping/shipping_address_section.dart';
import 'package:fruits/views/shipping/shipping_section.dart';
import 'package:fruits/views/shipping/top_shiiping_list.dart';

class ShippingPageView extends StatelessWidget {
  const ShippingPageView({
    super.key,
    required this.pageController, required this.formKey, required this.valueListenable,
  });

  final PageController pageController;
final ValueListenable<AutovalidateMode> valueListenable;
  final GlobalKey<FormState> formKey;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: PageView.builder(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: getPages().length,
        itemBuilder: (context, index) {
          return getPages()[index];
        },
      ),
    );
  }

  List<Widget> getPages() {

    return [
      ShippingSection(),
      ShippingAddressSection(
        formKey: formKey,
        valueListenable: valueListenable,
      ),
      PaymentSection(
        pageController: pageController,
      ),
    ];
  }


}