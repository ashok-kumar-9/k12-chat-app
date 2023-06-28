import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/personal_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

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

  void getCurrentUser() {
    try {
      var user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        //print(loggedInUser!.email);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
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
                  Navigator.of(context).pop();
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
              const MessageStream(),
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
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          var messages = snapshot.data!.docs.reversed;

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
          return const Center(
            child: Text('Quiet Empty'),
          );
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
    String name = it['sender'].toString().substring(0, 2);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          elevation: 16,
                          backgroundColor: Colors.transparent,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: AppColors.sendChatColor,
                                  child: Text(
                                    name.substring(0, 2),
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
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return PersonalChatScreen(
                                          receiverId: it['sender']);
                                    }));
                                  },
                                  child: const Text(
                                    'Tap to chat',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.sendChatColor,
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
          ),
        ],
      ),
    );
  }
}
