import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/core/enums.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/config/shared_data.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';
import 'package:sezon/src/modules/_app/app_router.dart';
import 'package:sezon/src/modules/auth/data_sources/remote_data_source/firebase_data_source/users_service.dart';
import 'package:sezon/src/modules/auth/models/app_user.dart';

class EditProfileScreenController with ChangeNotifier {
  // form key.
  late final GlobalKey<FormState> formKey = GlobalKey();

  // services.
  late final UsersService _usersService = UsersService.instance;

  // fields.
  String name = SharedData.currentUser!.name!;

  // edit user.
  Future<void> editUser() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    Helpers.showLoading(title: 'جاري الحفظ');
    AppUser? appUser = await _usersService.editUser(
      name: name,
    );
    Get.back();
    if (appUser != null) {
      await SharedPreferencesManager.instance.setUserData(appUser);
      Get.offAllNamed(AppRouter.navbarPage);
    } else {
      Helpers.showMessage(
          text: 'حدث خطأ ما', messageType: MessageType.failureMessage);
    }
  }
}
