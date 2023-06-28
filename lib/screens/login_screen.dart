import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/utils/constants.dart';
import 'package:flash_chat/reusable_components/toasts/custom_toast.dart';
import 'package:flash_chat/screens/group_chat_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/reset_password.dart';
import 'package:flash_chat/services/email_validation.dart';
import 'package:flash_chat/services/error_messages.dart';
import 'package:flash_chat/services/shared_prefs.dart';
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
                  const SizedBox(height: 48.0),
                  CredentialsTextField(
                    onChanged: (value) {
                      email = value;
                    },
                    isPassword: false,
                    isSubmitted: _submitted,
                    controller: _controller,
                  ),
                  const SizedBox(height: 12.0),
                  CredentialsTextField(
                    onChanged: (value) {
                      //Do something with the user input.
                      setState(() {
                        password = value;
                      });
                    },
                    isPassword: true,
                  ),
                  const SizedBox(height: 24.0),
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

                                showCustomToast(message: 'Welcome to Flash Chat');

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
                        ? Colors.grey[400]!
                        : Colors.blueAccent,
                    shadowColor: (password == '' ||
                            email == null ||
                            password == null ||
                            email == '')
                        ? Colors.blueAccent
                        : Colors.grey[400]!,
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: const Text(
                          'New User? Sign Up',
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, RegistrationScreen.id);
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'Forgot Password',
                        ),
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
