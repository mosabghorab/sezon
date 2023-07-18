import 'package:get/get.dart';
import 'package:sezon/src/modules/auth/auth_router.dart';
import 'package:sezon/src/start_up.dart';

class SplashPageController extends GetxController {
  @override
  void onReady() {
    init();
    super.onReady();
  }

  // init.
  void init() async {
    await StartUp.initAfterAppBuilding();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Get.toNamed(AuthRouter.signIn);
    });
  }
}
