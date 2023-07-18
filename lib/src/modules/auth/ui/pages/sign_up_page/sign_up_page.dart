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
    _signUpPageController.dispose();
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
                'إنشاء حساب جديد',
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
                    CustomTextFieldWidget(
                      title: 'الاسم',
                      hintText: 'ادخل الاسم',
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الاسم مطلوب';
                        }
                        return null;
                      },
                      onSaved: (value) => _signUpPageController.name = value,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextFieldWidget(
                      title: 'رقم الهاتف',
                      hintText: 'ادخل رقم الهاتف',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'رقم الهاتف مطلوب';
                        }
                        return null;
                      },
                      onSaved: (value) => _signUpPageController.phone = value,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomButtonWidget(
                      title: 'تسجيل حساب',
                      onTap: _signUpPageController.signUp,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('هل لديك حساب؟ '),
                        InkWell(
                          onTap: _signUpPageController.navigateBackToSignInPage,
                          child: Text(
                            'تسجيل دخول',
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
