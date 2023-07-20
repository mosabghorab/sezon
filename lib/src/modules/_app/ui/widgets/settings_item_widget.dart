import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const SettingsItemWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.textColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
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
            Icon(
              icon,
              color: iconColor,
            ),
            15.horizontalSpace,
            Text(
              title,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
