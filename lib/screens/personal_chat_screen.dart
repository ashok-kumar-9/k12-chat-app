import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/buttons/send_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

import '../components/message_stream.dart';
import '../components/message_text_field.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class PersonalChatScreen extends StatefulWidget {
  static const String id = 'personal_chat_screen';
  final String receiverId;

  const PersonalChatScreen({super.key, required this.receiverId});

  @override
  _PersonalChatScreenState createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  final messageTextController = TextEditingController();
  ValueNotifier<String> messageText = ValueNotifier('');
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() {
    try {
      var user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        //print(loggedInUser!.email);
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint(widget.receiverId);
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorHome,
      appBar: AppBar(
        leading: null,
        title: Text(widget.receiverId),
        backgroundColor: AppColors.appBarColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(
              receiver: widget.receiverId,
              email: loggedInUser!.email??"",
              isPersonal: true,
              stream: _firestore.collection('personal').orderBy('time').snapshots(),
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
                            _firestore.collection('personal').add({
                              'sender': loggedInUser!.email,
                              'receiver': widget.receiverId,
                              'text': messageText.value,
                              'time': DateTime.now(),
                            });
                            messageTextController.clear();
                            messageText.value = "";
                          }
                        },
                        child: ValueListenableBuilder(
                          valueListenable: messageText,
                          builder: (context, val, child) {
                            return SendButton(
                              isActive: val == "",
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
    );
  }
}
