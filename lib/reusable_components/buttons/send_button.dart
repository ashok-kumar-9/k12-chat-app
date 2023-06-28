import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class SendButton extends StatelessWidget {
  final bool isActive;

  const SendButton({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: isActive ? AppColors.grey : AppColors.toChatColor,
      radius: RadiusConstants.sendButtonRadius,
      child: const Padding(
        padding: EdgeInsets.only(left: PaddingConstants.padding1 * 0.5),
        child: Icon(Icons.send, color: AppColors.white),
      ),
    );
  }
}
