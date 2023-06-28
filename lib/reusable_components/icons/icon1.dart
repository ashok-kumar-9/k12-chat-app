import 'package:flutter/material.dart';

import '../../constants.dart';

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