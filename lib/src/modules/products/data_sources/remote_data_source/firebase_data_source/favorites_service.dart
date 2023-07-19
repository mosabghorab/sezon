import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/config/shared_data.dart';
import 'package:sezon/src/modules/products/data_sources/remote_data_source/firebase_data_source/products_service.dart';
import 'package:sezon/src/modules/products/models/favorite.dart';
import 'package:sezon/src/modules/products/models/product.dart';

class FavoritesService {
  static FavoritesService? _instance;

  late final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late final ProductsService _productsService = ProductsService.instance;

  // private constructor.
  FavoritesService._();

  // singleton pattern.
  static FavoritesService get instance =>
      _instance ?? (_instance = FavoritesService._());

  // add to favorite.
  Future<void> addToFavorite({
    required String productId,
  }) async {
    try {
      await _firebaseFirestore
          .collection(Constants.firebaseFirestoreCollectionFavorites)
          .add({
        'userId': SharedData.currentUser!.uid,
        'productId': productId,
      });
    } catch (error) {
      // error.
      debugPrint('error : $error');
    }
  }

  // remove from favorite.
  Future<void> removeFromFavorite({
    required String productId,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .where('userId', isEqualTo: SharedData.currentUser!.uid)
          .where('productId', isEqualTo: productId)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.first.reference.delete();
      } else {
        debugPrint('Favorite not found');
      }
    } catch (error) {
      // error.
      debugPrint('error : $error');
    }
  }

  // get favorite.
  Future<List<Product>?> getFavorite() async {
    try {
      List<Product> products = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection('favorites').get();
      for (DocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Favorite favorite = Favorite.fromJson(documentSnapshot.data()!)
          ..id = documentSnapshot.id;
        Product? product = await _productsService.getProductById(
          productId: favorite.productId!,
        );
        if (product != null) products.add(product);
      }
      return products;
    } catch (error) {
      // error.
      debugPrint('error : $error');
      return null;
    }
  }

  // get favorite by product id.
  Future<Favorite?> getFavoriteByProductId({
    required String productId,
  }) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('favorites')
              .where('productId', isEqualTo: productId)
              .limit(1)
              .get();
      if (querySnapshot.docs.isEmpty) return null;
      return Favorite.fromJson(querySnapshot.docs.first.data())
        ..id = querySnapshot.docs.first.id;
    } catch (error) {
      // error.
      debugPrint('error : $error');
      return null;
    }
  }
}
