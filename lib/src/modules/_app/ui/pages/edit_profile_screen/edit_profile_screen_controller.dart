import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/core/enums.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/config/shared_data.dart';
import 'package:sezon/src/managers/firebase_storage_manager.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';
import 'package:sezon/src/modules/_app/app_router.dart';
import 'package:sezon/src/modules/_app/ui/widgets/pick_images_widget.dart';
import 'package:sezon/src/modules/auth/models/app_user.dart';
import 'package:sezon/src/modules/auth/services/users_service.dart';

class EditProfileScreenController extends GetxController {
  // notifiable.
  void notifyProfileAvatar() {
    update(['profileAvatar']);
  }

  // profile avatar.
  File? profileAvatar;
  String? avatarUrl;

  // form key.
  late final GlobalKey<FormState> formKey = GlobalKey();

  // services.
  late final UsersService _usersService = Get.find<UsersService>();

  // fields.
  String name = SharedData.currentUser!.name!;

  // edit user.
  Future<void> editUser() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    Helpers.showLoading(title: 'Saving'.tr);
    if (profileAvatar != null) {
      avatarUrl = await FirebaseStorageManager.instance.uploadFile(
        file: profileAvatar!,
      );
    }
    AppUser? appUser = await _usersService.editUser(
      name: name,
      avatar: avatarUrl,
    );
    Get.back();
    if (appUser != null) {
      await SharedPreferencesManager.instance.setUserData(appUser);
      Get.offAllNamed(AppRouter.navbarPage);
    } else {
      Helpers.showMessage(
          text: 'Something went wrong'.tr,
          messageType: MessageType.failureMessage);
    }
  }

  // pick image.
  void pickImage() async {
    List<File>? images = await Helpers.showBottomSheet(
      child: const PickImagesWidget(),
    );
    if (images != null && images.isNotEmpty) {
      profileAvatar = images.first;
      notifyProfileAvatar();
    }
  }
}
