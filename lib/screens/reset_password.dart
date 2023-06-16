import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static const String id = 'reset_password_screen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String? email;
  String? password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      backgroundColor: Colors.white,
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
                    height: 50.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldDecoration,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
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
                          backgroundColor: Colors.red,
                          textColor: Colors.blue,
                          fontSize: 16.0,
                        );
                        Navigator.pop(context);
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
                            errorMessage =
                                "Too many requests. Try again later.";
                            break;
                          case "operaetion-not-allowed":
                            errorMessage =
                                "Signing in with Email and Password is not enabled.";
                            break;
                          default:
                            errorMessage = "An undefined Error happened.";
                        }
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
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'Recieve Reset Link',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
