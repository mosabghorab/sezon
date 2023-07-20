import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../config/constants.dart';

class CustomSearchTextFieldWidget extends StatelessWidget {
  final void Function(String? value) onSubmitted;

  const CustomSearchTextFieldWidget({
    super.key,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        hintText: 'Search here...'.tr,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(8.h),
          child: SvgPicture.asset(
            '${Constants.assetsVectorsPath}search.svg',
          ),
        ),
      ),
      onSubmitted: onSubmitted,
    );
  }
}
