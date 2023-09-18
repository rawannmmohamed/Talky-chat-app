import 'package:chat_app/helper/snack_bar.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/theme/app_theme.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);
  static String id = 'chat';

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool loading = false;

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  TextEditingController _controller = TextEditingController();

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              foregroundColor: kSecondaryColor,
              centerTitle: true,
              title: const Text(
                'User name',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 01),
                  child: CircleAvatar(
                    radius: 60,
                    child: CircleAvatar(
                      radius: 60,
                      child: ClipOval(
                        child:
                            Image.asset('images/undraw_Female_avatar_efig.png'),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(message: messagesList[index])
                          : ChatBubbleForFriend(message: messagesList[index]);
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 15, right: 10),
                        child: TextField(
                          controller: _controller,
                          onSubmitted: (data) {
                            messages.add({
                              kMessage: data,
                              kCreatedAt: DateTime.now(),
                              'id': email
                            });
                            _controller.clear();
                            controller.animateTo(0,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.fastOutSlowIn);
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: kSecondaryColor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Message',
                            hintStyle: const TextStyle(color: kQuaternaryColor),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                if (_controller.text.isNotEmpty) {
                                  messages.add({
                                    kMessage: _controller.text,
                                    kCreatedAt: DateTime.now(),
                                    'id': email
                                  });
                                  _controller.clear();
                                  controller.animateTo(
                                    0,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.fastOutSlowIn,
                                  );
                                }
                              },
                              child: Icon(
                                Icons.send,
                                color: kSecondaryColor,
                              ),
                            ),
                          ),
                          cursorColor: kSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              foregroundColor: kSecondaryColor,
              centerTitle: true,
              title: const Text(
                'person name',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 01),
                  child: CircleAvatar(
                    radius: 60,
                    child: CircleAvatar(
                      radius: 60,
                      child: ClipOval(
                        child:
                            Image.asset('images/undraw_Female_avatar_efig.png'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } // Placeholder for no data
      },
    );
  }
}
