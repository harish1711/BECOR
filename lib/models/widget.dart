import 'package:Becor/menu/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:Becor/screens/call.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Becor/models/newclassmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:Becor/class/subjectlist.dart';
import 'package:random_string/random_string.dart';

class PlaceholderWidget1 extends StatefulWidget {
  @override
  _PlaceholderWidget1State createState() => _PlaceholderWidget1State();
}

class _PlaceholderWidget1State extends State<PlaceholderWidget1> {
  TextEditingController _textfiled = TextEditingController();
  TextEditingController classcode = TextEditingController();
  String random;
  List<Widget> _children = [];
  int _count = 0;
  Newclass user = new Newclass("", "", "");
  final FirebaseAuth auth1 = FirebaseAuth.instance;
  FirebaseUser user1;
  int _cIndex = 0;

  //delete if not required
  final List<Widget> _child = [
    SettingsOnePage(),
  ];
  void _incrementTab1(index) {
    setState(() {
      _cIndex = index;
    });
  }

  String code;
  Future fetchClassData() async {
    user1 = await auth1.currentUser();
    final fire = Firestore.instance;
    final QuerySnapshot qn = await fire
        .collection("classes")
        .where("CreatedUserUid", isEqualTo: user1.uid)
        .getDocuments();

    return qn.documents;
  }

  void _add(random) async {
    user1 = await auth1.currentUser();
    user.createdbyuid = user1.uid;
    user.classcode = random;
    user.classname = _textfiled.text;
    final db = Firestore.instance;

    await db
        .collection("classes")
        .document(random)
        .setData(user.newuservalues());
  }

  void delete(code) {
    final fire = Firestore.instance;
    fire.collection("classes").document(code).delete();

    fire
        .collection("Subjects")
        .where("Class Code", isEqualTo: code)
        .getDocuments()
        .then((snapshot) {
      for (var ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
    setState(() {
      PlaceholderWidget1();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: false,
      body: //_child[_cIndex],
          FutureBuilder(
        future: fetchClassData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.10,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        //color: Colors.pink,
                        child: ListTile(
                          trailing: Icon(Icons.arrow_right, size: 40),
                          onTap: () {
                            //SubjectList(user1, code);
                            code = snapshot.data[index].data['Class Code'];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (content) => SubjectList(user1, code),
                              ),
                            );
                          },
                          onLongPress: () {
                            code = snapshot.data[index].data['Class Code'];
                            delete(code);
                            //delete(snapshot.data.documents[index]["Class Name"]);
                          },
                          title: Center(
                            child: Text(
                              snapshot.data[index].data['Class Name'],
                              style: GoogleFonts.robotoMono(
                                  fontSize: 30, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        clipBehavior: Clip.hardEdge,
        onPressed: () {
          modalsheetfn(context);
          //delete( snapshot.data[index].data['Class Name'],);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //model popup
  void modalsheetfn(context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (BuildContext ex) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text(
                        "Create A Class",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: IconButton(
                          color: Colors.pink,
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                            classcode.clear();
                          }),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        controller: _textfiled,
                        decoration: InputDecoration(hintText: "Class Name"),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        enabled: true,
                        controller: classcode,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.20,
                                0,
                                0,
                                0),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    SizedBox(
                      height: 60,
                      width: 200,
                      child: (RaisedButton(
                        onPressed: () async {
                          var random = randomAlpha(4) + randomNumeric(2);
                          _add(random);

                          setState(() {
                            classcode.text = "Your Class Code:  " + random;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(300.0),
                          side: BorderSide(color: Colors.red),
                        ),
                        color: Colors.pink[600],
                        textColor: Colors.white,
                        child: Text(
                          "Create",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class PlaceholderWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        "Attendance",
        style: TextStyle(fontSize: 56),
      )),
    );
  }
}
//PlaceholderWidget3

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: new Text(
          "Online Class",
          style: GoogleFonts.robotoMono(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: _channelController,
                    decoration: InputDecoration(
                      errorText:
                          _validateError ? 'Channel name is mandatory' : null,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      hintText: 'Channel name',
                    ),
                  ))
                ],
              ),
              Column(
                children: [
                  ListTile(
                    title: Text("Create Meeting"),
                    leading: Radio(
                      value: ClientRole.Broadcaster,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("Join Meeting"),
                    leading: Radio(
                      value: ClientRole.Audience,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: onJoin,
                        child: Text('Join'),
                        color: Colors.pink[700],
                        textColor: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
