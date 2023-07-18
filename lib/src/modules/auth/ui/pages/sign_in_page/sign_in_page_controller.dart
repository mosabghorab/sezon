import 'package:get/get.dart';
import 'package:sezon/src/modules/auth/auth_router.dart';

class SignInPageController extends GetxController {

  // fields.
  String? phone;

  // sign in.
  void signIn() {
    Get.toNamed(
      AuthRouter.phoneVerification,
      arguments: {'phone': '+970592510826'},
    );
  }

  // void navigate to sign up page.
  void navigateToSignUpPage() {
    Get.toNamed(AuthRouter.signUp);
  }
}
