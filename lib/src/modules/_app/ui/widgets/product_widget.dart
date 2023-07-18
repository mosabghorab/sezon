import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/app_router.dart';
import 'package:sezon/src/modules/_app/ui/data/models/product.dart';

class ProductWidget extends StatefulWidget {
  final String tag;

  const ProductWidget({
    super.key,
    required this.tag,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  // product.
  late final Product _product = Get.find(tag: widget.tag);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRouter.productDetails);
      },
      child: Container(
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: Image.network(
                    'https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?auto=compress&cs=tinysrgb&w=800',
                    height: 130.h,
                    fit: BoxFit.cover,
                  ),
                ),
                PositionedDirectional(
                  top: 10.h,
                  end: 10.w,
                  child: CircleAvatar(
                    radius: 15.r,
                    backgroundColor: Colors.black.withOpacity(0.3),
                    child: GetBuilder<Product>(
                      id: 'isFavorite',
                      tag: widget.tag,
                      builder: (controller) => InkWell(
                        onTap: _product.toggleIsFavorite,
                        child: SvgPicture.asset(
                          '${Constants.assetsVectorsPath}favorite.svg',
                          height: 12.h,
                          width: 12.h,
                          color: controller.isFavorite ? Colors.red : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
      ),
    );
  }
}
