import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sezon/src/managers/firebase_messaging_manager.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';

import 'managers/local_notifications_manager.dart';

class StartUp {
  // init before app building.
  static Future<void> initBeforeAppBuilding() async {
    // this is for status bar color.
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent, //Color for Android
          statusBarBrightness:
              Brightness.light //Dark == white status bar -- for IOS.
          ),
    );

    // init shared preferences manager.
    await SharedPreferencesManager.init();
  }

  // init after app building.
  static Future<void> initAfterAppBuilding() async {
    // init firebase.
    await Firebase.initializeApp();

    // init futures.
    await Future.wait([
      // init local notifications manager.
      LocalNotificationsManager.instance.init(),

      // init firebase messaging manager.
      FirebaseMessagingManager.instance.init(),

      // init dynamic links manager.
      // DynamicLinksService.instance.init(),

      // init pusher manager.
      // PusherManager.instance.init(),
    ]);

    // init time ago.
    // setLocaleMessages('en', EnMessages());
    // setLocaleMessages('ar', ArMessages());
    // if (SharedPreferencesManager.instance.getAppLang() != null) {
    //   setDefaultLocale(SharedPreferencesManager.instance.getAppLang()!);
    // }
  }
}
