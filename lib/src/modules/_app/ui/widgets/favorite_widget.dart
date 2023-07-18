import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/modules/_app/ui/data/models/product.dart';

class FavoriteWidget extends StatelessWidget {
  final Product product;
  final VoidCallback onDeleteFinished;

  const FavoriteWidget({
    Key? key,
    required this.product,
    required this.onDeleteFinished,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          'https://images.pexels.com/photos/4041392/pexels-photo-4041392.jpeg?auto=compress&cs=tinysrgb&w=800',
          height: 80.h,
          width: 80.h,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 15.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'خزف ملون صنع يدوي',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              10.verticalSpace,
              Text(
                'هذا النص هو مثال لنص يمكن أن يستبدل توليد هذا النص من مولد النص العربى...',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              5.verticalSpace,
              Text(
                '190ر.س',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.primaryColor,
                ),
              ),
            ],
          ),
        ),
        5.horizontalSpace,
        InkWell(
          onTap: () {
            Helpers.showConfirmation(
              title: 'ازالة من المفضلة',
              description: 'هل أنت متأكد من ازالة هذا المنتج من المفضلة؟',
              confirmText: 'ازالة',
              onConfirm: () async {
                await product.removeFromFavorite();
                onDeleteFinished();
              },
            );
          },
          child: SvgPicture.asset(
            '${Constants.assetsVectorsPath}delete.svg',
            width: 18.h,
            height: 18.h,
          ),
        ),
      ],
    );
  }
}
