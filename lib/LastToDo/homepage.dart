import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_app/LastToDo/addnote.dart';

import 'package:group_chat_app/LastToDo/viewnote.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');

  List<Color> myColors = [
    Colors.amber[200],
    Colors.pink[400],
    Colors.teal[300],
    Colors.cyan[200],
  ];
  bool isLoading = true;
  Timer time;
  void initState() {
    super.initState();
    time = Timer.periodic(Duration(seconds: 4), (Timer T) {
      if (!mounted) {
        return;
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //

      //
      body: isLoading
          ? Center(
              child: Container(
                height: 300,
                width: 300,
                child: Lottie.asset('assets/take note.json',
                    repeat: true, reverse: true, animate: true),
              ),
            )
          : ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            color: Colors.black,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    child: Lottie.asset('assets/take note.json',
                        repeat: true, reverse: true, animate: true),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0, top: 40),
                    child: Row(
                      children: [
                        Text('All ',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0)),
                        SizedBox(width: 10.0),
                        Text('Notes',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0))
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      color: Colors.teal[300],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: FutureBuilder<QuerySnapshot>(
                        future: ref.get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Random random = new Random();
                                Color bg = myColors[random.nextInt(4)];
                                Map data = snapshot.data.docs[index].data();
                                DateTime mydateTime = data['created'].toDate();
                                String formattedTime = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(mydateTime);
                                return InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(
                                        MaterialPageRoute(
                                          builder: (context) => ViewNote(
                                            data,
                                            formattedTime,
                                            snapshot.data.docs[index].reference,
                                          ),
                                        ),
                                      )
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 50,
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.cyan[50],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  child: Row(children: [
                                                Image(
                                                  image: AssetImage(
                                                      'assets/speaker.png'),
                                                  fit: BoxFit.cover,
                                                  //height: 100.0,
                                                  height: 50,
                                                  // width: 85.0
                                                  width: 50,
                                                ),
                                                SizedBox(width: 40),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("${data['title']}",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            // fontSize: 17.0,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        formattedTime,
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontFamily: "lato",
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ])),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            );
                          } else {
                            return Center(
                              child: Text("Loading..."),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          )
              .then((value) {
            print("Calling Set  State !");
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.grey[700],
      ),
    );
  }
}
