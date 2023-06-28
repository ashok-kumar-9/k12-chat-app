import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/reusable_widgets.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/services/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  static const String id = 'reset_password_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
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

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    if (text.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(text)) {
      return "Enter valid email address";
    }
    // return null if the text is valid
    return null;
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 150.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  style: CustomTextStyles.kTextInputStyle,
                  decoration: TextFieldDecorations.kTextFieldDecoration.copyWith(
                    errorText: _submitted ? _errorText : null,
                  ),
                  controller: _controller,
                ),
                const SizedBox(height: 24.0),
                ReusableWidgets().textButton(
                  function: _errorText != null
                      ? () {
                          setState(() {
                            _submitted = true;
                          });
                        }
                      : () async {
                          setState(() {
                            _submitted = true;
                          });
                          if (_errorText == null) {
                            setState(() {
                              _saving = true;
                            });
                            try {
                              await _auth.sendPasswordResetEmail(email: email!);
                              setState(() {
                                _saving = false;
                              });
                              Fluttertoast.showToast(
                                msg: 'Reset link sent to your email.',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              Navigator.pop(context);
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                _saving = false;
                              });
                              String errorMessage =
                                  getErrorMessage('reset', e.code);

                              //print(e.code);
                              Fluttertoast.showToast(
                                msg: errorMessage,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.blue,
                                fontSize: 16.0,
                              );
                            }
                          } else {
                            null;
                          }
                        },
                  buttonText: 'Receive reset link on your email',
                  color: (email == null || email == '')
                      ? Colors.grey[400]!
                      : Colors.blueAccent,
                  shadowColor: (email == null || email == '')
                      ? Colors.blueAccent
                      : Colors.grey[400]!,
                ),
              ],
            ),
          ),
        );
      },
      valueListenable: _controller,
    );
  }
}
