import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/pages/favorite_page/favorite_page_controller.dart';
import 'package:sezon/src/modules/_app/ui/pages/home_page/home_page_controller.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_app_bar_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/failure_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/favorite_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/user_avatar_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // controller.
  late final HomePageController _homePageController =
      Get.find<HomePageController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    // _homePageController.dispose();
    // Get.delete<HomePageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        leading: const Center(
          child: UserAvatarWidget(),
        ),
        title: 'الرئيسية',
        actions: [
          SvgPicture.asset(
            '${Constants.assetsVectorsPath}notifications.svg',
            width: 20.h,
            height: 20.h,
          ),
          15.horizontalSpace,
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.h),
          child: GetBuilder<FavoritePageController>(
            id: 'favorite',
            builder: (controller) => controller.isFavoriteLoading
                ? Center(
                    child: SpinKitFadingCube(
                      color: Get.theme.primaryColor,
                      size: 18.r,
                    ),
                  )
                : controller.isFavoriteLoadingFailed
                    ? Center(
                        child: FailureWidget(
                          onTap: controller.refreshFavorite,
                        ),
                      )
                    : ListView.separated(
                        itemCount: controller.products.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, index) => Column(
                          children: [
                            5.verticalSpace,
                            const Divider(),
                            5.verticalSpace,
                          ],
                        ),
                        itemBuilder: (_, index) => FavoriteWidget(
                          product: controller.products[index],
                          onDeleteFinished: controller.refreshFavorite,
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
