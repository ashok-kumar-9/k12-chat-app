import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kBorderRadius = 16.0;

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

var kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your email',
  hintStyle: TextStyle(
    color: Colors.grey[400],
    fontSize: 16,
  ),
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  filled: false,
  focusColor: Colors.blue,
  focusedBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
    borderSide: BorderSide(width: 2, color: Colors.blueAccent),
  ),
  disabledBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
    borderSide: BorderSide(width: 1, color: Colors.orange),
  ),
  enabledBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
    borderSide: BorderSide(width: 1, color: Colors.blueAccent),
  ),
  border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      borderSide: BorderSide(
        width: 1,
      )),
  errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      borderSide: BorderSide(width: 1, color: Colors.red)),
  focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      borderSide: BorderSide(width: 1, color: Colors.yellowAccent)),
);

const kTextInputStyle = TextStyle(
  color: Colors.white,
);

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
