import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_button_widget.dart';
import 'package:sezon/src/modules/auth/ui/pages/phone_verification_page/phone_verification_page_controller.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  // controller.
  late final PhoneVerificationPageController _phoneVerificationPageController =
      Get.find<PhoneVerificationPageController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    _phoneVerificationPageController.dispose();
    Get.delete<PhoneVerificationPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  '${Constants.assetsImagesPath}background.png',
                ),
                PositionedDirectional(
                  top: 70.h,
                  start: 0,
                  end: 0,
                  child: Center(
                    child: Image.asset(
                      '${Constants.assetsImagesPath}logo.png',
                      height: 80.h,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'رمز التحقق',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Text(
                'لقد قمنا بارسال رمز التحقق إلى هذا الرقم ${_phoneVerificationPageController.phone}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              padding: EdgeInsets.all(16.h),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Get.theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          fieldHeight: 40.h,
                          fieldWidth: 40.h,
                          borderRadius: BorderRadius.circular(6.r),
                          shape: PinCodeFieldShape.box,
                          activeFillColor: Colors.white,
                          borderWidth: 1,
                          selectedFillColor: Colors.white,
                          activeColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedColor: Get.theme.primaryColor,
                          inactiveColor: Colors.grey.shade300,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        onCompleted: (value) {
                          _phoneVerificationPageController.otp = value;
                          _phoneVerificationPageController.verifyCode();
                        },
                      ),
                    ),
                  ),
                  50.verticalSpace,
                  CustomButtonWidget(
                    title: 'أرسل',
                    onTap: _phoneVerificationPageController.verifyCode,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
