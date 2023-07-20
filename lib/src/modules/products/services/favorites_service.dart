import 'package:get/get.dart';
import 'package:sezon/src/modules/products/data_sources/remote_data_source/firebase_data_source/favorites_repository.dart';
import 'package:sezon/src/modules/products/models/favorite.dart';
import 'package:sezon/src/modules/products/models/product.dart';

class FavoritesService extends GetxService {
  // repository.
  late final FavoritesRepository _favoritesRepository =
      FavoritesRepository.instance;

  // add to favorite.
  Future<void> addToFavorite({
    required String productId,
  }) async {
    return _favoritesRepository.addToFavorite(productId: productId);
  }

  // remove from favorite.
  Future<void> removeFromFavorite({
    required String productId,
  }) async {
    return _favoritesRepository.removeFromFavorite(productId: productId);
  }

  // get favorite.
  Future<List<Product>?> getFavorite() async {
    return _favoritesRepository.getFavorite();
  }

  // get favorite by product id.
  Future<Favorite?> getFavoriteByProductId({
    required String productId,
  }) async {
    return _favoritesRepository.getFavoriteByProductId(productId: productId);
  }
}
