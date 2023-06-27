import 'package:flutter/material.dart';

class ReusableWidgets {
  GestureDetector textButton(
      {required Function() function, required String buttonText}) {
    return GestureDetector(
      onTap: function,
      child: SizedBox(
        height: 50,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.black,
              boxShadow: const [
                BoxShadow(
                    color: Colors.blueAccent,
                    blurRadius: 0.0,
                    spreadRadius: 1.0,
                    offset: Offset(3.0, 2.5))
              ]),
          child: Center(
              child: Text(buttonText,
                  style: const TextStyle(color: Colors.white))),
        ),
      ),
    );
  }
}
