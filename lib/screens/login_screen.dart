import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/reusable_widgets.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/group_chat_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/reset_password.dart';
import 'package:flash_chat/services/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _controller = TextEditingController();
  String? email;
  String? password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _saving = false;
  bool _submitted = false;

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code

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
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  style: kTextInputStyle,
                  decoration: kTextFieldDecoration.copyWith(
                    errorText: _submitted ? _errorText : null,
                  ),
                  controller: _controller,
                ),
                const SizedBox(height: 12.0),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    //Do something with the user input.
                    setState(() {
                      password = value;
                    });
                  },
                  style: kTextInputStyle,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
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
                            setState(() {
                              _saving = true;
                            });
                            try {
                              //var user =
                              await _auth.signInWithEmailAndPassword(
                                  email: email!, password: password!);
                              Fluttertoast.showToast(
                                msg: 'Welcome to Flash Chat',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.white,
                                textColor: Colors.blue[800],
                                fontSize: 16.0,
                              );
                              Navigator.pushNamed(context, GroupChatScreen.id);
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
                              Fluttertoast.showToast(
                                msg: errorMessage,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
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
    );
  }
}
