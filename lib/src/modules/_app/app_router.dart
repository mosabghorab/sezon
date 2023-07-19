import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/ui/pages/edit_profile_screen/edit_profile_screen.dart';
import 'package:sezon/src/modules/_app/ui/pages/edit_profile_screen/edit_profile_screen_controller.dart';
import 'package:sezon/src/modules/_app/ui/pages/navbar_page/navbar_page.dart';
import 'package:sezon/src/modules/_app/ui/pages/navbar_page/navbar_page_controller.dart';
import 'package:sezon/src/modules/_app/ui/pages/splash_page/splash_page.dart';
import 'package:sezon/src/modules/_app/ui/pages/splash_page/splash_page_controller.dart';
import 'package:sezon/src/modules/auth/auth_router.dart';
import 'package:sezon/src/modules/products/products_router.dart';

class AppRouter {
  static const String splashPage = '/';
  static const String navbarPage = '/NavbarPage';
  static const String editProfilePage = '/EditProfilePage';

  static List<GetPage> routes = [
    ..._routes,
    ...AuthRouter.routes,
    ...ProductsRouter.routes,
  ];

  // routes.
  static final List<GetPage> _routes = [
    GetPage(
      name: splashPage,
      page: () => Builder(builder: (context) {
        Get.put<SplashPageController>(SplashPageController());
        return const SplashPage();
      }),
    ),
    GetPage(
      name: navbarPage,
      page: () => Builder(builder: (context) {
        Get.put<NavbarPageController>(NavbarPageController());
        return const NavbarPage();
      }),
    ),
    GetPage(
      name: editProfilePage,
      page: () => Builder(builder: (context) {
        Get.put<EditProfileScreenController>(EditProfileScreenController());
        return const EditProfileScreen();
      }),
    ),
  ];
}
