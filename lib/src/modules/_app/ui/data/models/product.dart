import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/core/enums.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/modules/_app/ui/data/data_sources/remote_data_source/firebase_data_source/favorites_service.dart';

class Product extends GetxController {
  // notifiable.
  bool isFavorite = false;

  toggleIsFavorite() {
    isFavorite = !isFavorite;
    update(['isFavorite']);
    if (isFavorite) {
      addToFavorite();
    } else {
      removeFromFavorite();
    }
  }

  late final FavoritesService _favoritesService = FavoritesService.instance;

  String? id;
  String? nameEn;
  String? nameAr;
  String? mainImage;
  List<String>? images;
  num? price;

  Product({
    required this.nameEn,
    required this.nameAr,
    required this.mainImage,
    required this.images,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        nameEn: json['nameEn'],
        nameAr: json['nameAr'],
        mainImage: json['mainImage'],
        images: json['images'].map<String>((e) => e.toString()).toList(),
        price: json['price'],
      );

  // add to favorite.
  void addToFavorite() async {
    try {
      await _favoritesService.addToFavorite(productId: id!);
      Helpers.showMessage(
          text: 'تمت اضافة المنتج الى المفضلة',
          messageType: MessageType.successMessage);
    } catch (error) {
      // error.
      Helpers.showMessage(
          text: 'حدث خطأ ما', messageType: MessageType.failureMessage);
      debugPrint('error : $error');
    }
  }

  // remove from favorite.
  Future<void> removeFromFavorite() async {
    try {
      await _favoritesService.removeFromFavorite(productId: id!);
      Helpers.showMessage(
          text: 'تمت حذف المنتج من المفضلة',
          messageType: MessageType.successMessage);
    } catch (error) {
      // error.
      Helpers.showMessage(
          text: 'حدث خطأ ما', messageType: MessageType.failureMessage);
      debugPrint('error : $error');
    }
  }
}
