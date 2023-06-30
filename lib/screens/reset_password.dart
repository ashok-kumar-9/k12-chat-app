import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/reusable_components/toasts/custom_toast.dart';
import 'package:flash_chat/services/email_validation.dart';
import 'package:flash_chat/services/error_messages.dart';
import 'package:flash_chat/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../reusable_components/reusable_widgets.dart';
import '../reusable_components/textfields/credentials_textfield.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  static const String id = 'reset_password_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: const ResetForm(),
    );
  }
}

class ResetForm extends StatefulWidget {
  const ResetForm({super.key});

  @override
  State<ResetForm> createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  final _controller = TextEditingController();
  String? email;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _saving = false;
  bool _submitted = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, __) {
        return ModalProgressHUD(
          inAsyncCall: _saving,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: PaddingConstants.padding3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ReusableWidgets().appLogoImage(),
                const SizedBox(height: SpacerConstant.spacer3),
                CredentialsTextField(
                  onChanged: (value) {
                    email = value;
                  },
                  isPassword: false,
                  isSubmitted: _submitted,
                  controller: _controller,
                ),
                const SizedBox(height: SpacerConstant.spacer3),
                ReusableWidgets().customButton(
                  onTap: validateEmail(_controller.value.text) != null
                      ? () {
                          setState(() {
                            _submitted = true;
                          });
                        }
                      : () async {
                          setState(() {
                            _submitted = true;
                          });
                          if (validateEmail(_controller.value.text) == null) {
                            setState(() {
                              _saving = true;
                            });
                            try {
                              await _auth.sendPasswordResetEmail(email: email!);
                              setState(() {
                                _saving = false;
                              });
                              showCustomToast(
                                  message: 'Reset link sent to your email.');
                              Navigator.pop(context);
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                _saving = false;
                              });
                              String errorMessage =
                                  getErrorMessage('reset', e.code);

                              //print(e.code);
                              showCustomToast(message: errorMessage);
                            }
                          } else {
                            null;
                          }
                        },
                  buttonText: 'Receive reset link on your email',
                  color: (email == null || email == '')
                      ? AppColors.grey
                      : AppColors.blue,
                  shadowColor: (email == null || email == '')
                      ? AppColors.blue
                      : AppColors.grey,
                ),
                const SizedBox(height: SpacerConstant.spacer4),
              ],
            ),
          ),
        );
      },
      valueListenable: _controller,
    );
  }
}
