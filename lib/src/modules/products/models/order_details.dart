import 'package:equatable/equatable.dart';

class OrderDetails extends Equatable {
  String? id;
  String? quantity;
  String? size;
  String? color;

  OrderDetails({
    required this.quantity,
    required this.size,
    required this.color,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        quantity: json['quantity'],
        size: json['size'],
        color: json['color'],
      );

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'size': size,
        'color': color,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        quantity,
        size,
        color,
      ];
}
