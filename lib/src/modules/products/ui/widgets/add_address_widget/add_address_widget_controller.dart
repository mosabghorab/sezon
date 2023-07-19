import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/products/models/order_address.dart';

class AddAddressWidgetController extends GetxController {
  // form key.
  late final GlobalKey<FormState> formKey = GlobalKey();

  // fields.
  String? country;
  String? city;
  String? region;
  String? street;
  String? zipCode;

  // constructor fields.
  final OrderAddress? orderAddress;

  // constructor.
  AddAddressWidgetController({
    this.orderAddress,
  });

  // navigate order address back to checkout page.
  void navigateOrderAddressBackToCheckoutPage() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    Get.back(
      result: OrderAddress(
        country: country,
        city: city,
        region: region,
        street: street,
        zipCode: zipCode,
      ),
    );
  }
}
