import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_app_bar_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/failure_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/user_avatar_widget.dart';
import 'package:sezon/src/modules/products/models/product.dart';
import 'package:sezon/src/modules/products/ui/pages/categories_page/categories_page_controller.dart';
import 'package:sezon/src/modules/products/ui/widgets/product_widget.dart';
import 'package:sezon/src/modules/products/ui/widgets/selectable_category_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  // controller.
  late final CategoriesPageController _categoriesPageController =
      Get.find<CategoriesPageController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    Get.delete<CategoriesPageController>();
    for (var element in _categoriesPageController.products) {
      Get.delete<Product>(tag: element.id);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        leading: const Center(
          child: UserAvatarWidget(),
        ),
        title: 'Categories'.tr,
        actions: [
          SvgPicture.asset(
            '${Constants.assetsVectorsPath}notifications.svg',
            width: 20.h,
            height: 20.h,
          ),
          15.horizontalSpace,
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 80.w,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 3.r,
                  spreadRadius: 5.r,
                ),
              ],
            ),
            child: GetBuilder<CategoriesPageController>(
              id: 'categories',
              builder: (controller) => controller.isCategoriesLoading
                  ? Center(
                      child: SpinKitFadingCube(
                        color: Get.theme.primaryColor,
                        size: 18.r,
                      ),
                    )
                  : controller.categories.isEmpty
                      ? Center(
                          child: Text('Categories not found'.tr),
                        )
                      : controller.isCategoriesLoadingFailed
                          ? Center(
                              child: FailureWidget(
                                onTap: controller.refreshCategories,
                              ),
                            )
                          : ListView.separated(
                              itemCount:
                                  _categoriesPageController.categories.length,
                              separatorBuilder: (_, index) => 15.verticalSpace,
                              itemBuilder: (_, index) =>
                                  SelectableCategoryWidget(
                                isSelected:
                                    index == controller.selectedCategoryIndex,
                                category:
                                    _categoriesPageController.categories[index],
                                onTap: () {
                                  _categoriesPageController.onCategorySelected(
                                      index: index);
                                },
                              ),
                            ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.h),
              child: RefreshIndicator(
                onRefresh: _categoriesPageController.refreshProducts,
                child: GetBuilder<CategoriesPageController>(
                  id: 'products',
                  builder: (controller) => controller.isProductsLoading
                      ? Center(
                          child: SpinKitFadingCube(
                            color: Get.theme.primaryColor,
                            size: 18.r,
                          ),
                        )
                      : controller.isProductsLoadingFailed
                          ? Center(
                              child: FailureWidget(
                                onTap: controller.refreshProducts,
                              ),
                            )
                          : controller.products.isEmpty
                              ? Center(
                                  child: Text('Products not found'.tr),
                                )
                              : GridView.builder(
                                  itemCount: controller.products.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 150.h,
                                    mainAxisSpacing: 10.h,
                                    crossAxisSpacing: 10.w,
                                  ),
                                  itemBuilder: (_, index) => Builder(
                                    builder: (context) {
                                      Get.put<Product>(
                                          controller.products[index],
                                          tag: controller.products[index].id);
                                      return ProductWidget(
                                        tag: controller.products[index].id!,
                                        imageSize: 80,
                                      );
                                    },
                                  ),
                                ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
