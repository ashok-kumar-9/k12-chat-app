import 'package:flash_chat/dump/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigationFromSplashScreen();
  }

  void navigationFromSplashScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, LoginScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              height: screenHeight * 0.25,
              width: screenHeight * 0.25,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('images/logo.png'),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.circular(24)),
            ),
            Container(
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('images/pow_by.png'),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.circular(24)),
            ),
            const Spacer(),
            const Text(
              "Made with ❤ in India",
              style: TextStyle(color: Colors.white, fontSize: 16),
              // textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
