import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class SendButton extends StatelessWidget {

  final bool isActive;

  const SendButton({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: isActive ? AppColors.toChatInactiveColor : AppColors.toChatColor,
      radius: RadiusConstants.sendButtonRadius,
      child: const Padding(
        padding: EdgeInsets.only(left: 4.0),
        child: Icon(Icons.send, color: Colors.white, size: 18),
      ),
    );
  }
}
