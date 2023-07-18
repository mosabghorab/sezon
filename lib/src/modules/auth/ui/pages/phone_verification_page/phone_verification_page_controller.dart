import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/app_router.dart';

class PhoneVerificationPageController extends GetxController {
  // arguments.
  late String phone = Get.arguments['phone'];

  // fields.
  String? otp;

  // verify otp.
  void verifyOtp() {
    Get.toNamed(AppRouter.main);
  }
}
