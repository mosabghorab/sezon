import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';
import 'package:sezon/src/config/shared_data.dart';
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

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    Get.delete<EditProfileScreenController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Profile'.tr,
        elevation: 0.5,
      ),
      body: Container(
        padding: EdgeInsets.all(16.h),
        child: Form(
          key: _editProfileScreenController.formKey,
          child: Column(
            children: [
              InkWell(
                onTap: _editProfileScreenController.pickImage,
                child: ClipOval(
                  child: CircleAvatar(
                    radius: 45.r,
                    backgroundColor: Get.theme.primaryColor,
                    child: GetBuilder<EditProfileScreenController>(
                        id: 'profileAvatar',
                        builder: (controller) =>
                            controller.profileAvatar != null
                                ? Image.file(
                                    controller.profileAvatar!,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : ImageFade(
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      SharedData.currentUser!.avatar ?? '',
                                    ),
                                    loadingBuilder:
                                        (context, progress, chunkEvent) =>
                                            Center(
                                      child: SizedBox(
                                        width: 15.h,
                                        height: 15.h,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                          color: Get.theme.primaryColor,
                                        ),
                                      ),
                                    ),
                                    errorBuilder: (context, error) => Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: 30.h,
                                      ),
                                    ),
                                  )),
                  ),
                ),
              ),
              30.verticalSpace,
              CustomTextFieldWidget(
                initialValue: _editProfileScreenController.name,
                title: 'Name'.tr,
                hintText: 'Enter name'.tr,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required'.tr;
                  }
                  return null;
                },
                onSaved: (value) =>
                    _editProfileScreenController.name = value!.trim(),
              ),
              15.verticalSpace,
              CustomButtonWidget(
                title: 'Save'.tr,
                onTap: _editProfileScreenController.editUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
