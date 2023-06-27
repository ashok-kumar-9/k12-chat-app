import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

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
  border: InputBorder.none
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

Color avatarBg1 = Colors.grey[350]??Colors.grey;
Color avatarBg2 = Colors.blue;

class Icon1 extends StatelessWidget {
  final String name;

  const Icon1({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: avatarBg2,
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

