import 'dart:async';

import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/config/shared_data.dart';
import 'package:sezon/src/modules/auth/models/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  static SharedPreferences? _sharedPreferences;

  //||... private constructor ...||
  SharedPreferencesManager._();

  //||... singleton pattern ...||
  static SharedPreferencesManager get instance =>
      _instance ?? (_instance = SharedPreferencesManager._());

  //||... init the shared preferences object ...||
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /////////////////////////////////////////////////////////////////////////////////

  //||...  get the current app lang ...||
  String? getAppLang() {
    return _sharedPreferences!.getString(Constants.sharedPreferencesAppLang) ??
        Constants.sharedPreferencesAppLangDefaultValue;
  }

  //||...  set the current app lang ...||
  Future<void> setAppLang(String lang) async {
    await _sharedPreferences!
        .setString(Constants.sharedPreferencesAppLang, lang);
  }

  //||...  get the current user data ...||
  AppUser? getUserData() {
    String? userJson =
        _sharedPreferences!.getString(Constants.sharedPreferencesUserData);
    if (userJson == null) return null;
    return SharedData.currentUser = appUserFromStringJson(userJson);
  }

  //||...  set the current user data ...||
  Future<void> setUserData(AppUser user) async {
    SharedData.currentUser = user;
    await _sharedPreferences!.setString(
      Constants.sharedPreferencesUserData,
      appUserToStringJson(user),
    );
  }

  //||...  is notifications enabled ...||
  // Future<void> setIsNotificationsEnabled(bool isNotificationsEnabled) async {
  //   await _sharedPreferences!.setBool(
  //       Constants.sharedPreferencesIsNotificationEnabled,
  //       isNotificationsEnabled);
  // }

  //||...  method for getting the notifications is enabled or not ...||
  // bool isNotificationsEnabled() {
  //   return _sharedPreferences!
  //           .getBool(Constants.sharedPreferencesIsNotificationEnabled) ??
  //       Constants.sharedPreferencesIsNotificationEnabledDefaultValue;
  // }

  //||...  set is dark mode enabled ...||
  // Future<void> setIsDarkModeEnabled(bool isDarkModeEnabled) async {
  //   await _sharedPreferences!.setBool(
  //       Constants.sharedPreferencesIsDarkModeEnabled, isDarkModeEnabled);
  // }

  //||...  is dark mode enabled ...||
  // bool isDarkModeEnabled() {
  //   return _sharedPreferences!
  //           .getBool(Constants.sharedPreferencesIsDarkModeEnabled) ??
  //       Constants.sharedPreferencesIsDarkModeEnabledDefaultValue;
  // }

  //||... clear all shared preferences ...||
  Future<void> clear() async {
    await _sharedPreferences!.clear();
  }

//||...  clear all user data ...||
  Future<void> clearUserData() async {
    await _sharedPreferences!.remove(Constants.sharedPreferencesUserData);
    SharedData.currentUser = null;
  }
}
