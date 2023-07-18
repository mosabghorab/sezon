import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
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
            SharedPreferencesManager.instance.getAppLang() ??
                Constants.sharedPreferencesAppLangDefaultValue,
          ),
          builder: DevicePreview.appBuilder,
          // supportedLocales:
          //     Constants.supportedLocales.keys.map((e) => Locale(e)),
          title: Constants.appName,
          getPages: AppRouter.routes,
          initialRoute: AppRouter.splash,
        ),
      ),
    );
  }
}
