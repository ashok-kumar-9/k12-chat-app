import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash_chat/screens/group_chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/onboarding/on_boarding_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/splash_screen.dart';
import 'package:flash_chat/services/shared_prefs.dart';
import 'package:flash_chat/utils/screen_size.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/reset_password.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefs().init();
  final messaging = FirebaseMessaging.instance;

  // final settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  //
  // String? token = await messaging.getToken();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const topic = 'app_promotion';
  await messaging.subscribeToTopic(topic);

  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(),
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
