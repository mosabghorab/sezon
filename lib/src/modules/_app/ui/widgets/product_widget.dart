import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 2.r,
            spreadRadius: 2.r,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.r),
            child: Image.network(
              'https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?auto=compress&cs=tinysrgb&w=800',
              height: 130.h,
              fit: BoxFit.cover,
            ),
          ),
          10.verticalSpace,
          Text('رسم على خشب'),
          5.verticalSpace,
          Text(
            '130 ر.س',
            style: TextStyle(
              color: Get.theme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
