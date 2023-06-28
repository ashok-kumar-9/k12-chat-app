import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/group_chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/onboarding/on_boarding_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/splash_screen.dart';
import 'package:flash_chat/services/shared_prefs.dart';
import 'package:flutter/material.dart';

import 'screens/reset_password.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefs().init();
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
        ),
      ),
      initialRoute: "splash",
      routes: {
        GroupChatScreen.id: (context) => const GroupChatScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ResetPasswordScreen.id: (context) => const ResetPasswordScreen(),
        'splash': (context) => const SplashScreen(),
        'on_boarding': (context) => const OnBoardingScreen(),
      },
    );
  }
}
