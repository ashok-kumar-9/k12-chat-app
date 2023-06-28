import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/group_chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/onboarding/on_boarding_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/splash_screen.dart';
import 'package:flash_chat/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'screens/reset_password.dart';

// Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (true) {
    debugPrint("Handling a background message: ${message.messageId}");
    debugPrint('Message data: ${message.data}');
    debugPrint('Message notification: ${message.notification?.title}');
    debugPrint('Message notification: ${message.notification?.body}');
  }
}

void main() async {
  //  Request permission
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefs().init();
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  debugPrint('Permission granted: ${settings.authorizationStatus}');

  //  Register with FCM
  String? token = await messaging.getToken();
  debugPrint('Registration Token=$token');

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // subscribe to a topic.
  const topic = 'app_promotion';
  await messaging.subscribeToTopic(topic);

  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
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
