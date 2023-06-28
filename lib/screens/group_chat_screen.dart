import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash_chat/reusable_components/bottom_sheets/warning_bottom_sheet.dart';
import 'package:flash_chat/utils/constants.dart';
import 'package:flutter/material.dart';

import '../reusable_components/buttons/send_button.dart';
import '../reusable_components/message_stream.dart';
import '../reusable_components/message_text_field.dart';
import '../services/shared_prefs.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;
var userId;

Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  if (loggedInUser != null) {
    userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').add({
      'token': token,
      'email': loggedInUser!.email,
    });
  }
}

class GroupChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const GroupChatScreen({super.key});

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final messageTextController = TextEditingController();
  ValueNotifier<String> messageText = ValueNotifier('');
  final _auth = FirebaseAuth.instance;

  //String? _token;

  Future<void> setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await saveTokenToDatabase(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  void getCurrentUser() {
    try {
      var user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    setupToken();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showWarningBottomSheet(context, 'Do you want to exit?');
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          automaticallyImplyLeading: false,
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  _auth.signOut();
                  SharedPrefs().clearSharedPrefs();
                  Navigator.of(context).popAndPushNamed('splash');
                }),
          ],
          title: Text('⚡️ Group Chat', style: Theme.of(context).textTheme.h3),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(
              receiver: "",
              email: loggedInUser!.email ?? "",
              stream:
                  _firestore.collection('messages').orderBy('time').snapshots(),
              isPersonal: false,
            ),
            Container(
              decoration: ContainerDecorations.kMessageContainerDecoration,
              margin: const EdgeInsets.all(PaddingConstants.padding1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MessageField(
                    onChanged: (value) {
                      messageText.value = value;
                    },
                    controller: messageTextController,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: PaddingConstants.padding1),
                    child: InkWell(
                      onTap: () {
                        if (messageText.value == '') {
                        } else {
                          //Implement send functionality.
                          _firestore.collection('messages').add({
                            'text': messageText.value,
                            'sender': loggedInUser!.email,
                            'time': DateTime.now(),
                          });
                          messageTextController.clear();
                          messageText.value = "";
                        }
                      },
                      child: ValueListenableBuilder(
                        valueListenable: messageText,
                        builder: (context, val, child) {
                          return SendButton(isActive: val == "");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
