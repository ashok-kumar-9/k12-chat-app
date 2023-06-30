import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash_chat/screens/group_chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/onboarding/on_boarding_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/splash_screen.dart';
import 'package:flash_chat/services/message_handler.dart';
import 'package:flash_chat/services/shared_prefs.dart';
import 'package:flash_chat/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';
import 'screens/reset_password.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final messaging = FirebaseMessaging.instance;

void main() async {
  //using this for notification channels
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await FlutterLocalNotificationsPlugin().initialize(initializationSettings);

  // Create Android notification channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'group_chat',
    'Group Chat',
    description: 'The Group Chat Messages notificaiton',
    importance: Importance.low,
    enableVibration: true,
  );

  const AndroidNotificationChannel channel2 = AndroidNotificationChannel(
    'personal_chat',
    'Personal Chat',
    description: 'DMs (maybe creepy)',
    importance: Importance.high,
  );

  // Configure notification channel settings
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel2);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefs().init();

  // final settings =
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  //
  // String? token = await messaging.getToken();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // const topic = 'app_promotion';
  // await messaging.subscribeToTopic(topic);

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
        GroupChatScreen.id: (context) =>
            const MessageHandler(child: GroupChatScreen()),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ResetPasswordScreen.id: (context) => const ResetPasswordScreen(),
        'splash': (context) => const SplashScreen(),
        'on_boarding': (context) => const OnBoardingScreen(),
      },
    );
  }
}
