import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Color? textColor;
  final Color? color;
  final EdgeInsets? padding;
  final bool isBordered;
  final bool isLoading;

  const CustomButtonWidget({
    Key? key,
    required this.title,
    required this.onTap,
    this.textColor,
    this.color,
    this.padding,
    this.isBordered = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5.r),
      child: Container(
        width: double.infinity,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 10.h,
            ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: isBordered
              ? Border.all(color: color ?? Get.theme.primaryColor)
              : null,
          color: isBordered ? null : color ?? Get.theme.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
              ),
            ),
            if (isLoading) ...[
              SizedBox(
                width: 20.w,
              ),
              SizedBox(
                width: 15.h,
                height: 15.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
