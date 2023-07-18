import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FailureWidget extends StatelessWidget {
  final VoidCallback onTap;

  const FailureWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        CupertinoIcons.refresh_circled_solid,
        color: Colors.red,
        size: 40.h,
      ),
    );
  }
}
