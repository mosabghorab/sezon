class ProductsService {
  static ProductsService? _instance;

  // private constructor.
  ProductsService._();

  // singleton pattern.
  static ProductsService get instance =>
      _instance ?? (_instance = ProductsService._());
}
