import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_app_bar_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/user_avatar_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // controller.
  // late final HomePageController _homePageController =
  //     Get.find<HomePageController>();

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
        title: 'تفاصيل المنتج',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 150.h,
                  // onPageChanged: _productDetailsScreenController.onPageChanged,
                  viewportFraction: 1,
                  autoPlay: true,
                ),
                items: List.generate(
                  3,
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
                      image: const NetworkImage(
                        'https://images.pexels.com/photos/3612182/pexels-photo-3612182.jpeg?auto=compress&cs=tinysrgb&w=800',
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
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    3,
                    (index) => Row(
                      children: [
                        CircleAvatar(
                          radius: 5.r,
                          backgroundColor: 0 == index
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
              15.verticalSpace,
              Text(
                'خزف ملون صنع يدوي',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
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
              5.verticalSpace,
              Text(
                'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا ',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              15.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 20.h,
                    width: 4.w,
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  15.horizontalSpace,
                  Text(
                    'منتجات ذات صلة',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              10.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.horizontal(
                          start: Radius.circular(4.r),
                        ),
                        border: Border.all(
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'اضافة الى المفضلة',
                          style: TextStyle(
                            color: Get.theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.horizontal(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
