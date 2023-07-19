class Favorite {
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
}
