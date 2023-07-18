import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/ui/data/data_sources/remote_data_source/firebase_data_source/categories_service.dart';
import 'package:sezon/src/modules/_app/ui/data/data_sources/remote_data_source/firebase_data_source/products_service.dart';
import 'package:sezon/src/modules/_app/ui/data/models/category.dart';
import 'package:sezon/src/modules/_app/ui/data/models/product.dart';

class HomePageController extends GetxController {
  // notifiable.
  void notifyCategories() {
    update(['categories']);
  }

  void notifyProducts() {
    update(['products']);
  }

  // services.
  late final CategoriesService _categoriesService = CategoriesService.instance;
  late final ProductsService _productsService = ProductsService.instance;

  // flags.
  bool isCategoriesLoading = true;
  bool isCategoriesLoadingFailed = false;
  bool isProductsLoading = true;
  bool isProductsLoadingFailed = false;

  // data.
  List<Category> categories = [];
  List<Product> products = [];

  // on init.
  @override
  void onInit() {
    getCategories();
    getProducts();
    super.onInit();
  }

  // get categories.
  void getCategories({
    bool notifyLoading = false,
  }) async {
    try {
      if (notifyLoading) {
        isCategoriesLoading = true;
        isCategoriesLoadingFailed = false;
        notifyCategories();
      }
      List<Category>? categories = await _categoriesService.getCategories();
      if (categories != null) {
        // success.
        this.categories = categories;
      } else {
        // failed.
        debugPrint('failed');
        isCategoriesLoadingFailed = true;
      }
      isCategoriesLoading = false;
      notifyCategories();
    } catch (error) {
      debugPrint('error : $error');
      isCategoriesLoading = false;
      isCategoriesLoadingFailed = true;
      notifyCategories();
    }
  }

  // get products.
  void getProducts({
    bool notifyLoading = false,
  }) async {
    try {
      if (notifyLoading) {
        isProductsLoading = true;
        isProductsLoadingFailed = false;
        notifyProducts();
      }
      List<Product>? products = await _productsService.getProducts();
      if (products != null) {
        // success.
        this.products = products;
      } else {
        // failed.
        debugPrint('failed');
        isProductsLoadingFailed = true;
      }
      isProductsLoading = false;
      notifyProducts();
    } catch (error) {
      debugPrint('error : $error');
      isCategoriesLoading = false;
      isProductsLoadingFailed = true;
      notifyProducts();
    }
  }

  // refresh categories.
  void refreshCategories() {
    getCategories(notifyLoading: true);
  }

  // refresh products.
  void refreshProducts() {
    getProducts(notifyLoading: true);
  }
}
