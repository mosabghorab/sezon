import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';
import 'package:sezon/src/modules/products/models/category.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;

  const CategoryWidget({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: ImageFade(
            height: 40.h,
            width: 40.h,
            fit: BoxFit.cover,
            image: NetworkImage(
              category.image ?? '',
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
        10.verticalSpace,
        Text(
          category.nameAr ?? '',
        ),
      ],
    );
  }
}
