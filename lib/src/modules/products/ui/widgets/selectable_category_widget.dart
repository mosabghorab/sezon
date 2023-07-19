import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';
import 'package:sezon/src/modules/products/models/category.dart';

class SelectableCategoryWidget extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableCategoryWidget({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.h),
                child: Column(
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
                        loadingBuilder: (context, progress, chunkEvent) =>
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
                ),
              ),
            ),
            Container(
              width: 3.w,
              decoration: BoxDecoration(
                color: isSelected ? Get.theme.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
