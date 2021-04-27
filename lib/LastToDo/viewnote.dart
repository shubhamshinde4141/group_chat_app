import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote(this.data, this.time, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  String title;
  String des;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 40.0, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 40,
                      ),
                      color: Colors.red,
                      onPressed: () {
                        delete();
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 8.0,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.update,
                        size: 40,
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        update();
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 8.0,
                      ),
                    ),
                    //
                  ],
                ),
                //
                SizedBox(
                  height: 12.0,
                ),
                //
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*TextFormField(
                      initialValue: widget.data['title'],
                      decoration: InputDecoration.collapsed(
                        hintText: "Title",
                      ),
                      style: TextStyle(
                        fontSize: 32.0,
                        fontFamily: "lato",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      onChanged: (_val) {
                        title = _val;
                      },
                    ),*/

                    Text(
                      "${widget.data['title']}",
                      style: TextStyle(
                        fontSize: 32.0,
                        fontFamily: "lato",
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan[700],
                      ),
                    ),

                    //
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        bottom: 12.0,
                      ),
                      child: Text(
                        widget.time,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                          color: Colors.teal[800],
                        ),
                      ),
                    ),

                    //
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      alignment: Alignment.topLeft,
                      child: TextFormField(
                        initialValue: widget.data['description'],
                        decoration: InputDecoration.collapsed(
                          hintText: "Note Description",
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                          color: Colors.black,
                        ),
                        onChanged: (_val) {
                          des = _val;
                        },
                        maxLines: 20,
                      ),

                      /*Text(
                        "${widget.data['description']}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                          color: Colors.black,
                        ),
                      ),*/
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    // delete from db
    await widget.ref.delete();
    //await widget.ref.update(data)
    Navigator.pop(context);
  }

  void update() async {
    // delete from db
    //await widget.ref.delete();
    // CollectionReference ref = FirebaseFirestore.instance
    //   .collection('users')
    //   .doc(FirebaseAuth.instance.currentUser.uid)
    //   .collection('notes');
    if (title == null) {
      title = widget.data['title'];
    } else if (des == null) {
      des = widget.data['description'];
    }
    var data = {
      'title': title,
      'description': des,
      'created': DateTime.now(),
    };
    widget.ref.update(data);

    // ref.add(data);

    Navigator.pop(context);
  }
}
