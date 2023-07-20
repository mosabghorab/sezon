import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  String? id;
  String? userId;
  String? productId;

  Favorite({
    required this.userId,
    required this.productId,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        userId: json['userId'],
        productId: json['productId'],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        userId,
        productId,
      ];
}
