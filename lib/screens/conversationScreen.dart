// ignore_for_file: file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage_chat_app/helper/constants.dart';
import 'package:engage_chat_app/helper/database.dart';
import 'package:engage_chat_app/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  QuerySnapshot? snapshot;

  //Getting Chat Histroy
  Widget ChatMessageList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("ChatRoom")
            .doc(widget.chatRoomId)
            .collection("chats")
            .orderBy("time")
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData == false) return CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return MessageTile(snapshot.data!.docs[index]["message"]);
              });
        });
  }

  //Sending Chat Message
  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, String> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch.toString(),
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        // chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversation Screen"),
        actions: [
          GestureDetector(
            onTap: () {
              logout(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: "Type your Message here...",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.redAccent,
                        ),
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // searchList(),
          ],
        ),
      ),
    );
  }
}

//Logout Function
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ),
  );
}

class MessageTile extends StatelessWidget {
  final String message;

  MessageTile(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.italic,
          color: Colors.black,
        ),
      ),
    );
  }
}
