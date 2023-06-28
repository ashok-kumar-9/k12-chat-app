import 'package:flash_chat/services/email_validation.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class CredentialsTextField extends StatelessWidget {

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool? isSubmitted;
  final bool isPassword;

  const CredentialsTextField({super.key, this.controller, this.onChanged, this.isSubmitted, required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      obscureText: isPassword,
      keyboardType: isPassword ? TextInputType.text : TextInputType.emailAddress,
      onChanged: onChanged,
      style: CustomTextStyles.kTextInputStyle,
      decoration: isPassword ? TextFieldDecorations.kTextFieldDecoration
          .copyWith(hintText: 'Enter your password') : TextFieldDecorations.kTextFieldDecoration.copyWith(
        errorText: isSubmitted??true ? validateEmail(controller?.value.text) : null,
      ),
      controller: controller,
    );
  }
}
