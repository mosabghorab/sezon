import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/products/models/category.dart';

class CategoriesRepository {
  static CategoriesRepository? _instance;

  late final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // private constructor.
  CategoriesRepository._();

  // singleton pattern.
  static CategoriesRepository get instance =>
      _instance ?? (_instance = CategoriesRepository._());

  // get categories.
  Future<List<Category>?> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection(Constants.firebaseFirestoreCollectionCategories)
              .get();
      return querySnapshot.docs
          .map((e) => Category.fromJson(e.data())..id = e.id)
          .toList();
    } catch (error) {
      // error.
      debugPrint('error : $error');
      return null;
    }
  }
}
