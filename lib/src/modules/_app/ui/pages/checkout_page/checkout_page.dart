import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/pages/checkout_page/checkout_page_controller.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_app_bar_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_button_widget.dart';

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
    _checkoutPageController.dispose();
    Get.delete<CheckoutPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'إتمام عملية الشراء',
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
                              const Text(
                                'العنوان',
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
                              const Text(
                                'مواصفات المنتج',
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
                    const Row(
                      children: [
                        Text(
                          'الملخص',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    const Row(
                      children: [
                        Text('مدة الشحن'),
                        Spacer(),
                        Text('لا يوجد'),
                      ],
                    ),
                    5.verticalSpace,
                    const Divider(),
                    5.verticalSpace,
                    Row(
                      children: [
                        const Text('إجمالي تكلفة المنتج'),
                        const Spacer(),
                        Text('${_checkoutPageController.product.price}ر.س'),
                      ],
                    ),
                    5.verticalSpace,
                    const Divider(),
                    5.verticalSpace,
                    const Row(
                      children: [
                        Text('إجمالي تكلفة الشحن'),
                        Spacer(),
                        Text('0ر.س'),
                      ],
                    ),
                    5.verticalSpace,
                    const Divider(),
                    5.verticalSpace,
                    Row(
                      children: [
                        const Text(
                          'المجموع الكلي',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${_checkoutPageController.product.price}ر.س',
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
                title: 'تأكيد الطلب',
                onTap: _checkoutPageController.addOrder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
