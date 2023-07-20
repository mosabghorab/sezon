import 'package:get/get.dart';
import 'package:sezon/src/modules/auth/services/auth_service.dart';
import 'package:sezon/src/modules/auth/services/users_service.dart';
import 'package:sezon/src/modules/products/services/categories_service.dart';
import 'package:sezon/src/modules/products/services/favorites_service.dart';
import 'package:sezon/src/modules/products/services/orders_service.dart';
import 'package:sezon/src/modules/products/services/products_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // inject all services.
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => UsersService());
    Get.lazyPut(() => CategoriesService());
    Get.lazyPut(() => FavoritesService());
    Get.lazyPut(() => OrdersService());
    Get.lazyPut(() => ProductsService());
  }
}
