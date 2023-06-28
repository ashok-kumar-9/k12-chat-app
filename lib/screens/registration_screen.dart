import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/reusable_components/toasts/custom_toast.dart';
import 'package:flash_chat/screens/group_chat_screen.dart';
import 'package:flash_chat/services/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../reusable_components/reusable_widgets.dart';
import '../reusable_components/textfields/credentials_textfield.dart';
import '../services/shared_prefs.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class RegistrationScreen extends StatelessWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: const RegsiterForm(),
    );
  }
}

class RegsiterForm extends StatefulWidget {
  const RegsiterForm({super.key});

  @override
  State<RegsiterForm> createState() => _RegsiterFormState();
}

class _RegsiterFormState extends State<RegsiterForm> {
  final _controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
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
                ReusableWidgets().textButton(
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
                            if (_errorText == null) {
                              // print(email);
                              setState(() {
                                _saving = true;
                              });
                              try {
                                //final newUser =

                                await _auth.createUserWithEmailAndPassword(
                                    email: email!, password: password!);

                                SharedPrefs().email = email!;
                                SharedPrefs().isLoggedIn = true;
                                Navigator.pushNamed(
                                    context, GroupChatScreen.id);
                                setState(() {
                                  _saving = false;
                                });
                                showCustomToast(message: 'Welcome to Flash Chat');
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  _saving = false;
                                });
                                String errorMessage;
                                errorMessage =
                                    getErrorMessage('signup', e.code);

                                debugPrint(e.code);
                                showCustomToast(message: errorMessage);
                              }
                            } else {
                              null;
                            }
                          },
                    buttonText: 'Register',
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
                        : Colors.grey[400]!),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text(
                        'Already a user',
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
