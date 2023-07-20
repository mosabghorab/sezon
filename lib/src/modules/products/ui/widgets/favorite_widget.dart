import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/modules/products/models/product.dart';

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
          product.mainImage ?? '',
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
                product.name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              10.verticalSpace,
              Text(
                product.description,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              5.verticalSpace,
              Text(
                '${product.price} ${'S.R'.tr}',
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
              title: 'Remove From Favorite'.tr,
              description:
                  'Are you sure you want to remove this product from favorite?'
                      .tr,
              confirmText: 'Remove'.tr,
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
