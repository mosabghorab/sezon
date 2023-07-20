import 'package:get/get.dart';
import 'package:sezon/src/config/shared_data.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';
import 'package:sezon/src/modules/_app/app_router.dart';
import 'package:sezon/src/modules/auth/auth_router.dart';
import 'package:sezon/src/start_up.dart';

class SplashPageController extends GetxController {
  // on init.
  @override
  void onInit() {
    init();
    super.onInit();
  }

  // init.
  void init() async {
    await StartUp.initAfterAppBuilding();
    SharedPreferencesManager.instance.getUserData();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (SharedData.currentUser == null) {
        Get.offAllNamed(AuthRouter.signInPage);
      } else {
        Get.offAllNamed(AppRouter.navbarPage);
      }
    });
  }
}
