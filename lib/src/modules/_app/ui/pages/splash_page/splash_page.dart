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

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  // controller.
  late final SplashPageController _splashScreenController =
      Get.find<SplashPageController>();

  // animations controllers.
  late final AnimationController _scaleAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 800));
  late final AnimationController _fadeAnimationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 800));

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    _splashScreenController.dispose();
    Get.delete<SplashPageController>();
    _scaleAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEB5D1C),
      body: Center(
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0)
              .animate(_scaleAnimationController..forward()),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0)
                .animate(_fadeAnimationController..forward()),
            child: Image.asset(
              '${Constants.assetsImagesPath}logo.png',
              height: 170.h, // updated.
            ),
          ),
        ),
      ),
    );
  }
}
