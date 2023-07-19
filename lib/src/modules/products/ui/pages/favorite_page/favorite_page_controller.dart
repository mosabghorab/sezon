import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/products/data_sources/remote_data_source/firebase_data_source/favorites_service.dart';
import 'package:sezon/src/modules/products/models/product.dart';

class FavoritePageController extends GetxController {
  // notifiable.
  void notifyFavorites() {
    update(['favorite']);
  }

  // services.
  late final FavoritesService _favoritesService = FavoritesService.instance;

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
