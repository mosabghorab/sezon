import 'package:get/get.dart';
import 'package:sezon/src/modules/products/data_sources/remote_data_source/firebase_data_source/products_repository.dart';
import 'package:sezon/src/modules/products/models/product.dart';

class ProductsService extends GetxService {
  // repository.
  late final ProductsRepository _productsRepository =
      ProductsRepository.instance;

  // get products.
  Future<List<Product>?> getProducts({
    String? categoryId,
    String? name,
  }) async {
    return _productsRepository.getProducts(
      categoryId: categoryId,
      name: name,
    );
  }

  // get product by id.
  Future<Product?> getProductById({
    required String productId,
  }) async {
    return _productsRepository.getProductById(productId: productId);
  }
}
