import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/products/models/product.dart';
import 'package:sezon/src/modules/products/services/favorites_service.dart';

class FavoritePageController extends GetxController {
  // notifiable.
  void notifyFavorites() {
    update(['favorite']);
  }

  // services.
  late final FavoritesService _favoritesService = Get.find<FavoritesService>();

  // flags.
  bool isFavoriteLoading = true;
  bool isFavoriteLoadingFailed = false;

  // data.
  List<Product> products = [];

  // on init.
  @override
  void onInit() {
    getFavorite();
    super.onInit();
  }

  // get favorite.
  void getFavorite({
    bool notifyLoading = false,
  }) async {
    try {
      if (notifyLoading) {
        isFavoriteLoading = true;
        isFavoriteLoadingFailed = false;
        notifyFavorites();
      }
      List<Product>? products = await _favoritesService.getFavorite();
      if (products != null) {
        // success.
        this.products = products;
      } else {
        // failed.
        debugPrint('failed');
        isFavoriteLoadingFailed = true;
      }
      isFavoriteLoading = false;
      notifyFavorites();
    } catch (error) {
      debugPrint('error : $error');
      isFavoriteLoading = false;
      isFavoriteLoadingFailed = true;
      notifyFavorites();
    }
  }

  // refresh favorite.
  Future<void> refreshFavorite() async {
    getFavorite(notifyLoading: true);
  }
}
