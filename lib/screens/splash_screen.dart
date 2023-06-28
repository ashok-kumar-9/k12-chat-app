import 'package:flash_chat/screens/group_chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/services/shared_prefs.dart';
import 'package:flash_chat/utils/constants.dart';
import 'package:flutter/material.dart';

import '../utils/screen_size.dart';

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
      if (SharedPrefs().isLoggedIn) {
        Navigator.popAndPushNamed(context, GroupChatScreen.id);
      } else {
        if (SharedPrefs().isOnBoardingDone) {
          Navigator.popAndPushNamed(context, LoginScreen.id);
        } else {
          Navigator.popAndPushNamed(context, 'on_boarding');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            height: ScreenSize.screenHeight * 0.25,
            width: ScreenSize.screenHeight * 0.25,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/logo.png'),
              ),
            ),
          ),
          Container(
            height: ScreenSize.screenHeight * 0.06,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/pow_by.png'),
              ),
            ),
          ),
          const Spacer(),
          const Text("Made with ❤ in India"),
          SizedBox(height: ScreenSize.screenHeight * 0.05),
        ],
      ),
    );
  }
}
