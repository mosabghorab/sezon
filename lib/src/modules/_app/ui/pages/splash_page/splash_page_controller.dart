import 'package:get/get.dart';
import 'package:sezon/src/config/shared_data.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';
import 'package:sezon/src/modules/_app/app_router.dart';
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
    SharedPreferencesManager.instance.getUserData();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (SharedData.currentUser == null) {
        Get.offAllNamed(AuthRouter.signIn);
      } else {
        Get.offAllNamed(AppRouter.main);
      }
    });
  }
}
