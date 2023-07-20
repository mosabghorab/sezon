import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/config/shared_data.dart';
import 'package:sezon/src/modules/products/data_sources/remote_data_source/firebase_data_source/products_repository.dart';
import 'package:sezon/src/modules/products/models/order.dart' as order;
import 'package:sezon/src/modules/products/models/order_address.dart';
import 'package:sezon/src/modules/products/models/order_details.dart';
import 'package:sezon/src/modules/products/models/product.dart';

class OrdersRepository {
  static OrdersRepository? _instance;

  late final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late final ProductsRepository _productsRepository =
      ProductsRepository.instance;

  // private constructor.
  OrdersRepository._();

  // singleton pattern.
  static OrdersRepository get instance =>
      _instance ?? (_instance = OrdersRepository._());

  // add order.
  Future<void> addOrder({
    required String productId,
    required OrderAddress orderAddress,
    required OrderDetails orderDetails,
  }) async {
    try {
      await _firebaseFirestore
          .collection(Constants.firebaseFirestoreCollectionOrders)
          .add({
        'userId': SharedData.currentUser!.uid,
        'productId': productId,
        'orderAddress': orderAddress.toJson(),
        'orderDetails': orderDetails.toJson(),
      });
    } catch (error) {
      // error.
      debugPrint('error : $error');
    }
  }

  // get orders.
  Future<List<order.Order>?> getOrders() async {
    try {
      List<order.Order> orders = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection(Constants.firebaseFirestoreCollectionOrders)
              .get();
      for (DocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        order.Order o = order.Order.fromJson(documentSnapshot.data()!)
          ..id = documentSnapshot.id;
        Product? product = await _productsRepository.getProductById(
          productId: o.productId!,
        );
        if (product != null) o.product = product;
        orders.add(o);
      }
      return orders;
    } catch (error) {
      // error.
      debugPrint('error : $error');
      return null;
    }
  }
}
