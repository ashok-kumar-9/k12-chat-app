import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/text_bubble.dart';
import 'package:flutter/material.dart';

class MessageStream extends StatelessWidget {
  final String receiver;
  final stream;
  final String email;
  final bool isPersonal;

  const MessageStream({Key? key, required this.receiver, required this.stream, required this.email, required this.isPersonal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream, //_firestore.collection('personal').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          var ml = snapshot.data!.docs.where((element) {
            if(receiver!="") {
              if (element['receiver'] == receiver ||
                  element['sender'] == receiver) {
                return true;
              }
              return false;
            }
            else {
              return true;
            }
          });
          var messages = ml.toList().reversed; //snapshot.data!.docs.reversed;

          List<TextBubble> messageWidget = [];
          for (var it in messages) {
            messageWidget.add(TextBubble(it: it, loggedInUserEmail: email, isPersonal: isPersonal,));
          }
          return Expanded(
            child: ListView(
              reverse: true,
              physics: const BouncingScrollPhysics(),
              children: messageWidget,
            ),
          );
        } else {
          return const Expanded(child: Text('Quiet Empty'));
        }
      },
    );
  }
}