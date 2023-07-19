import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/products/models/product.dart';
import 'package:sezon/src/modules/products/ui/pages/checkout_page/checkout_page.dart';
import 'package:sezon/src/modules/products/ui/pages/checkout_page/checkout_page_controller.dart';
import 'package:sezon/src/modules/products/ui/pages/product_details_page/product_details_page.dart';
import 'package:sezon/src/modules/products/ui/pages/product_details_page/product_details_page_controller.dart';

class ProductsRouter {
  static const String productDetailsPage = '/ProductDetailsPage';
  static const String checkoutPage = '/CheckoutPage';

  // routes.
  static final List<GetPage> routes = [
    GetPage(
      name: productDetailsPage,
      page: () => Builder(builder: (context) {
        Get.put<ProductDetailsPageController>(
          ProductDetailsPageController(),
          tag: (Get.arguments['product'] as Product).id,
        );
        return const ProductDetailsPage();
      }),
    ),
    GetPage(
      name: checkoutPage,
      page: () => Builder(builder: (context) {
        Get.put<CheckoutPageController>(CheckoutPageController());
        return const CheckoutPage();
      }),
    ),
  ];
}
