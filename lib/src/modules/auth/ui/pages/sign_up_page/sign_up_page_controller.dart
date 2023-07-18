import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/core/enums.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/modules/auth/auth_router.dart';
import 'package:sezon/src/modules/auth/data/data_sources/remote_data_source/firebase_data_source/users_service.dart';

class SignUpPageController extends GetxController {
  // form key.
  late final GlobalKey<FormState> formKey = GlobalKey();

  // services.
  late final UsersService _usersService = UsersService.instance;

  // fields.
  String? phone;
  String? name;

  // sign up.
  void signUp() async {
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
        if (!result) {
          Get.toNamed(
            AuthRouter.phoneVerification,
            arguments: {
              'phone': phone,
              'name': name,
            },
          );
        } else {
          Helpers.showMessage(
              text: 'رقم الهاتف موجود مسبقاً',
              messageType: MessageType.failureMessage);
        }
      } else {
        // failed.
        Helpers.showMessage(
            text: 'حدث خطأ ما', messageType: MessageType.failureMessage);
      }
    } catch (error) {
      // error.
      debugPrint('error : $error');
      Get.back();
      Helpers.showMessage(
          text: error.toString(), messageType: MessageType.failureMessage);
    }
  }

  // navigate back to sign in page.
  void navigateBackToSignInPage() {
    Get.back();
  }
}
