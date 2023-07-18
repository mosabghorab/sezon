import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        radius: 18.r,
        child: ImageFade(
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
          image: const NetworkImage(
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=800',
          ),
          loadingBuilder: (context, progress, chunkEvent) => Center(
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
              Icons.broken_image_rounded,
              color: Colors.black,
              size: 15.h,
            ),
          ),
        ),
      ),
    );
  }
}
