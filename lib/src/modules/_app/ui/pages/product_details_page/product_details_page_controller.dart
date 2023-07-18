import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/app_router.dart';
import 'package:sezon/src/modules/_app/ui/data/data_sources/remote_data_source/firebase_data_source/products_service.dart';
import 'package:sezon/src/modules/_app/ui/data/models/product.dart';

class ProductDetailsPageController extends GetxController {
  // notifiable.
  void notifySlider() {
    update(['slider']);
  }

  void notifySuggestedProducts() {
    update(['suggestedProducts']);
  }

  // services.
  late final ProductsService _productsService = ProductsService.instance;

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
    Get.toNamed(AppRouter.checkoutPage, arguments: {
      'product': product,
    });
  }

  // on page changed.
  void onPageChanged(int value, CarouselPageChangedReason reason) {
    selectedSliderIndex = value;
    notifySlider();
  }
}
