import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/config/initial_binding.dart';
import 'package:sezon/src/config/localization/app_translations.dart';
import 'package:sezon/src/config/themes/app_themes.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';
import 'package:sezon/src/modules/_app/app_router.dart';

import 'app_widget_controller.dart';

class AppWidget extends GetView<AppWidgetController> {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppWidgetController>(
      id: 'app',
      builder: (controller) => ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => GetMaterialApp(
          theme: lightTheme(),
          locale: Locale(
            SharedPreferencesManager.instance.getAppLang()!,
          ),
          builder: DevicePreview.appBuilder,
          supportedLocales:
              Constants.supportedLocales.keys.map((e) => Locale(e)),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialBinding: InitialBinding(),
          translations: AppTranslations(),
          defaultTransition: Transition.cupertino,
          title: Constants.appName,
          getPages: AppRouter.routes,
          initialRoute: AppRouter.splashPage,
        ),
      ),
    );
  }
}
