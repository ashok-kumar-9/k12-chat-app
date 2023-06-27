import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class PersonalChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
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
      print(e);
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
            MessageStream(receiver: widget.receiverId),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText.value = value;
                          //Do something with the user input.
                        },
                        decoration: kMessageTextFieldDecoration,
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
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
                            return CircleAvatar(
                              backgroundColor: val == ""
                                  ? AppColors.toChatColor.withOpacity(0.5)
                                  : AppColors.toChatColor,
                              radius: 20,
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
    );
  }
}

class MessageStream extends StatelessWidget {
  final String receiver;
  const MessageStream({Key? key, required this.receiver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('personal').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          var ml = snapshot.data!.docs.where((element) {
            if (element['receiver'] == receiver ||
                element['sender'] == receiver) {
              return true;
            }
            return false;
          });
          var messages = ml.toList().reversed; //snapshot.data!.docs.reversed;

          List<TextBubble> messageWidget = [];
          for (var it in messages) {
            messageWidget.add(TextBubble(it: it));
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

class TextBubble extends StatelessWidget {
  const TextBubble({
    super.key,
    required this.it,
  });

  final QueryDocumentSnapshot<Object?> it;

  @override
  Widget build(BuildContext context) {
    final bool isMe = (loggedInUser!.email == it['sender']);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: isMe
                      ? const Radius.circular(16)
                      : const Radius.circular(0),
                  topRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(16),
                  bottomLeft: const Radius.circular(16),
                  bottomRight: const Radius.circular(16)),
              color: isMe ? AppColors.toChatColor : AppColors.sendChatColor,
            ),
            // elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '${it['text']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  overflow: TextOverflow.visible,
                ),
                maxLines: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
