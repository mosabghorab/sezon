import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/app_router.dart';
import 'package:sezon/src/modules/_app/ui/data/models/product.dart';

class ProductWidget extends StatefulWidget {
  final double? imageSize;
  final String tag;

  const ProductWidget({
    super.key,
    required this.tag,
    this.imageSize,
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
        Get.toNamed(AppRouter.productDetails,
            arguments: {
              'product': _product,
            },
            preventDuplicates: false);
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
                  child: ImageFade(
                    height: widget.imageSize?.h ?? 130.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      _product.mainImage ?? '',
                    ),
                    loadingBuilder: (context, progress, chunkEvent) => Center(
                      child: SizedBox(
                        width: 15.h,
                        height: 15.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ),
                    errorBuilder: (context, error) => Center(
                      child: Icon(
                        Icons.broken_image_rounded,
                        color: Colors.black,
                        size: 15.h,
                      ),
                    ),
                  ),
                ),
                PositionedDirectional(
                  top: 5.h,
                  end: 5.w,
                  child: GetBuilder<Product>(
                    id: 'isFavorite',
                    tag: widget.tag,
                    builder: (controller) => InkWell(
                      onTap: _product.toggleIsFavorite,
                      child: CircleAvatar(
                        radius: 13.r,
                        backgroundColor: Colors.black.withOpacity(0.3),
                        child: SvgPicture.asset(
                          '${Constants.assetsVectorsPath}favorite.svg',
                          height: 10.h,
                          width: 10.h,
                          color:
                              controller.isFavorite ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            Text(_product.nameAr ?? ''),
            5.verticalSpace,
            Text(
              '${_product.price} ر.س',
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
