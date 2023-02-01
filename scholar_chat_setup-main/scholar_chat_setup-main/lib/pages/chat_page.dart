import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';

class ChatPage extends StatelessWidget {
  final _controller = ScrollController();
  ChatPage({Key? key, required this.email}) : super(key: key);
  final email;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessegeCollection);
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: kPrimaryColor,
                    centerTitle: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          kLogo,
                          height: 55,
                        ),
                        Text('chat')
                      ],
                    )),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          reverse: true,
                          controller: _controller,
                          itemCount: messagesList.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data!.docs[index]['id'] == email) {
                              return ChatBuble(
                                message: messagesList[index],
                              );
                            } else {
                              return ChatBubleForFriend(
                                message: messagesList[index],
                              );
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: messageController,
                        onSubmitted: (value) {
                          addUser(value);
                          messageController.clear();
                          _controller.animateTo(0,
                              duration: Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn);
                        },
                        decoration: InputDecoration(
                          hintText: 'Message',
                          suffixIcon: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Future<void> addUser(String data) {
    // Call the message's CollectionReference to add a new message
    return messages.add({
      kMessage: data,
      kCreatedAt: DateTime.now(),
      'id': email,
    });
  }
}
