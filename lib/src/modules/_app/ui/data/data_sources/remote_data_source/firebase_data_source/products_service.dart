import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sezon/src/modules/_app/ui/data/models/product.dart';

class ProductsService {
  static ProductsService? _instance;

  late final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
      Query<Map<String, dynamic>> collection =
          _firebaseFirestore.collection('products');
      if (categoryId != null) {
        collection = collection.where('categoryId', isEqualTo: categoryId);
      }
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collection.get();
      return querySnapshot.docs
          .map((e) => Product.fromJson(e.data())..id = e.id)
          .toList();
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
