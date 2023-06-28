import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/utils/screen_size.dart';
import 'package:flutter/material.dart';

import '../screens/personal_chat_screen.dart';
import '../utils/constants.dart';

class TextBubble extends StatelessWidget {
  const TextBubble(
      {super.key,
      required this.it,
      this.loggedInUserEmail,
      required this.isPersonal});

  final QueryDocumentSnapshot<Object?> it;
  final String? loggedInUserEmail;
  final bool isPersonal;

  @override
  Widget build(BuildContext context) {
    final bool isMe = (loggedInUserEmail == it['sender']);
    String name = it['sender'].toString().substring(0, 2);

    return Padding(
      padding: const EdgeInsets.all(PaddingConstants.padding1),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isPersonal && !isMe)
            Padding(
              padding:
                  const EdgeInsets.only(right: PaddingConstants.padding1 * 0.5),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          elevation: 16,
                          backgroundColor: Colors.transparent,
                          child: Container(
                            height: ScreenSize.screenHeight * 0.25,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    RadiusConstants.profilePopRadius)),
                            padding:
                                const EdgeInsets.all(PaddingConstants.padding1),
                            child: Column(
                              children: [
                                const SizedBox(height: SpacerConstant.spacer2),
                                CircleAvatar(
                                  radius: RadiusConstants.profilePopRadius * 2,
                                  backgroundColor: AppColors.sendChatColor,
                                  child: Text(
                                    name.substring(0, 2),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: SpacerConstant.spacer3),
                                Text(
                                  it['sender'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .h3
                                      .copyWith(color: AppColors.black),
                                ),
                                const SizedBox(height: SpacerConstant.spacer3),
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
                                      color: AppColors.blue,
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
                  radius: RadiusConstants.chatAvatarRadius,
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
                        ? const Radius.circular(RadiusConstants.bubbleRadius)
                        : const Radius.circular(0),
                    topRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(RadiusConstants.bubbleRadius),
                    bottomLeft: const Radius.circular(RadiusConstants.bubbleRadius),
                    bottomRight: const Radius.circular(RadiusConstants.bubbleRadius)),
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
