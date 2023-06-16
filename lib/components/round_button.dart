import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({
    super.key,
    required this.buttonColor,
    required this.textOnButton,
    required this.callBack,
  });
  late String textOnButton;
  late Color buttonColor;
  late VoidCallback callBack;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callBack,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            textOnButton,
          ),
        ),
      ),
    );
  }
}
