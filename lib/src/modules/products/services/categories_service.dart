import 'package:get/get.dart';
import 'package:sezon/src/modules/products/data_sources/remote_data_source/firebase_data_source/categories_repository.dart';
import 'package:sezon/src/modules/products/models/category.dart';

class CategoriesService extends GetxService {
  // repository.
  late final CategoriesRepository _categoriesRepository =
      CategoriesRepository.instance;

  // get categories.
  Future<List<Category>?> getCategories() async {
    return _categoriesRepository.getCategories();
  }
}
