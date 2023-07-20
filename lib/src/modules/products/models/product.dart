import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/core/enums.dart';
import 'package:sezon/src/config/helpers.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';
import 'package:sezon/src/modules/products/data_sources/remote_data_source/firebase_data_source/favorites_repository.dart';

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

  late final FavoritesRepository _favoritesService =
      FavoritesRepository.instance;

  String? id;
  String? categoryId;
  String? nameEn;
  String? nameAr;
  String? descriptionEn;
  String? descriptionAr;
  String? mainImage;
  List<String>? images;
  num? price;

  Product({
    required this.categoryId,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.mainImage,
    required this.images,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        categoryId: json['categoryId'],
        nameEn: json['nameEn'],
        nameAr: json['nameAr'],
        descriptionEn: json['descriptionEn'],
        descriptionAr: json['descriptionAr'],
        mainImage: json['mainImage'],
        images: json['images'].map<String>((e) => e.toString()).toList(),
        price: json['price'],
      );

  // get name according to current language.
  get name =>
      SharedPreferencesManager.instance.getAppLang() == 'en' ? nameEn : nameAr;

  // get description according to current language.
  get description => SharedPreferencesManager.instance.getAppLang() == 'en'
      ? descriptionEn
      : descriptionAr;

  // add to favorite.
  void addToFavorite() async {
    try {
      await _favoritesService.addToFavorite(productId: id!);
      Helpers.showMessage(
          text: 'Product add to favorite'.tr,
          messageType: MessageType.successMessage);
    } catch (error) {
      // error.
      Helpers.showMessage(
          text: 'Something went worng'.tr,
          messageType: MessageType.failureMessage);
      debugPrint('error : $error');
    }
  }

  // remove from favorite.
  Future<void> removeFromFavorite() async {
    try {
      await _favoritesService.removeFromFavorite(productId: id!);
      Helpers.showMessage(
          text: 'Product removed from favorite'.tr,
          messageType: MessageType.successMessage);
    } catch (error) {
      // error.
      Helpers.showMessage(
          text: 'Something went wrong'.tr,
          messageType: MessageType.failureMessage);
      debugPrint('error : $error');
    }
  }
}
