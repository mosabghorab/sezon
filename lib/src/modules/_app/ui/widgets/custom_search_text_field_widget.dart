import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/constants.dart';

class CustomSearchTextFieldWidget extends StatelessWidget {
  const CustomSearchTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        hintText: 'كلمة البحث هنا...',
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
    );
  }
}
