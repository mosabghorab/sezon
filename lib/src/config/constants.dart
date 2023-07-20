class Constants {
  //||... app name ...||
  static const String appName = "Sezon";

//           ||-------------------------------------------||

  //||... shared preferences ...||
  static const String sharedPreferencesAppLang = 'appLang';
  static const String sharedPreferencesAppLangDefaultValue = 'en';
  static const String sharedPreferencesIsNotificationEnabled =
      'isNotificationsEnabled';
  static const bool sharedPreferencesIsNotificationEnabledDefaultValue = true;
  static const String sharedPreferencesUserData = 'userData';

  //||... shared preferences ...||

//           ||-------------------------------------------||

  //||... api ...||
  // production base url.
  //   static const String baseUrl = 'http://elixir-kombucha.com/';
  // development base url.
  static const String baseUrl = 'http://elixir-kombucha.com/';
  static const String apiUrl = '${baseUrl}api/';

  //||... api ...||

//           ||-------------------------------------------||

  //||...  supported locales ...||
  static const Map<String, String> supportedLocales = {
    'ar': 'العربية',
    'en': 'English',
  };

  //||...  supported locales ...||

//           ||-------------------------------------------||

  //||... assets ...||
  static const String assetsImagesPath = 'assets/images/';
  static const String assetsVectorsPath = 'assets/vectors/';
  static const String assetsAnimationsPath = 'assets/animations/';

  //||... assets ...||

  //           ||-------------------------------------------||

  //||... static pages ...||
  static const String staticPageAboutUs = 'aboutus';
  static const String staticPageContactUs = 'contactus';
  static const String staticPagePrivacyPolicy = 'privacy&policies';
  static const String staticPageTermsOfUse = 'termsOfUse';

  //||... static pages ...||

  //           ||-------------------------------------------||

  //||... local notifications ...||
  static const String firebasePushNotificationsTopic = 'sezon';
  static const String androidNotificationChannelId = 'sezonId';
  static const String androidNotificationChannelName = 'sezon';

  //||... local notifications ...||

  //           ||-------------------------------------------||

  //||... firebase dynamic links ...||
  // static const String firebaseDynamicLinksUriPrefix =
  //     'https://jordan.page.link';
  //
  // // firebase dynamic links types.
  // static const String firebaseDynamicLinksTypeAd = 'ad';
  // static const String firebaseDynamicLinksTypeShop = 'shop';
  // static const String firebaseDynamicLinksTypeNews = 'news';
  // static const String firebaseDynamicLinksTypeOffer = 'offer';

  //||... firebase dynamic links ...||

  //||... firebase firestore collections ...||
  static const String firebaseFirestoreCollectionUsers = 'users';
  static const String firebaseFirestoreCollectionFavorites = 'favorites';
  static const String firebaseFirestoreCollectionOrders = 'orders';
  static const String firebaseFirestoreCollectionProducts = 'products';
  static const String firebaseFirestoreCollectionCategories = 'categories';
//||... firebase firestore collections ...||
}
