import 'package:get/get.dart';
import 'package:sezon/src/modules/products/data_sources/remote_data_source/firebase_data_source/orders_repository.dart';
import 'package:sezon/src/modules/products/models/order.dart' as order;
import 'package:sezon/src/modules/products/models/order_address.dart';
import 'package:sezon/src/modules/products/models/order_details.dart';

class OrdersService extends GetxService {
  // repository.
  late final OrdersRepository _ordersRepository = OrdersRepository.instance;

  // add order.
  Future<void> addOrder({
    required String productId,
    required OrderAddress orderAddress,
    required OrderDetails orderDetails,
  }) async {
    return _ordersRepository.addOrder(
        productId: productId,
        orderAddress: orderAddress,
        orderDetails: orderDetails);
  }

  // get orders.
  Future<List<order.Order>?> getOrders() async {
    return _ordersRepository.getOrders();
  }
}
