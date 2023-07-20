import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/core/enums.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/modules/auth/auth_router.dart';
import 'package:sezon/src/modules/auth/services/users_service.dart';

class SignInPageController extends GetxController {
  // form key.
  late final GlobalKey<FormState> formKey = GlobalKey();

  // services.
  late final UsersService _usersService = Get.find<UsersService>();

  // fields.
  String? phone;

  // sign in.
  void signIn() async {
    try {
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      Helpers.showLoading();
      bool? result = await _usersService.checkUserWithPhone(
        phone: phone!,
      );
      Get.back();
      if (result != null) {
        // success.
        if (result) {
          Get.toNamed(
            AuthRouter.phoneVerificationPage,
            arguments: {
              'phone': phone,
            },
          );
        } else {
          Helpers.showMessage(
              text: 'Phone number does not exist'.tr,
              messageType: MessageType.failureMessage);
        }
      } else {
        Helpers.showMessage(
            text: 'Something went wrong'.tr,
            messageType: MessageType.failureMessage);
      }
    } catch (error) {
      debugPrint('error : $error');
      Get.back();
      Helpers.showMessage(
          text: error.toString(), messageType: MessageType.failureMessage);
    }
  }

  // void navigate to sign up page.
  void navigateToSignUpPage() {
    Get.toNamed(AuthRouter.signUpPage);
  }
}
