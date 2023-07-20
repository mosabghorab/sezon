import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_app_bar_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_button_widget.dart';
import 'package:sezon/src/modules/products/ui/pages/checkout_page/checkout_page_controller.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // controller.
  late final CheckoutPageController _checkoutPageController =
      Get.find<CheckoutPageController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    Get.delete<CheckoutPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarWidget(
        title: 'Checkout'.tr,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.h),
          child: Column(
            children: [
              GetBuilder<CheckoutPageController>(
                id: 'orderAddress',
                builder: (controller) => InkWell(
                  onTap: _checkoutPageController.onAddAddressTapped,
                  child: Container(
                    padding: EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 3.r,
                          spreadRadius: 5.r,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          '${Constants.assetsVectorsPath}address.svg',
                        ),
                        15.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Address'.tr,
                              ),
                              if (controller.orderAddress != null)
                                Text(
                                  '${controller.orderAddress!.country} , ${controller.orderAddress!.city} ,${controller.orderAddress!.region} ,${controller.orderAddress!.street} , ${controller.orderAddress!.zipCode}',
                                ),
                            ],
                          ),
                        ),
                        controller.orderAddress != null
                            ? SvgPicture.asset(
                                '${Constants.assetsVectorsPath}edit.svg',
                                width: 15.h,
                                height: 15.h,
                              )
                            : const Icon(
                                Icons.add,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              10.verticalSpace,
              GetBuilder<CheckoutPageController>(
                id: 'orderDetails',
                builder: (controller) => InkWell(
                  onTap: _checkoutPageController.onAddOrderDetailsTapped,
                  child: Container(
                    padding: EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 3.r,
                          spreadRadius: 5.r,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          '${Constants.assetsVectorsPath}box.svg',
                        ),
                        15.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product Specifications'.tr,
                              ),
                              if (controller.orderDetails != null)
                                Text(
                                  '${controller.orderDetails!.quantity} , ${controller.orderDetails!.color} ,${controller.orderDetails!.size}',
                                ),
                            ],
                          ),
                        ),
                        controller.orderDetails != null
                            ? SvgPicture.asset(
                                '${Constants.assetsVectorsPath}edit.svg',
                                width: 15.h,
                                height: 15.h,
                              )
                            : const Icon(
                                Icons.add,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              15.verticalSpace,
              Container(
                padding: EdgeInsets.all(12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 3.r,
                      spreadRadius: 5.r,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Summary'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Row(
                      children: [
                        Text('Delivery time'.tr),
                        const Spacer(),
                        Text('Not found'.tr),
                      ],
                    ),
                    5.verticalSpace,
                    const Divider(),
                    5.verticalSpace,
                    Row(
                      children: [
                        Text('Total product cost'.tr),
                        const Spacer(),
                        Text(
                            '${_checkoutPageController.product.price} ${'S.R'.tr}'),
                      ],
                    ),
                    5.verticalSpace,
                    const Divider(),
                    5.verticalSpace,
                    Row(
                      children: [
                        Text('Delivery total cost'.tr),
                        const Spacer(),
                        Text('0 ${'S.R'.tr}'),
                      ],
                    ),
                    5.verticalSpace,
                    const Divider(),
                    5.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'Total'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${_checkoutPageController.product.price} ${'S.R'.tr}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              30.verticalSpace,
              CustomButtonWidget(
                title: 'Confirm Order'.tr,
                onTap: _checkoutPageController.addOrder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
