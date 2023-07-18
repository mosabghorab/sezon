import 'dart:convert';
import 'dart:io';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sezon/src/config/core/enums.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';
import 'package:sezon/src/modules/_app/ui/widgets/confirmation_widget.dart';
import 'package:sezon/src/modules/_app/ui/widgets/loading_widget.dart';

class Helpers {
  // show message.
  static void showMessage({
    required String text,
    required MessageType messageType,
    bool persistent = true,
  }) {
    showFlash(
      context: Get.context!,
      persistent: persistent,
      duration: const Duration(seconds: 3),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          margin: EdgeInsets.only(
            bottom: 20.h,
            left: 10.w,
            right: 10.w,
          ),
          borderRadius: BorderRadius.circular(
            8.r,
          ),
          boxShadows: kElevationToShadow[8],
          backgroundColor: messageType == MessageType.successMessage
              ? Colors.green
              : Colors.red,
          onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.ease,
          reverseAnimationCurve: Curves.bounceIn,
          alignment: Alignment.bottomCenter,
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
              fontFamily: Helpers.getFontFamily(),
            ),
            child: FlashBar(
              content: Text(
                text,
                style: TextStyle(
                  fontFamily: Helpers.getFontFamily(),
                  fontWeight: FontWeight.w500,
                ),
              ),
              //   leftBarIndicatorColor: Colors.red,
              icon: Icon(
                messageType == MessageType.successMessage
                    ? Icons.check
                    : Icons.error,
                color: Colors.white,
              ),
              primaryAction: TextButton(
                onPressed: () => controller.dismiss(),
                child: Text(
                  'تجاهل',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: Helpers.getFontFamily(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // shortcut for showing bottom sheet.
  static Future showBottomSheet({
    required Widget child,
    Color? backgroundColor,
    double radius = 12,
    bool isScrollControlled = true,
  }) async {
    return await Get.bottomSheet(
      child,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radius.r),
        ),
      ),
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
    );
  }

  // show dialog.
  static void showADialog({
    required BuildContext context,
    required Widget child,
  }) {
    showDialog(
      context: context,
      builder: (_) => child,
    );
  }

  // show loading dialog.
  static void showLoading({
    String? title,
  }) {
    showDialog(
      context: Get.context!,
      builder: (_) => LoadingWidget(
        title: title,
      ),
      barrierDismissible: false,
    );
  }

  // show confirmation.
  static void showConfirmation({
    required final String title,
    required final String description,
    required final String confirmText,
    final String? iconName,
    Color? buttonColor,
    required final void Function() onConfirm,
  }) {
    showDialog(
      context: Get.context!,
      builder: (_) => ConfirmationWidget(
        title: title,
        description: description,
        confirmText: confirmText,
        iconName: iconName,
        onConfirm: onConfirm,
        buttonColor: buttonColor,
      ),
    );
  }

  // check if the user is signed in or not.
  // static bool checkAuth({
  //   required BuildContext context,
  // }) {
  //   if (AppSharedData.currentUser == null) {
  //     showConfirmationDialog(
  //       context: context,
  //       description: 'You are not signed in to make this action'.tr,
  //       confirmText: 'Sign In'.tr,
  //       onConfirm: () {
  //         N.offAllNamed(Constants.screensLandingScreen);
  //       },
  //     );
  //   }
  //   return AppSharedData.currentUser != null;

  // request current user position.
  // static void requestCurrentUserPosition({
  //   required final BuildContext? context,
  //   required final void Function(Position currentPosition) onLocationEnabled,
  //   required final void Function(dynamic error) onLocationError,
  // }) async {
  //   try {
  //     showDialog(
  //       context: context!,
  //       builder: (_) => const LoadingDialogComponent(),
  //     );
  //     await Geolocator.requestPermission();
  //     Position currentUserPosition = await Geolocator.getCurrentPosition();
  //     // success.
  //     N.back();
  //     onLocationEnabled(currentUserPosition);
  //   } catch (error) {
  //     // error.
  //     N.back();
  //     onLocationError(error);
  //     debugPrint('error : ${error.toString()}');
  //   }
  // }

  // open location on google map app.
  // static void openLocationOnGoogleMapApp({
  //   required BuildContext context,
  //   required double lat,
  //   required double long,
  // }) async {
  //   try {
  //     String mapSchema = Platform.isAndroid
  //         ? 'https://www.google.com/maps/search/?api=1&query=$lat,$long'
  //         // ? 'geo:$lat,$long'
  //         : 'https://maps.apple.com/?q=$lat,$long';
  //     await launchUrl(Uri.parse(mapSchema));
  //   } catch (error) {
  //     debugPrint("couldn't launch the google map: $error");
  //     Helpers.showMessage(
  //         context: context,
  //         text: 'Something went wrong'.tr,
  //         messageType: MessageType.failureMessage);
  //   }
  // }

  // get bytes from asset.
  // static Future<Uint8List> getBytesFromAsset({
  //   required String path,
  //   required int width,
  //   required int height,
  // }) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(
  //     data.buffer.asUint8List(),
  //     targetWidth: width,
  //     targetHeight: height,
  //   );
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
  //       .buffer
  //       .asUint8List();
  // }

  // get current font family.
  static String getFontFamily() =>
      SharedPreferencesManager.instance.getAppLang() == 'en'
          ? 'tajawal'
          : 'tajawal';

  // get years.
  static List<String> getYears() => List.generate(
        (DateTime.now().year + 1) - 1949,
        (index) => '${(DateTime.now().year + 1) - index}',
      );

  // email validator.
  static bool isValidEmailAddress(String text) => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(text);

  // mobile validator.
  static bool isValidMobile(String text) => text.length == 9;

  // password validator.
  static bool isValidPassword(String text) => text.length >= 8;

  // url validator.
  static bool isValidUrl(String text) => RegExp(
          r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)')
      .hasMatch(text);

  // headers.
  static Map<String, dynamic> headers({
    String? token,
  }) =>
      {
        // 'Authorization': 'Bearer ${token ?? AppSharedData.currentUser?.token}',
      };

  // image encryption.
  static String encryptImage({
    required File image,
  }) {
    return 'data:image/${image.path.substring(image.path.lastIndexOf('.') + 1)};base64,${base64Encode(image.readAsBytesSync())}';
  }

  // to num.
  static num toNum(dynamic value) {
    if (value is num) {
      return value;
    } else if (value is String) {
      return num.tryParse(value) ?? 0;
    } else {
      return 0;
    }
  }

  // to int.
  static int toInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    } else {
      return 0;
    }
  }

  // to double.
  static double toDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0;
    } else {
      return 0;
    }
  }

  // format date.
  static String formatDate(DateTime dateTime, {bool withTime = false}) {
    if (withTime) {
      return intl.DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
    } else {
      return intl.DateFormat('yyyy-MM-dd').format(dateTime);
    }
  }

  // format time.
  static String formatTime(
    DateTime dateTime, {
    bool withSeconds = false,
  }) {
    return withSeconds
        ? intl.DateFormat('hh:mm:ss a').format(dateTime)
        : intl.DateFormat('hh:mm a').format(dateTime);
  }
}
