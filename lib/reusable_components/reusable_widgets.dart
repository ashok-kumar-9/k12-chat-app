import 'package:flutter/material.dart';

class ReusableWidgets {
  GestureDetector customButton(
      {required Function() onTap,
      required String buttonText,
      Color color = Colors.black,
      Color shadowColor = Colors.blueAccent}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: color,
              boxShadow: [
                BoxShadow(
                    color: shadowColor,
                    blurRadius: 0.0,
                    spreadRadius: 1.0,
                    offset: const Offset(3.0, 2.5))
              ]),
          child: Center(
              child: Text(buttonText,
                  style: const TextStyle(color: Colors.white))),
        ),
      ),
    );
  }
}
