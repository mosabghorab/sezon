import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_app_bar_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/failure_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/section_title_widget.dart';
import 'package:sezon/src/modules/products/models/product.dart';
import 'package:sezon/src/modules/products/ui/pages/product_details_page/product_details_page_controller.dart';
import 'package:sezon/src/modules/products/ui/widgets/product_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // controller.
  late final ProductDetailsPageController _productDetailsPageController =
      Get.find<ProductDetailsPageController>(
    tag: (Get.arguments['product'] as Product).id,
  );

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    // _productDetailsPageController.dispose();
    // Get.delete<ProductDetailsPageController>(
    //     tag: _productDetailsPageController.product.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'تفاصيل المنتج',
      ),
      body: RefreshIndicator(
        onRefresh: _productDetailsPageController.refreshSuggestedProducts,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 150.h,
                  onPageChanged: _productDetailsPageController.onPageChanged,
                  viewportFraction: 1,
                  autoPlay: true,
                ),
                items: List.generate(
                  _productDetailsPageController.product.images!.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: ImageFade(
                      height: 150.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        _productDetailsPageController.product.images![index],
                      ),
                      duration: const Duration(milliseconds: 900),
                      syncDuration: const Duration(milliseconds: 150),
                      alignment: Alignment.center,
                      loadingBuilder: (context, progress, chunkEvent) => Center(
                        child: SizedBox(
                          width: 15.h,
                          height: 15.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      errorBuilder: (context, error) => Center(
                        child: Icon(
                          Icons.broken_image_rounded,
                          color: Colors.black,
                          size: 25.h,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              10.verticalSpace,
              GetBuilder<ProductDetailsPageController>(
                id: 'slider',
                tag: _productDetailsPageController.product.id,
                builder: (controller) => Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      _productDetailsPageController.product.images!.length,
                      (index) => Row(
                        children: [
                          CircleAvatar(
                            radius: 4.r,
                            backgroundColor:
                                controller.selectedSliderIndex == index
                                    ? Get.theme.primaryColor
                                    : Colors.grey.shade300,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _productDetailsPageController.product.nameAr ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      '${_productDetailsPageController.product.price}ر.س',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      _productDetailsPageController.product.descriptionAr ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    15.verticalSpace,
                    const SectionTitleWidget(
                      title: 'منتجات ذات صلة',
                    ),
                    10.verticalSpace,
                    SizedBox(
                      height: 150.h,
                      child: GetBuilder<ProductDetailsPageController>(
                        id: 'suggestedProducts',
                        tag: _productDetailsPageController.product.id,
                        builder: (controller) => controller
                                .isSuggestedProductsLoading
                            ? Center(
                                child: SpinKitFadingCube(
                                  color: Get.theme.primaryColor,
                                  size: 18.r,
                                ),
                              )
                            : controller.isSuggestedProductsLoadingFailed
                                ? Center(
                                    child: FailureWidget(
                                      onTap:
                                          controller.refreshSuggestedProducts,
                                    ),
                                  )
                                : controller.suggestedProducts.isEmpty
                                    ? const Center(
                                        child: Text('لا يوجد منتجات ذات صلة'),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            controller.suggestedProducts.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (_, index) => Builder(
                                          builder: (context) {
                                            Get.put<Product>(
                                                controller
                                                    .suggestedProducts[index],
                                                tag: controller
                                                    .suggestedProducts[index]
                                                    .id);
                                            return SizedBox(
                                              width: 150.w,
                                              child: ProductWidget(
                                                tag: controller
                                                    .suggestedProducts[index]
                                                    .id!,
                                                imageSize: 80,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                      ),
                    ),
                    30.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _productDetailsPageController.product
                                  .toggleIsFavorite();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.horizontal(
                                  start: Radius.circular(4.r),
                                ),
                                border: Border.all(
                                  color: Get.theme.primaryColor,
                                ),
                              ),
                              child: Center(
                                child: GetBuilder<Product>(
                                  id: 'isFavorite',
                                  tag: _productDetailsPageController.product.id,
                                  builder: (controller) => Text(
                                    controller.isFavorite
                                        ? 'ازالة من المفضلة'
                                        : 'اضافة الى المفضلة',
                                    style: TextStyle(
                                      color: Get.theme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: _productDetailsPageController
                                .navigateToCheckoutPage,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.horizontal(
                                  end: Radius.circular(4.r),
                                ),
                                color: Get.theme.primaryColor,
                                border: Border.all(
                                  color: Get.theme.primaryColor,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'شراء الان',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
