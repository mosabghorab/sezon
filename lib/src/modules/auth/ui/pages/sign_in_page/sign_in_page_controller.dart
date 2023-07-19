import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/core/enums.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/modules/auth/auth_router.dart';
import 'package:sezon/src/modules/auth/data_sources/remote_data_source/firebase_data_source/users_service.dart';

class SignInPageController extends GetxController {
  // form key.
  late final GlobalKey<FormState> formKey = GlobalKey();

  // services.
  late final UsersService _usersService = UsersService.instance;

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
              text: 'رقم الهاتف غير موجود',
              messageType: MessageType.failureMessage);
        }
      } else {
        Helpers.showMessage(
            text: 'حدث خطأ ما', messageType: MessageType.failureMessage);
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
