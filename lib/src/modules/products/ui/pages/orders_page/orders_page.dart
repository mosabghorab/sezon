import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/widgets/custom_app_bar_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/failure_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/user_avatar_widget.dart';
import 'package:sezon/src/modules/products/ui/pages/orders_page/orders_page_controller.dart';
import 'package:sezon/src/modules/products/ui/widgets/order_widget.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // controller.
  late final OrdersPageController _ordersPageController =
      Get.find<OrdersPageController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    Get.delete<OrdersPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        leading: const Center(
          child: UserAvatarWidget(),
        ),
        title: 'My Orders'.tr,
        actions: [
          SvgPicture.asset(
            '${Constants.assetsVectorsPath}notifications.svg',
            width: 20.h,
            height: 20.h,
          ),
          15.horizontalSpace,
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.h),
        child: GetBuilder<OrdersPageController>(
          id: 'orders',
          builder: (controller) => controller.isOrdersLoading
              ? Center(
                  child: SpinKitFadingCube(
                    color: Get.theme.primaryColor,
                    size: 18.r,
                  ),
                )
              : controller.isOrdersLoadingFailed
                  ? Center(
                      child: FailureWidget(
                        onTap: controller.refreshOrders,
                      ),
                    )
                  : controller.orders.isEmpty
                      ? Center(
                          child: Text('No orders found'.tr),
                        )
                      : RefreshIndicator(
                          onRefresh: _ordersPageController.refreshOrders,
                          child: ListView.separated(
                            itemCount: _ordersPageController.orders.length,
                            separatorBuilder: (_, index) => 15.verticalSpace,
                            itemBuilder: (_, index) => OrderWidget(
                              order: _ordersPageController.orders[index],
                            ),
                          ),
                        ),
        ),
      ),
    );
  }
}
