import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:group_chat_app/LastToDo/homepage.dart';
import 'package:group_chat_app/Screens/chat_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
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
    return ScreenUtilInit(
      builder: () => Scaffold(
        backgroundColor: Color(0xFF21BFBD),
        body: isLoading
            ? Center(
                child: Container(
                  height: ScreenUtil().setHeight(300),
                  width: ScreenUtil().setWidth(300),
                  child: Lottie.asset('assets/cloud chatting.json',
                      repeat: true, reverse: true, animate: true),
                ),
              )
            : ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            color: Colors.white,
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
                    child: Lottie.asset('assets/chatting.json',
                        repeat: true, reverse: true, animate: true),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0, top: 40),
                    child: Row(
                      children: [
                        Text('Home',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0)),
                        SizedBox(width: 10.0),
                        Text('Page',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0))
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                      height: ScreenUtil().setHeight(
                          MediaQuery.of(context).size.height - 185.0),
                      width: ScreenUtil()
                          .setWidth(MediaQuery.of(context).size.width - 260.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(75.0)),
                      ),
                      child: ListView(
                        primary: false,
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.only(left: 25.0, right: 20.0),
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(45)),
                              child: Container(
                                  // height: MediaQuery.of(context).size.height - 300.0,
                                  height: ScreenUtil().setHeight(300),
                                  child: AnimationLimiter(
                                    // ignore: missing_required_param
                                    child: AnimationConfiguration.staggeredList(
                                      duration:
                                          const Duration(microseconds: 1500),
                                      child: FlipAnimation(
                                        flipAxis: FlipAxis.y,
                                        child: FadeInAnimation(
                                          child: ListView(children: [
                                            //First Item
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 30.0),
                                                child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ChatScreen()),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 100,
                                                      child: Card(
                                                        elevation: 5,
                                                        color: Colors.cyan[50],
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                                child: Row(
                                                                    children: [
                                                                  Image(
                                                                    image: AssetImage(
                                                                        'assets/chat.png'),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    //height: 100.0,
                                                                    height: ScreenUtil()
                                                                        .setHeight(
                                                                            150),
                                                                    // width: 85.0
                                                                    width: ScreenUtil()
                                                                        .setWidth(
                                                                            85),
                                                                  ),
                                                                  SizedBox(
                                                                      width: ScreenUtil()
                                                                          .setWidth(
                                                                              40)),
                                                                  Text("Chat",
                                                                      style: TextStyle(
                                                                          fontFamily: 'Montserrat',
                                                                          // fontSize: 17.0,
                                                                          fontSize: ScreenUtil().setSp(20),
                                                                          fontWeight: FontWeight.bold)),
                                                                ])),
                                                          ],
                                                        ),
                                                      ),
                                                    ))),

                                            //Second Item
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 20.0),
                                                child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomePage2()),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 100,
                                                      child: Card(
                                                        elevation: 5,
                                                        color: Colors.cyan[50],
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                                child: Row(
                                                                    children: [
                                                                  Image(
                                                                    image: AssetImage(
                                                                        'assets/notes.png'),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    //height: 100.0,
                                                                    height: ScreenUtil()
                                                                        .setHeight(
                                                                            150),
                                                                    // width: 85.0
                                                                    width: ScreenUtil()
                                                                        .setWidth(
                                                                            85),
                                                                  ),
                                                                  SizedBox(
                                                                      width: ScreenUtil()
                                                                          .setWidth(
                                                                              40)),
                                                                  Text("Notes",
                                                                      style: TextStyle(
                                                                          fontFamily: 'Montserrat',
                                                                          // fontSize: 17.0,
                                                                          fontSize: ScreenUtil().setSp(20),
                                                                          fontWeight: FontWeight.bold))
                                                                ])),
                                                          ],
                                                        ),
                                                      ),
                                                    ))),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ],
                      )),
                ],
              ),
      ),
    );
  }
}
