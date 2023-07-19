import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/ui/pages/edit_profile_screen/edit_profile_screen_controller.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_app_bar_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_button_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_text_field_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // controller.
  late final EditProfileScreenController _editProfileScreenController =
      Get.find<EditProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'الملف الشخصي',
        elevation: 0.5,
      ),
      body: Container(
        padding: EdgeInsets.all(16.h),
        child: Form(
          key: _editProfileScreenController.formKey,
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 50.h,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Get.theme.colorScheme.secondary,
                  ),
                  child: Center(
                    child: Text(
                      'AM',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
              30.verticalSpace,
              CustomTextFieldWidget(
                initialValue: _editProfileScreenController.name,
                title: 'الاسم',
                hintText: 'ادخل الاسم',
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الاسم مطلوب';
                  }
                  return null;
                },
                onSaved: (value) =>
                    _editProfileScreenController.name = value!.trim(),
              ),
              15.verticalSpace,
              CustomButtonWidget(
                title: 'حفظ',
                onTap: _editProfileScreenController.editUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
