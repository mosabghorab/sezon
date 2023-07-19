import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sezon/src/modules/products/data_sources/remote_data_source/firebase_data_source/favorites_service.dart';
import 'package:sezon/src/modules/products/models/favorite.dart';
import 'package:sezon/src/modules/products/models/product.dart';

class ProductsService {
  static ProductsService? _instance;

  late final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late final FavoritesService _favoritesService = FavoritesService.instance;

  // private constructor.
  ProductsService._();

  // singleton pattern.
  static ProductsService get instance =>
      _instance ?? (_instance = ProductsService._());

  // get products.
  Future<List<Product>?> getProducts({
    String? categoryId,
  }) async {
    try {
      List<Product> products = [];
      Query<Map<String, dynamic>> collection =
          _firebaseFirestore.collection('products');
      if (categoryId != null) {
        collection = collection.where('categoryId', isEqualTo: categoryId);
      }
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collection.get();
      for (DocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Product product = Product.fromJson(documentSnapshot.data()!)
          ..id = documentSnapshot.id;
        Favorite? favorite = await _favoritesService.getFavoriteByProductId(
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
          await _firebaseFirestore.collection('products').doc(productId).get();
      return Product.fromJson(documentSnapshot.data()!)
        ..id = documentSnapshot.id;
    } catch (error) {
      // error.
      debugPrint('error : $error');
      return null;
    }
  }
}
