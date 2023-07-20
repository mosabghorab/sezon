import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/ui/pages/home_page/home_page.dart';
import 'package:sezon/src/modules/_app/ui/pages/home_page/home_page_controller.dart';
import 'package:sezon/src/modules/_app/ui/pages/settings_page/settings_page.dart';
import 'package:sezon/src/modules/_app/ui/pages/settings_page/settings_page_controller.dart';
import 'package:sezon/src/modules/products/ui/pages/categories_page/categories_page.dart';
import 'package:sezon/src/modules/products/ui/pages/categories_page/categories_page_controller.dart';
import 'package:sezon/src/modules/products/ui/pages/favorite_page/favorite_page.dart';
import 'package:sezon/src/modules/products/ui/pages/favorite_page/favorite_page_controller.dart';
import 'package:sezon/src/modules/products/ui/pages/orders_page/orders_page.dart';
import 'package:sezon/src/modules/products/ui/pages/orders_page/orders_page_controller.dart';

class NavbarPageController extends GetxController {
  // notifiable.
  int _selectedPageIndex = 0;

  int get selectedPageIndex => _selectedPageIndex;

  set selectedPageIndex(int value) {
    _selectedPageIndex = value;
    update(['selectedPageIndex']);
  }

  // pages info.
  List<Map<String, dynamic>> pagesInfo = [
    {
      'title': 'Home'.tr,
      'icon': 'home',
    },
    {
      'title': 'Categories'.tr,
      'icon': 'categories',
    },
    {
      'title': 'My Orders'.tr,
      'icon': 'orders',
    },
    {
      'title': 'Favorite'.tr,
      'icon': 'favorite',
    },
    {
      'title': 'Settings'.tr,
      'icon': 'settings',
    },
  ];

  // pages.
  List<Widget> pages = [
    Builder(builder: (context) {
      Get.put<HomePageController>(HomePageController());
      return const HomePage();
    }),
    Builder(builder: (context) {
      Get.put<CategoriesPageController>(CategoriesPageController());
      return const CategoriesPage();
    }),
    Builder(builder: (context) {
      Get.put<OrdersPageController>(OrdersPageController());
      return const OrdersPage();
    }),
    Builder(builder: (context) {
      Get.put<FavoritePageController>(FavoritePageController());
      return const FavoritePage();
    }),
    Builder(builder: (context) {
      Get.put<SettingsPageController>(SettingsPageController());
      return const SettingsPage();
    }),
  ];

  @override
  void onInit() {
    selectedPageIndex = Get.arguments?['initialIndex'] ?? 0;
    super.onInit();
  }

  // on bottom nav bar tapped.
  void onBottomTapBarTapped(int index) {
    selectedPageIndex = index;
  }
}
