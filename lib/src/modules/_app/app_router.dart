import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/ui/data/models/product.dart';
import 'package:sezon/src/modules/_app/ui/pages/checkout_page/checkout_page.dart';
import 'package:sezon/src/modules/_app/ui/pages/checkout_page/checkout_page_controller.dart';
import 'package:sezon/src/modules/_app/ui/pages/main_page/main_page.dart';
import 'package:sezon/src/modules/_app/ui/pages/main_page/main_page_controller.dart';
import 'package:sezon/src/modules/_app/ui/pages/orders_page/orders_page.dart';
import 'package:sezon/src/modules/_app/ui/pages/orders_page/orders_page_controller.dart';
import 'package:sezon/src/modules/_app/ui/pages/product_details_page/product_details_page.dart';
import 'package:sezon/src/modules/_app/ui/pages/product_details_page/product_details_page_controller.dart';
import 'package:sezon/src/modules/_app/ui/pages/splash_page/splash_page.dart';
import 'package:sezon/src/modules/_app/ui/pages/splash_page/splash_page_controller.dart';
import 'package:sezon/src/modules/auth/auth_router.dart';

class AppRouter {
  static const String splash = '/';
  static const String main = '/Main';
  static const String productDetails = '/ProductDetails';
  static const String ordersPage = '/OrdersPage';
  static const String checkoutPage = '/CheckoutPage';

  static List<GetPage> routes = [
    ..._appRoutes,
    ...AuthRouter.authRoutes,
  ];

  // routes.
  static final List<GetPage> _appRoutes = [
    GetPage(
      name: splash,
      page: () => Builder(builder: (context) {
        Get.put<SplashPageController>(SplashPageController());
        return const SplashPage();
      }),
    ),
    GetPage(
      name: main,
      page: () => Builder(builder: (context) {
        Get.put<MainPageController>(MainPageController());
        return const MainPage();
      }),
    ),
    GetPage(
      name: productDetails,
      page: () => Builder(builder: (context) {
        Get.put<ProductDetailsPageController>(
          ProductDetailsPageController(),
          tag: (Get.arguments['product'] as Product).id,
        );
        return const ProductDetailsPage();
      }),
    ),
    GetPage(
      name: ordersPage,
      page: () => Builder(builder: (context) {
        Get.put<OrdersPageController>(OrdersPageController());
        return const OrdersPage();
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
