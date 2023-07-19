import 'package:get/get.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';
import 'package:sezon/src/modules/_app/app_router.dart';
import 'package:sezon/src/modules/auth/auth_router.dart';
import 'package:sezon/src/modules/auth/data_sources/remote_data_source/firebase_data_source/auth_service.dart';

class SettingsPageController extends GetxController {
  // services.
  late final AuthService _authService = AuthService.instance;

  // navigate to edit profile page.
  void navigateToEditProfilePage() {
    Get.toNamed(AppRouter.editProfilePage);
  }

  // sign out.
  void signOut() async {
    Helpers.showConfirmation(
      title: 'تسجيل الخروج',
      description: 'هل أنت متأكد من تسجيل خروجك من هذا الحساب؟',
      confirmText: 'خروج',
      onConfirm: () async {
        Helpers.showLoading(title: 'جاري تسجيل الخروج');
        await _authService.signOut();
        SharedPreferencesManager.instance.clearUserData();
        Get.back();
        Get.toNamed(AuthRouter.signInPage);
      },
    );
  }
}
