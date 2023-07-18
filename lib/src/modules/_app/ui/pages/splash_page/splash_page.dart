import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/pages/splash_page/splash_page_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // controller.
  late final SplashPageController _splashScreenController =
      Get.find<SplashPageController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    _splashScreenController.dispose();
    Get.delete<SplashPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEB5D1C),
      body: Center(
        child: Image.asset(
          '${Constants.assetsImagesPath}logo.png',
          height: 170.h,
        ),
      ),
    );
  }
}
