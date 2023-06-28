import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MessageField extends StatelessWidget {

  final TextEditingController controller;
  final Function(String val)? onChanged;

  const MessageField({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: TextFieldDecorations.kMessageTextFieldDecoration,
        style: const TextStyle(color: AppColors.blue),
        maxLines: null,
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}
