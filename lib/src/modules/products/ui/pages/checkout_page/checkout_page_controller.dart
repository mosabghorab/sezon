import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/core/enums.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/modules/_app/app_router.dart';
import 'package:sezon/src/modules/products/data_sources/remote_data_source/firebase_data_source/orders_service.dart';
import 'package:sezon/src/modules/products/models/order_address.dart';
import 'package:sezon/src/modules/products/models/order_details.dart';
import 'package:sezon/src/modules/products/models/product.dart';
import 'package:sezon/src/modules/products/ui/widgets/add_address_widget/add_address_widget.dart';
import 'package:sezon/src/modules/products/ui/widgets/add_address_widget/add_address_widget_controller.dart';
import 'package:sezon/src/modules/products/ui/widgets/add_order_details_widget/add_order_details_widget_controller.dart';

import '../../widgets/add_order_details_widget/add_order_details_widget.dart';

class CheckoutPageController extends GetxController {
  // arguments.
  late Product product;

  // notifiable.
  void notifyOrderAddress() {
    update(['orderAddress']);
  }

  void notifyOrderDetails() {
    update(['orderDetails']);
  }

  // services.
  late final OrdersService _ordersService = OrdersService.instance;

  // data.
  OrderAddress? orderAddress;
  OrderDetails? orderDetails;

  // flags.
  bool isFavoriteLoading = true;
  bool isFavoriteLoadingFailed = false;

  // data.
  List<Product> products = [];

  // on init.
  @override
  void onInit() {
    product = Get.arguments['product'];
    super.onInit();
  }

  // add order.
  void addOrder() async {
    if (orderAddress == null) {
      Helpers.showMessage(
          text: 'الرجاء اضافة عنوان للطلب',
          messageType: MessageType.failureMessage);
      return;
    }
    if (orderDetails == null) {
      Helpers.showMessage(
          text: 'الرجاء اضافة مواصفات المنتج',
          messageType: MessageType.failureMessage);
      return;
    }
    Helpers.showConfirmation(
      title: 'تأكيد الطلب',
      description: 'هل أنت متأكد من اتمام هذا الطلب؟',
      confirmText: 'تأكيد',
      onConfirm: () async {
        try {
          Helpers.showLoading(title: 'جاري التأكيد');
          await _ordersService.addOrder(
            productId: product.id!,
            orderAddress: orderAddress!,
            orderDetails: orderDetails!,
          );
          Get.back();
          Helpers.showMessage(
              text: 'تم انشاء الطلب بنجاح',
              messageType: MessageType.successMessage);
          Get.offAllNamed(AppRouter.navbarPage, arguments: {
            'initialIndex': 2,
          });
        } catch (error) {
          debugPrint('error : $error');
          Helpers.showMessage(
              text: error.toString(), messageType: MessageType.successMessage);
        }
      },
    );
  }

  // on add address tapped.
  void onAddAddressTapped() async {
    OrderAddress? orderAddress = await Helpers.showBottomSheet(
      child: Builder(
        builder: (context) {
          Get.put<AddAddressWidgetController>(AddAddressWidgetController(
            orderAddress: this.orderAddress,
          ));
          return const AddAddressWidget();
        },
      ),
    );
    if (orderAddress != null) {
      this.orderAddress = orderAddress;
      notifyOrderAddress();
    }
  }

  // on add order details tapped.
  void onAddOrderDetailsTapped() async {
    OrderDetails? orderDetails = await Helpers.showBottomSheet(
      child: Builder(
        builder: (context) {
          Get.put<AddOrderDetailsWidgetController>(
              AddOrderDetailsWidgetController(
            orderDetails: this.orderDetails,
          ));
          return const AddOrderDetailsWidget();
        },
      ),
    );
    if (orderDetails != null) {
      this.orderDetails = orderDetails;
      notifyOrderDetails();
    }
  }
}
