import 'package:flutter/material.dart';

class RadiusConstants {
  static const double kBorderRadius = 8.0;
  static const double bubbleRadius = 16.0;
  static const double sendButtonRadius = 20;
  static const double profilePopRadius = 20;
  static const double chatAvatarRadius = 15.0;
  static const double dotIndicatorRadius = 50.0;
}

class PaddingConstants {
  static const double padding1 = 8.0;
  static const double padding2 = 16.0;
  static const double padding3 = 24.0;
  static const double padding4 = 30.0;
}

class SpacerConstant {
  static const double spacer1 = 8.0;
  static const double spacer2 = 16.0;
  static const double spacer3 = 24.0;
  static const double spacer4 = 36.0;
}

extension CustomTextTheme on TextTheme {
  TextStyle get h1 => const TextStyle(
      fontSize: 32.0, fontWeight: FontWeight.w900, color: AppColors.white);

  TextStyle get h2 => const TextStyle(
      fontSize: 24.0, fontWeight: FontWeight.w900, color: AppColors.white);

  TextStyle get h3 => const TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w900, color: AppColors.white);

  TextStyle get h4 => const TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: AppColors.white);

  TextStyle get h5 => const TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.white);

  TextStyle get h6 => const TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w500, color: AppColors.white);

  TextStyle get h7 => const TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.normal, color: AppColors.white);

  TextStyle get h8 => const TextStyle(
      fontSize: 8.0, fontWeight: FontWeight.w500, color: AppColors.white);
}

class AppColors {
  static const Color onBoarding1 = Color(0xFFBAD3C8);
  static const Color onBoarding2 = Color(0xFFFFE59E);
  static const Color onBoarding3 = Color(0xFFDC9696);
  static const Color bgColor = Color(0xFF20232B);
  static const Color appBarColor = Color(0xFF000000);
  static const Color sendChatColor = Color(0xFF16171B);
  static const Color toChatColor = Color(0xFFB785F5);
  static const Color green =  Color(0xFF005C4B);
  static const Color red = Color(0xFFEE6666);
  static const Color blue = Color(0xFF5852D6);
  static const Color yellow = Color(0xFFF4FC8A);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF909090);
}

class CustomTextStyles {
  static TextStyle kSendButtonTextStyle = const TextStyle(
    color: AppColors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  static TextStyle kTextInputStyle = const TextStyle(
    color: Colors.white,
  );
}

class CustomMeasurements {
  static double popupOptionHeight = 36;
}

class TextFieldDecorations {
  static InputDecoration kMessageTextFieldDecoration = const InputDecoration(
    contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    hintStyle: TextStyle(
      color: AppColors.grey,
    ),
    border: InputBorder.none,
  );

  static InputDecoration kTextFieldDecoration = const InputDecoration(
    hintText: 'Enter your email',
    hintStyle: TextStyle(
      color: AppColors.grey,
      fontSize: 16,
    ),
    contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    filled: false,
    focusColor: AppColors.blue,
    focusedBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(RadiusConstants.kBorderRadius)),
      borderSide: BorderSide(width: 2, color: AppColors.blue),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(RadiusConstants.kBorderRadius)),
      borderSide: BorderSide(width: 1, color: Colors.orange),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(RadiusConstants.kBorderRadius)),
      borderSide: BorderSide(width: 1, color: AppColors.blue),
    ),
    border: OutlineInputBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(RadiusConstants.kBorderRadius)),
        borderSide: BorderSide(
          width: 1,
        )),
    errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(RadiusConstants.kBorderRadius)),
        borderSide: BorderSide(width: 1, color: Colors.red)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(RadiusConstants.kBorderRadius)),
        borderSide: BorderSide(width: 1, color: Colors.yellowAccent)),
  );
}

class ContainerDecorations {
  static BoxDecoration kMessageContainerDecoration = BoxDecoration(
    border: Border.all(
      color: AppColors.blue,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(RadiusConstants.bubbleRadius),
    color: Colors.grey[200],
  );
}
