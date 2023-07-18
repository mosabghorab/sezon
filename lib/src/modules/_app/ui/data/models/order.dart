import 'package:sezon/src/modules/_app/ui/data/models/order_address.dart';
import 'package:sezon/src/modules/_app/ui/data/models/order_details.dart';
import 'package:sezon/src/modules/_app/ui/data/models/product.dart';

class Order {
  String? id;
  String? userId;
  String? productId;
  OrderDetails? orderDetails;
  OrderAddress? orderAddress;
  Product? product;

  Order({
    required this.userId,
    required this.productId,
    required this.orderDetails,
    required this.orderAddress,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        userId: json['userId'],
        productId: json['productId'],
        orderDetails: OrderDetails.fromJson(json['orderDetails']),
        orderAddress: OrderAddress.fromJson(json['orderAddress']),
      );
}
