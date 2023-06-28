import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/message_stream.dart';
import '../components/message_text_field.dart';
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
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 100,
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Text(
                      'Do you want to exit?',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            SystemNavigator.pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 36,
                            color: Colors.red,
                            padding: const EdgeInsets.all(8),
                            child: const Center(
                              child: Text(
                                'Yes',
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 36,
                            color: Colors.green,
                            padding: const EdgeInsets.all(8),
                            child: const Center(
                              child: Text(
                                'No',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            });
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColorHome,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  //Implement logout functionality
                  _auth.signOut();
                  SharedPrefs().clearSharedPrefs();
                  Navigator.of(context).popAndPushNamed('splash');
                  //Navigator.pushNamed(context, WelcomeScreen.id);
                }),
          ],
          title: const Text('⚡️Group Chat'),
          backgroundColor: AppColors.appBarColor,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageStream(
                receiver: "",
                email: loggedInUser!.email ?? "",
                stream: _firestore
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                isPersonal: false,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: ContainerDecorations.kMessageContainerDecoration,
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
                        padding: const EdgeInsets.only(right: 8.0),
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
                              return CircleAvatar(
                                backgroundColor: val == ""
                                    ? AppColors.toChatInactiveColor
                                    : AppColors.toChatColor,
                                radius: RadiusConstants.sendButtonRadius,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Icon(Icons.send,
                                      color: Colors.white, size: 18),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
