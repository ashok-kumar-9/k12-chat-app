import 'package:flutter/material.dart';

class RadiusConstants {
  static double kBorderRadius = 8.0;
  static double sendButtonRadius = 20;
  static double chatAvatarRadius=15.0;
}

class CustomTextStyles {
  static TextStyle kSendButtonTextStyle = const TextStyle(
    color: Colors.lightBlueAccent,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  static TextStyle kTextInputStyle = const TextStyle(
    color: Colors.white,
  );
}

class AppColors {
  static Color onBoarding1 = const Color(0xFFBAD3C8);
  static Color onBoarding2 = const Color(0xFFFFE59E);
  static Color onBoarding3 = const Color(0xFFDC9696);
  static Color bgColor = const Color(0xFF0D1117);
  static Color bgColorHome = const Color(0xFF0B141A);
  static Color appBarColor = const Color(0xFF202C33);
  static Color sendChatColor = const Color(0xFF202C33);
  static Color toChatColor = const Color(0xFF005C4B);
  static Color toChatInactiveColor = const Color(0xFF005C4B).withOpacity(0.5);
}

class TextFieldDecorations {
  static InputDecoration kMessageTextFieldDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    hintStyle: TextStyle(
      color: Colors.grey[600],
    ),
    border: InputBorder.none,
  );
  static InputDecoration kTextFieldDecoration = InputDecoration(
    hintText: 'Enter your email',
    hintStyle: TextStyle(
      color: Colors.grey[400],
      fontSize: 16,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    filled: false,
    focusColor: Colors.blue,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(RadiusConstants.kBorderRadius)),
      borderSide: const BorderSide(width: 2, color: Colors.blueAccent),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(RadiusConstants.kBorderRadius)),
      borderSide: const BorderSide(width: 1, color: Colors.orange),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(RadiusConstants.kBorderRadius)),
      borderSide: const BorderSide(width: 1, color: Colors.blueAccent),
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(RadiusConstants.kBorderRadius)),
        borderSide: const BorderSide(
          width: 1,
        )),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(RadiusConstants.kBorderRadius)),
        borderSide: const BorderSide(width: 1, color: Colors.red)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(RadiusConstants.kBorderRadius)),
        borderSide: const BorderSide(width: 1, color: Colors.yellowAccent)),
  );
}

class ContainerDecorations {
  static BoxDecoration kMessageContainerDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.blue,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(24),
    color: Colors.grey[200],
  );
}

Widget text2(context, text, onTap, id) {
  return TextButton(
    child: const Text(
      'New User? Sign Up',
    ),
    onPressed: () {
      Navigator.pushNamed(context, id);
    },
  );
}
