import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash_chat/screens/personal_chat_screen.dart';
import 'package:flutter/material.dart';

class MessageHandler extends StatefulWidget {
  final Widget child;
  const MessageHandler({super.key, required this.child});
  @override
  State createState() => MessageHandlerState();
}

class MessageHandlerState extends State<MessageHandler> {
  final FirebaseMessaging fm = FirebaseMessaging.instance;
  late Widget child;
  @override
  void initState() {
    super.initState();
    child = widget.child;

    @pragma('vm:entry-point')
    Future<void> _firebaseMessagingBackgroundHandler(
        RemoteMessage message) async {
      // If you're going to use other Firebase services in the background, such as Firestore,
      // make sure you call `initializeApp` before using other Firebase services.
      //await Firebase.initializeApp();

      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return PersonalChatScreen(receiverId: message.data['sender']);
      }));

      debugPrint("Handling a background message: ${message.data}");
    }

    //defining what should happen on notification click events based on app state
    // fm.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: ${message['data']['screen']}");
    //     String screen = message['data']['screen'];
    //     if (screen == "secondScreen") {
    //       Navigator.of(context).pushNamed("secondScreen");
    //     } else if (screen == "thirdScreen") {
    //       Navigator.of(context).pushNamed("thirdScreen");
    //     } else {
    //       //do nothing
    //     }
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onMessage: ${message['data']['screen']}");
    //     String screen = message['data']['screen'];
    //     if (screen == "secondScreen") {
    //       Navigator.of(context).pushNamed("secondScreen");
    //     } else if (screen == "thirdScreen") {
    //       Navigator.of(context).pushNamed("thirdScreen");
    //     } else {
    //       //do nothing
    //     }
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onMessage: ${message['data']['screen']}");
    //     String screen = message['data']['screen'];
    //     if (screen == "secondScreen") {
    //       Navigator.of(context).pushNamed("secondScreen");
    //     } else if (screen == "thirdScreen") {
    //       Navigator.of(context).pushNamed("thirdScreen");
    //     } else {
    //       //do nothing
    //     }
    //   },
    // );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return PersonalChatScreen(receiverId: message.data['sender']);
      }));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return PersonalChatScreen(receiverId: message.data['sender']);
      }));
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
