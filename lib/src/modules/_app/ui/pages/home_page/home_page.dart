import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/pages/home_page/home_page_controller.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_app_bar_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_search_text_field_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/failure_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/section_title_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/user_avatar_widget.dart';
import 'package:sezon/src/modules/products/models/product.dart';
import 'package:sezon/src/modules/products/ui/widgets/category_widget.dart';
import 'package:sezon/src/modules/products/ui/widgets/product_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // controller.
  late final HomePageController _homePageController =
      Get.find<HomePageController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    Get.delete<HomePageController>();
    for (var element in _homePageController.products) {
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
        title: 'Home'.tr,
        actions: [
          SvgPicture.asset(
            '${Constants.assetsVectorsPath}notifications.svg',
            width: 20.h,
            height: 20.h,
          ),
          15.horizontalSpace,
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _homePageController.refreshAll,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(16.h),
            child: Column(
              children: [
                CustomSearchTextFieldWidget(
                  onSubmitted: _homePageController.onSearch,
                ),
                15.verticalSpace,
                SectionTitleWidget(
                  title: 'Categories'.tr,
                ),
                10.verticalSpace,
                SizedBox(
                  height: 70.h,
                  child: GetBuilder<HomePageController>(
                    id: 'categories',
                    builder: (controller) => controller.isCategoriesLoading
                        ? Center(
                            child: SpinKitFadingCube(
                              color: Get.theme.primaryColor,
                              size: 18.r,
                            ),
                          )
                        : controller.isCategoriesLoadingFailed
                            ? Center(
                                child: FailureWidget(
                                  onTap: controller.refreshCategories,
                                ),
                              )
                            : controller.categories.isEmpty
                                ? Center(
                                    child: Text('No categories found'.tr),
                                  )
                                : ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.categories.length,
                                    separatorBuilder: (_, index) => SizedBox(
                                      width: 15.w,
                                    ),
                                    itemBuilder: (_, index) => CategoryWidget(
                                      category: controller.categories[index],
                                    ),
                                  ),
                  ),
                ),
                15.verticalSpace,
                SectionTitleWidget(
                  title: 'Products'.tr,
                ),
                10.verticalSpace,
                GetBuilder<HomePageController>(
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
                                  child: Text('No products found'.tr),
                                )
                              : GridView.builder(
                                  itemCount: controller.products.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 200.h,
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
                                      );
                                    },
                                  ),
                                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
