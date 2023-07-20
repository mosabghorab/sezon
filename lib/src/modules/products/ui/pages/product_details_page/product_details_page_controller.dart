import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/products/models/product.dart';
import 'package:sezon/src/modules/products/products_router.dart';
import 'package:sezon/src/modules/products/services/products_service.dart';

class ProductDetailsPageController extends GetxController {
  // notifiable.
  void notifySlider() {
    update(['slider']);
  }

  void notifySuggestedProducts() {
    update(['suggestedProducts']);
  }

  // services.
  late final ProductsService _productsService = Get.find<ProductsService>();

  // flags.
  bool isSuggestedProductsLoading = true;
  bool isSuggestedProductsLoadingFailed = false;

  // data.
  List<Product> suggestedProducts = [];

  // vars.
  int selectedSliderIndex = 0;

  // arguments.
  late Product product;

  // on init.
  @override
  void onInit() {
    product = Get.arguments['product'];
    getSuggestedProducts();
    super.onInit();
  }

  // get suggested products.
  void getSuggestedProducts({
    bool notifyLoading = false,
  }) async {
    try {
      if (notifyLoading) {
        isSuggestedProductsLoading = true;
        isSuggestedProductsLoadingFailed = false;
        notifySuggestedProducts();
      }
      List<Product>? products = await _productsService.getProducts();
      if (products != null) {
        // success.
        products.removeWhere((element) => element.id == product.id);
        suggestedProducts = products;
      } else {
        // failed.
        debugPrint('failed');
        isSuggestedProductsLoadingFailed = true;
      }
      isSuggestedProductsLoading = false;
      notifySuggestedProducts();
    } catch (error) {
      debugPrint('error : $error');
      isSuggestedProductsLoading = false;
      isSuggestedProductsLoadingFailed = true;
      notifySuggestedProducts();
    }
  }

  // refresh suggested products.
  Future<void> refreshSuggestedProducts() async {
    getSuggestedProducts(notifyLoading: true);
  }

  // navigate to checkout page.
  void navigateToCheckoutPage() {
    Get.toNamed(ProductsRouter.checkoutPage, arguments: {
      'product': product,
    });
  }

  // on page changed.
  void onPageChanged(int value, CarouselPageChangedReason reason) {
    selectedSliderIndex = value;
    notifySlider();
  }
}
