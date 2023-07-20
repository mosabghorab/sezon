import 'package:get/get.dart';
import 'package:sezon/src/config/localization/langs/ar.dart';
import 'package:sezon/src/config/localization/langs/en.dart';

class AppTranslations extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'ar': ar,
        'en': en,
      };
}
