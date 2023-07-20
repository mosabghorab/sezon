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
    Get.delete<SignInPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _signInPageController.formKey,
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
                'Sign In'.tr,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              15.verticalSpace,
              Container(
                padding: EdgeInsets.all(24.h),
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: CustomTextFieldWidget(
                        title: 'Phone Number'.tr,
                        hintText: 'Enter phone number'.tr,
                        isMobile: true,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required'.tr;
                          }
                          return null;
                        },
                        onSaved: (value) => _signInPageController.phone = value,
                      ),
                    ),
                    30.verticalSpace,
                    CustomButtonWidget(
                      title: 'Sign In'.tr,
                      onTap: _signInPageController.signIn,
                    ),
                    30.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${'You dont have an account?'.tr} '),
                        InkWell(
                          onTap: _signInPageController.navigateToSignUpPage,
                          child: Text(
                            'Sign Up'.tr,
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
      ),
    );
  }
}
