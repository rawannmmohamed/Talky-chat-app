import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({required this.message});
 final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 10),
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: kQuinaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            message.message,
            textHeightBehavior:
                const TextHeightBehavior(applyHeightToFirstAscent: true),
            style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({required this.message});
 final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 10),
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
          color: kSecondaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            message.message,
            textHeightBehavior:
                const TextHeightBehavior(applyHeightToFirstAscent: true),
            style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}