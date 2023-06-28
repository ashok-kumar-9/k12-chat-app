import 'package:flutter/widgets.dart';

class ScreenSize {
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;

  static void init(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
  }
}
