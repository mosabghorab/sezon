import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/products/models/order.dart';
import 'package:sezon/src/modules/products/services/orders_service.dart';

class OrdersPageController extends GetxController {
  // notifiable.
  void notifyOrders() {
    update(['orders']);
  }

  // services.
  late final OrdersService _ordersService = Get.find<OrdersService>();

  // flags.
  bool isOrdersLoading = true;
  bool isOrdersLoadingFailed = false;

  // data.
  List<Order> orders = [];

  // on init.
  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  // get orders.
  void getOrders({
    bool notifyLoading = false,
  }) async {
    try {
      if (notifyLoading) {
        isOrdersLoading = true;
        isOrdersLoadingFailed = false;
        notifyOrders();
      }
      List<Order>? orders = await _ordersService.getOrders();
      if (orders != null) {
        // success.
        this.orders = orders;
      } else {
        // failed.
        debugPrint('failed');
        isOrdersLoadingFailed = true;
      }
      isOrdersLoading = false;
      notifyOrders();
    } catch (error) {
      debugPrint('error : $error');
      isOrdersLoading = false;
      isOrdersLoadingFailed = true;
      notifyOrders();
    }
  }

  // refresh orders.
  Future<void> refreshOrders() async {
    getOrders(notifyLoading: true);
  }
}
