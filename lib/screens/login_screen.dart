import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/reusable_components/toasts/custom_toast.dart';
import 'package:flash_chat/screens/group_chat_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/reset_password.dart';
import 'package:flash_chat/services/email_validation.dart';
import 'package:flash_chat/services/error_messages.dart';
import 'package:flash_chat/services/shared_prefs.dart';
import 'package:flash_chat/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../reusable_components/reusable_widgets.dart';
import '../reusable_components/textfields/credentials_textfield.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();
  String? email;
  String? password;
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
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, TextEditingValue value, __) {
          return ModalProgressHUD(
            inAsyncCall: _saving,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SpacerConstant.spacer2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ReusableWidgets().appLogoImage(),
                  const SizedBox(height: SpacerConstant.spacer3 * 2),
                  CredentialsTextField(
                    onChanged: (value) {
                      email = value;
                    },
                    isPassword: false,
                    isSubmitted: _submitted,
                    controller: _controller,
                  ),
                  const SizedBox(height: SpacerConstant.spacer2),
                  CredentialsTextField(
                    onChanged: (value) {
                      //Do something with the user input.
                      setState(() {
                        password = value;
                      });
                    },
                    isPassword: true,
                  ),
                  const SizedBox(height: SpacerConstant.spacer3),
                  ReusableWidgets().customButton(
                    onTap: password == null || password == ''
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
                                //var user =
                                await _auth.signInWithEmailAndPassword(
                                    email: email!, password: password!);

                                showCustomToast(
                                    message: 'Welcome to Flash Chat');

                                SharedPrefs().email = email!;
                                SharedPrefs().isLoggedIn = true;
                                Navigator.of(context)
                                    .popAndPushNamed(GroupChatScreen.id);
                                setState(() {
                                  _saving = false;
                                });
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  _saving = false;
                                });
                                String errorMessage =
                                    getErrorMessage('login', e.code);

                                //print(e.code);
                                showCustomToast(message: errorMessage);
                              }
                            }
                          },
                    buttonText: "Login",
                    color: (password == '' ||
                            email == null ||
                            password == null ||
                            email == '')
                        ? AppColors.grey
                        : AppColors.blue,
                    shadowColor: (password == '' ||
                            email == null ||
                            password == null ||
                            email == '')
                        ? AppColors.blue
                        : AppColors.grey,
                  ),
                  const SizedBox(height: SpacerConstant.spacer3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: const Text('New User? Sign Up', style: TextStyle(color: AppColors.blue),),
                        onPressed: () {
                          Navigator.pushNamed(context, RegistrationScreen.id);
                        },
                      ),
                      TextButton(
                        child: const Text('Forgot Password', style: TextStyle(color: AppColors.blue),),
                        onPressed: () {
                          Navigator.pushNamed(context, ResetPasswordScreen.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
