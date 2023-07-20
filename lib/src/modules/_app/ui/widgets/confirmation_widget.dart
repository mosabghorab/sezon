import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';

class ConfirmationWidget extends StatelessWidget {
  final String title;
  final String description;
  final String confirmText;
  final String? iconName;
  final Color? buttonColor;
  final void Function() onConfirm;

  const ConfirmationWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.confirmText,
    this.iconName,
    this.buttonColor,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(40.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  children: [
                    if (iconName != null) ...[
                      SvgPicture.asset(
                        '${Constants.assetsVectorsPath}$iconName.svg',
                        color: Colors.grey,
                        width: 35.h,
                        height: 35.h,
                      ),
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xff858585),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Theme.of(context).dividerColor,
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor:
                              buttonColor ?? Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Get.back();
                          onConfirm();
                        },
                        child: Text(
                          confirmText,
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(),
                    Expanded(
                      child: TextButton(
                        child: Text(
                          'Cancel'.tr,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
