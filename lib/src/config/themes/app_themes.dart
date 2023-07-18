import 'package:flutter/material.dart';
import 'package:sezon/src/config/helpers.dart';

// light theme.
ThemeData lightTheme() {
  return ThemeData(
    fontFamily: Helpers.getFontFamily(),
    primaryColor: const Color(0xffD92728),
    colorScheme: const ColorScheme.light(
      primary: Color(0xffD92728),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xffD92728),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
