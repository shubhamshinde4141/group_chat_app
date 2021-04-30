import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_app/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:image_picker/image_picker.dart';

final _firestore = FirebaseFirestore.instance;
User loggedUser;

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  // final _auth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String messageText;
  File imageFile;
  //var picker = ImagePicker();
  // final ImagePicker _picker = ImagePicker();

  bool isloaded = false;

  void getCurrentUser() async {
    //final User user = await _auth.currentUser();
    final User user = await _auth.currentUser;
    if (user != null) {
      try {
        loggedUser = user;
        print(loggedUser.email);
      } catch (e) {
        print(e);
      }
    }
  }

  /* Future openGallery() async {
    var picture = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(picture.path);
      isloaded = true;
      // applymodeltoimage(imageFile);
    });
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[400],
      appBar: AppBar(
        elevation: 0,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text(
          "Group Chat",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow[400],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.blueGrey[200],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageStream(),
              Container(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.image,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          //Implement logout functionality
                          // _auth.signOut();
                          //Navigator.pop(context);
                        }),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextField(
                          controller: messageTextController,
                          onChanged: (value) {
                            //Do something with the user input.
                            messageText = value;
                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                    ),
                    FlatButton(
                        color: Colors.orange[400],
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          messageTextController.clear();
                          //Implement send functionality.
                          _firestore.collection("messages").add({
                            "text": messageText,
                            "sender": loggedUser.email,
                            "time": DateTime.now()
                          });
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 23,
                        )),
                  ],
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("messages").orderBy("time").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }

          final messages = snapshot.data.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data()["text"];
            final messageSender = message.data()["sender"];
            final currentUser = loggedUser.email;

            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles,
              reverse: true,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  MessageBubble({this.sender, this.text, this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$sender',
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
          Material(
            elevation: 10,
            borderRadius: isMe
                ? BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(0))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isMe ? Colors.yellow : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "$text",
                style: TextStyle(
                    fontSize: 15, color: isMe ? Colors.black : Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
