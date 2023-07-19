import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/auth/ui/pages/phone_verification_page/phone_verification_page.dart';
import 'package:sezon/src/modules/auth/ui/pages/phone_verification_page/phone_verification_page_controller.dart';
import 'package:sezon/src/modules/auth/ui/pages/sign_in_page/sign_in_page.dart';
import 'package:sezon/src/modules/auth/ui/pages/sign_in_page/sign_in_page_controller.dart';
import 'package:sezon/src/modules/auth/ui/pages/sign_up_page/sign_up_page.dart';
import 'package:sezon/src/modules/auth/ui/pages/sign_up_page/sign_up_page_controller.dart';

class AuthRouter {
  static const String signInPage = '/SignInPage';
  static const String signUpPage = '/SignUpPage';
  static const String phoneVerificationPage = '/PhoneVerificationPage';

  static List<GetPage> routes = [
    GetPage(
      name: signInPage,
      page: () => Builder(builder: (context) {
        Get.put<SignInPageController>(SignInPageController());
        return const SignInPage();
      }),
    ),
    GetPage(
      name: signUpPage,
      page: () => Builder(builder: (context) {
        Get.put<SignUpPageController>(SignUpPageController());
        return const SignUpPage();
      }),
    ),
    GetPage(
      name: phoneVerificationPage,
      page: () => Builder(builder: (context) {
        Get.put<PhoneVerificationPageController>(
            PhoneVerificationPageController());
        return const PhoneVerificationPage();
      }),
    ),
  ];
}
