import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/round_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({super.key});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool _saving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Sign Up'),
      ),
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
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
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                style: kTextInputStyle,
                decoration: kTextFieldDecoration,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                style: kTextInputStyle,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Choose a Password'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                buttonColor: Colors.blueAccent,
                textOnButton: 'Register',
                callBack: () async {
                  // print(email);
                  setState(() {
                    _saving = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email!, password: password!);

                    Navigator.pushNamed(context, ChatScreen.id);
                    setState(() {
                      _saving = false;
                    });
                    Fluttertoast.showToast(
                      msg: 'Welcome to Flash Chat',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.white,
                      textColor: Colors.black87,
                      fontSize: 16.0,
                    );
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      _saving = false;
                    });
                    String errorMessage;
                    switch (e.code) {
                      case "invalid-email":
                        errorMessage = "Enter a valid email address";
                        break;
                      case "wrong-password":
                        errorMessage = "Your password is wrong.";
                        break;
                      case "user-not-found":
                        errorMessage = "Email isn't registered";
                        break;
                      case "user-disabled":
                        errorMessage =
                            "User with this email has been disabled.";
                        break;
                      case "too-many-requests":
                        errorMessage = "Too many requests. Try again later.";
                        break;
                      case "operation-not-allowed":
                        errorMessage =
                            "Signing in with Email and Password is not enabled.";
                        break;
                      case "email-already-in-use":
                        errorMessage =
                            "Email already registered. Try loggin in";
                        break;
                      default:
                        errorMessage = "An undefined Error happened.";
                    }
                    print(e.code);
                    Fluttertoast.showToast(
                        msg: errorMessage,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red[400],
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
              TextButton(
                child: const Text(
                  'Already a user? Log In',
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
