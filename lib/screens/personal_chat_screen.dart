import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/dump/welcome_screen.dart';

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
  String? messageText;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        title: Text(
          widget.receiverId,
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(receiver: widget.receiverId),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore.collection('personal').add({
                        'sender': loggedInUser!.email,
                        'receiver': widget.receiverId,
                        'text': messageText,
                        'time': DateTime.now(),
                      });
                      messageTextController.clear();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
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

class MessageStream extends StatelessWidget {
  final String receiver;
  const MessageStream({Key? key, required this.receiver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('personal').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Expanded(
            child: ListView(
              children: const [Text('Quite Empty Here')],
            ),
          );
        }

        var ml=snapshot.data!.docs.where((element) {
          if(element['receiver']==receiver || element['sender']==receiver) {
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
            children: messageWidget,
          ),
        );
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
    String name=it['sender'].toString().substring(0,2);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isMe ? const SizedBox() : Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: InkWell(
              onTap: () {
                showDialog(context: context, builder: (context) {
                  return Dialog(
                    elevation: 16,
                    backgroundColor: Colors.transparent,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.green[400],
                            child: Text(
                              name.substring(0,2),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            it['sender'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
              child: CircleAvatar(
                backgroundColor: Colors.green[400],
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft:
                    isMe ? const Radius.circular(30) : const Radius.circular(0),
                    topRight:
                    isMe ? const Radius.circular(0) : const Radius.circular(30),
                    bottomLeft: const Radius.circular(30),
                    bottomRight: const Radius.circular(30)),
                color: isMe ? Colors.lightBlue : Colors.grey[300],
              ),
              // elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '${it['text']}',
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontSize: 15.0,
                    overflow: TextOverflow.visible,
                  ),
                  maxLines: 3,
                ),
              ),
            ),
          ),
          isMe ? Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: InkWell(
              onTap: () {
                showDialog(context: context, builder: (context) {
                  return Dialog(
                    elevation: 16,
                    backgroundColor: Colors.transparent,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.purple[300],
                            child: Text(
                              name.substring(0,2),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            it['sender'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
              child: CircleAvatar(
                backgroundColor: Colors.purple[300],
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
