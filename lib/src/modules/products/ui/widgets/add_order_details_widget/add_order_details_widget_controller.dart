import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/products/models/order_details.dart';

class AddOrderDetailsWidgetController extends GetxController {
  // form key.
  late final GlobalKey<FormState> formKey = GlobalKey();

  // fields.
  String? quantity;
  String? color;
  String? size;

  // constructor fields.
  final OrderDetails? orderDetails;

  // constructor.
  AddOrderDetailsWidgetController({
    this.orderDetails,
  });

  // navigate order details back to checkout page.
  void navigateOrderDetailsBackToCheckoutPage() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    Get.back(
      result: OrderDetails(
        quantity: quantity,
        color: color,
        size: size,
      ),
    );
  }
}
