import 'package:equatable/equatable.dart';
import 'package:sezon/src/modules/products/models/order_address.dart';
import 'package:sezon/src/modules/products/models/order_details.dart';
import 'package:sezon/src/modules/products/models/product.dart';

class Order extends Equatable {
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

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        userId,
        productId,
      ];
}
