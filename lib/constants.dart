import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kBorderRadius = 8.0;

var kMessageTextFieldDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(
    color: Colors.grey[600],
  ),
  border: InputBorder.none,
);

var kMessageContainerDecoration = BoxDecoration(
  border: Border.all(
    color: Colors.blue,
    width: 1,
  ),
  borderRadius: BorderRadius.circular(24),
  color: Colors.grey[200],
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

class AppColors {
  static Color onBoarding1 = const Color(0xFFBAD3C8);
  static Color onBoarding2 = const Color(0xFFFFE59E);
  static Color onBoarding3 = const Color(0xFFDC9696);
  static Color bgColor = const Color(0xFF0D1117);
  static Color bgColorHome = const Color(0xFF0B141A);
  static Color appBarColor = const Color(0xFF202C33);
  static Color sendChatColor = const Color(0xFF202C33);
  static Color toChatColor = const Color(0xFF005C4B);
}



class Icon1 extends StatelessWidget {
  final String name;

  const Icon1({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: AppColors.sendChatColor,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
