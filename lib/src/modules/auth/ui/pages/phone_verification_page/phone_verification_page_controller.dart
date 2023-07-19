import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/core/enums.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';
import 'package:sezon/src/modules/_app/app_router.dart';
import 'package:sezon/src/modules/auth/data_sources/remote_data_source/firebase_data_source/auth_service.dart';
import 'package:sezon/src/modules/auth/models/app_user.dart';

class PhoneVerificationPageController extends GetxController {
  // services.
  late final AuthService _authService = AuthService.instance;

  // fields.
  String? otp;

  // vars.
  String? verificationId;

  // arguments.
  String? phone;
  String? name;

  // on init.
  @override
  void onInit() {
    phone = Get.arguments['phone'];
    name = Get.arguments['name'];
    sendCode();
    super.onInit();
  }

  // send code.
  void sendCode() {
    _authService.sendCode(
      phoneNumber: phone!,
      verificationCompleted: _verificationCompleted,
      codeSent: _codeSent,
      verificationFailed: _verificationFailed,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
  }

  // verification completed.
  void _verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    try {
      Helpers.showLoading();
      AppUser? appUser = await _authService.signInWithPhone(
        verificationId: verificationId!,
        smsCode: otp!,
        phone: phone,
        name: name,
      );
      if (appUser != null) {
        // success.
        Get.back();
        Get.toNamed(AppRouter.navbarPage);
      } else {
        // failed.
        Get.back();
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

  // verification failed.
  void _verificationFailed(FirebaseAuthException error) {
    // failed.
    debugPrint(error.toString());
    Helpers.showMessage(
        text: error.toString(), messageType: MessageType.failureMessage);
    // timer = null;
    // canTimerContinue = false;
  }

  // code sent.
  void _codeSent(
    String verificationId,
    int? forceResendingToken,
  ) {
    debugPrint('starting [codeSent][PhoneOtpVerificationScreenNotifier]...');
    this.verificationId = verificationId;
    Helpers.showMessage(
        text: 'تم ارسال الكود بنجاح', messageType: MessageType.successMessage);
  }

  // code auto retrieval timeout.
  void _codeAutoRetrievalTimeout(String verificationId) {
    debugPrint(
        'starting [codeAutoRetrievalTimeout][PhoneOtpVerificationScreenNotifier]...');
  }

  // verify code.
  void verifyCode() async {
    try {
      if (otp == null) {
        Helpers.showMessage(
            text: 'الرجاء ادخال كود التفعيل',
            messageType: MessageType.failureMessage);
        return;
      }
      Helpers.showLoading();
      AppUser? appUser = await _authService.signInWithPhone(
        verificationId: verificationId!,
        smsCode: otp!,
        phone: phone,
        name: name,
      );
      if (appUser != null) {
        // success.
        Get.back();
        await SharedPreferencesManager.instance.setUserData(appUser);
        Get.toNamed(AppRouter.navbarPage);
      } else {
        // failed.
        Get.back();
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
}
