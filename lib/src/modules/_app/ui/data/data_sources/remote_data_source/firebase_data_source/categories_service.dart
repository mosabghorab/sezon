import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sezon/src/modules/_app/ui/data/models/category.dart';

class CategoriesService {
  static CategoriesService? _instance;

  late final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // private constructor.
  CategoriesService._();

  // singleton pattern.
  static CategoriesService get instance =>
      _instance ?? (_instance = CategoriesService._());

  // get categories.
  Future<List<Category>?> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection('categories').get();
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
