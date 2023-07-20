import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_button_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_text_field_widget.dart';
import 'package:sezon/src/modules/auth/ui/pages/sign_up_page/sign_up_page_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // controller.
  late final SignUpPageController _signUpPageController =
      Get.find<SignUpPageController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    Get.delete<SignUpPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _signUpPageController.formKey,
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
                'Sign Up'.tr,
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
                    CustomTextFieldWidget(
                      title: 'Name'.tr,
                      hintText: 'Enter name'.tr,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required'.tr;
                        }
                        return null;
                      },
                      onSaved: (value) => _signUpPageController.name = value,
                    ),
                    15.verticalSpace,
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
                        onSaved: (value) => _signUpPageController.phone = value,
                      ),
                    ),
                    30.verticalSpace,
                    CustomButtonWidget(
                      title: 'Sign Up'.tr,
                      onTap: _signUpPageController.signUp,
                    ),
                    30.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${'Do you have an account?'.tr} '),
                        InkWell(
                          onTap: _signUpPageController.navigateBackToSignInPage,
                          child: Text(
                            'Sign In'.tr,
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
