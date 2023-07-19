import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';
import 'package:sezon/src/modules/products/models/order.dart';

class OrderWidget extends StatelessWidget {
  final Order order;

  const OrderWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 6.h,
        horizontal: 12.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 3.r,
            spreadRadius: 5.r,
          ),
        ],
      ),
      child: Row(
        children: [
          ImageFade(
            height: 80.h,
            width: 80.h,
            fit: BoxFit.cover,
            image: NetworkImage(
              order.product?.mainImage ?? '',
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
          15.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.product?.nameAr ?? '',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.verticalSpace,
                Text(
                  order.product?.descriptionAr ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
                5.verticalSpace,
                Text(
                  '${order.product?.price ?? 0}.س',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
