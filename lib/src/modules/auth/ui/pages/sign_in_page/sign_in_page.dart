import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_button_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_text_field_widget.dart';
import 'package:sezon/src/modules/auth/ui/pages/sign_in_page/sign_in_page_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // controller.
  late final SignInPageController _signInPageController =
      Get.find<SignInPageController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    _signInPageController.dispose();
    Get.delete<SignInPageController>();
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
              'تسجيل دخول',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              padding: EdgeInsets.all(24.h),
              child: Column(
                children: [
                  const CustomTextFieldWidget(
                    title: 'رقم الهاتف',
                    hintText: 'ادخل رقم الهاتف',
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('هل نسيت كلمة المرور؟'),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButtonWidget(
                    title: 'تسجيل الدخول',
                    onTap: _signInPageController.signIn,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('ليس لديك حساب؟ '),
                      InkWell(
                        onTap: _signInPageController.navigateToSignUpPage,
                        child: Text(
                          'حساب جديد',
                          style: TextStyle(
                            color: Get.theme.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
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
