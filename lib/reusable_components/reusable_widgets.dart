import 'package:flash_chat/utils/constants.dart';
import 'package:flash_chat/utils/screen_size.dart';
import 'package:flutter/material.dart';

class ReusableWidgets {
  GestureDetector customButton(
      {required Function() onTap,
      required String buttonText,
      Color color = AppColors.black,
      Color shadowColor = AppColors.blue}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: ScreenSize.screenHeight * 0.05,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: ScreenSize.screenWidth * 0.08),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(RadiusConstants.kBorderRadius),
              color: color,
              boxShadow: [
                BoxShadow(
                    color: shadowColor,
                    spreadRadius: 1.0,
                    offset: const Offset(2.5, 2.0))
              ]),
          child: Center(child: Text(buttonText)),
        ),
      ),
    );
  }

  Flexible appLogoImage() {
    return Flexible(
      child: Hero(
        tag: 'logo',
        child: SizedBox(
          height: ScreenSize.screenHeight * 0.15,
          child: Image.asset('images/logo.png'),
        ),
      ),
    );
  }
}
