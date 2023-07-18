import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/ui/widgets/app_widget/app_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/app_widget/app_widget_controller.dart';
import 'package:sezon/src/start_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StartUp.initBeforeAppBuilding();
  // for previewing the app on multi screen sizes.
  runApp(
    DevicePreview(
      enabled: false,
      builder: (_) => Builder(
        builder: (context) {
          Get.put<AppWidgetController>(AppWidgetController());
          return const AppWidget();
        },
      ),
    ),
  );
}
