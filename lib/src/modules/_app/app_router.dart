import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/ui/pages/main_page/main_page.dart';
import 'package:sezon/src/modules/_app/ui/pages/main_page/main_page_controller.dart';
import 'package:sezon/src/modules/_app/ui/pages/splash_page/splash_page.dart';
import 'package:sezon/src/modules/_app/ui/pages/splash_page/splash_page_controller.dart';
import 'package:sezon/src/modules/auth/auth_router.dart';

class AppRouter {
  static const String splash = '/';
  static const String main = '/Main';

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
  ];
}
