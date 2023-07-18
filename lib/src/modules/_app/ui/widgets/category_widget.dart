import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.network(
            'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?auto=compress&cs=tinysrgb&w=800',
            height: 40.h,
            width: 40.h,
            fit: BoxFit.cover,
          ),
        ),
        10.verticalSpace,
        Text('الخزف'),
      ],
    );
  }
}
