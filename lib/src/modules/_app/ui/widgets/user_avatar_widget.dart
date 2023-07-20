import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';
import 'package:sezon/src/config/shared_data.dart';
import 'package:sezon/src/modules/_app/app_router.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRouter.editProfilePage);
      },
      child: ClipOval(
        child: CircleAvatar(
          radius: 18.r,
          backgroundColor: Get.theme.primaryColor,
          child: ImageFade(
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            image: NetworkImage(
              SharedData.currentUser!.avatar ?? '',
            ),
            loadingBuilder: (context, progress, chunkEvent) => Center(
              child: SizedBox(
                width: 15.h,
                height: 15.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.white,
                ),
              ),
            ),
            errorBuilder: (context, error) => Center(
              child: Icon(
                Icons.broken_image_rounded,
                color: Colors.black,
                size: 15.h,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
