import 'dart:ui';

import 'package:get/get.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';
import 'package:sezon/src/modules/_app/app_router.dart';
import 'package:sezon/src/modules/auth/auth_router.dart';
import 'package:sezon/src/modules/auth/services/auth_service.dart';

class SettingsPageController extends GetxController {
  // services.
  late final AuthService _authService = Get.find<AuthService>();

  // navigate to edit profile page.
  void navigateToEditProfilePage() {
    Get.toNamed(AppRouter.editProfilePage);
  }

  // sign out.
  void signOut() async {
    Helpers.showConfirmation(
      title: 'Sign Out'.tr,
      description: 'Are you sure you want to sign out from this account?'.tr,
      confirmText: 'Sign Out'.tr,
      onConfirm: () async {
        Helpers.showLoading(title: 'Signing Out'.tr);
        await _authService.signOut();
        SharedPreferencesManager.instance.clearUserData();
        Get.back();
        Get.offAllNamed(AuthRouter.signInPage);
      },
    );
  }

  // change language.
  void changeLanguage() async {
    Get.updateLocale(Locale(
        SharedPreferencesManager.instance.getAppLang() == 'en' ? 'ar' : 'en'));
    SharedPreferencesManager.instance.setAppLang(
        SharedPreferencesManager.instance.getAppLang() == 'en' ? 'ar' : 'en');
    Get.offAllNamed(AppRouter.navbarPage);
  }
}
