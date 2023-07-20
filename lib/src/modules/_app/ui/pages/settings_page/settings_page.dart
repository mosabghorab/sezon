import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/ui/pages/settings_page/settings_page_controller.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_app_bar_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/settings_item_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // controller.
  late final SettingsPageController _settingsPageController =
      Get.find<SettingsPageController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    Get.delete<SettingsPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Settings'.tr,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.h),
          child: Column(
            children: [
              SettingsItemWidget(
                onTap: _settingsPageController.navigateToEditProfilePage,
                icon: Icons.person,
                title: 'Profile'.tr,
              ),
              10.verticalSpace,
              SettingsItemWidget(
                onTap: _settingsPageController.changeLanguage,
                icon: Icons.language,
                title: 'Change Language'.tr,
              ),
              10.verticalSpace,
              SettingsItemWidget(
                onTap: _settingsPageController.signOut,
                icon: Icons.exit_to_app,
                title: 'Sign Out'.tr,
                textColor: Colors.red,
                iconColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
