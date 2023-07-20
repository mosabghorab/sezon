import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';
import 'package:sezon/src/modules/products/data_sources/remote_data_source/firebase_data_source/favorites_repository.dart';
import 'package:sezon/src/modules/products/models/favorite.dart';
import 'package:sezon/src/modules/products/models/product.dart';

class ProductsRepository {
  static ProductsRepository? _instance;

  late final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late final FavoritesRepository _favoritesRepository =
      FavoritesRepository.instance;

  // private constructor.
  ProductsRepository._();

  // singleton pattern.
  static ProductsRepository get instance =>
      _instance ?? (_instance = ProductsRepository._());

  // get products.
  Future<List<Product>?> getProducts({
    String? categoryId,
    String? name,
  }) async {
    try {
      List<Product> products = [];
      Query<Map<String, dynamic>> collection = _firebaseFirestore
          .collection(Constants.firebaseFirestoreCollectionProducts);
      if (categoryId != null) {
        collection = collection.where('categoryId', isEqualTo: categoryId);
      }
      if (name != null && name.isNotEmpty) {
        collection = collection.where(
            SharedPreferencesManager.instance.getAppLang() == 'en'
                ? 'nameEn'
                : 'nameAr',
            isEqualTo: name);
      }
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collection.get();
      for (DocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Product product = Product.fromJson(documentSnapshot.data()!)
          ..id = documentSnapshot.id;
        Favorite? favorite = await _favoritesRepository.getFavoriteByProductId(
            productId: product.id!);
        product.isFavorite = favorite != null;
        products.add(product);
      }
      return products;
    } catch (error) {
      // error.
      debugPrint('error : $error');
      return null;
    }
  }

  // get product by id.
  Future<Product?> getProductById({
    required String productId,
  }) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firebaseFirestore
              .collection(Constants.firebaseFirestoreCollectionProducts)
              .doc(productId)
              .get();
      return Product.fromJson(documentSnapshot.data()!)
        ..id = documentSnapshot.id;
    } catch (error) {
      // error.
      debugPrint('error : $error');
      return null;
    }
  }
}
