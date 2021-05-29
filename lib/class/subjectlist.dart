import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:random_string/random_string.dart';
import 'package:Becor/class/newsubjectmodel.dart';

class SubjectList extends StatefulWidget {
  final FirebaseUser user1;
  final String code;

  SubjectList(this.user1, this.code);

  @override
  _SubjectListState createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  TextEditingController _textfiled = TextEditingController();
  TextEditingController classcode = TextEditingController();
  String subjectname;
  NewSubject sub = NewSubject("", "", "", "");
  String user2;
  String version = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();

    PdftronFlutter.openDocument(
        "https://firebasestorage.googleapis.com/v0/b/becor-4fd59.appspot.com/o/notes_3f7d9890-fc7f-4bad-9260-690092edc0feIMG-20200708-WA0008.jpg?alt=media&token=d2b58d30-ee83-46dc-8548-e1561a14c2c0");
  }

  Future<void> initPlatformState() async {
    String version;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      PdftronFlutter.initialize(
          "Insert commercial license key here after purchase");
      version = await PdftronFlutter.version;
    } on PlatformException {
      version = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      version = version;
    });
  }

  fetchSubjectsData() async {
    user2 = widget.user1.uid;
    final fire = Firestore.instance;
    final QuerySnapshot qn = await fire
        .collection("Subjects")
        .where("Created UID", isEqualTo: user2)
        .where("Class Code", isEqualTo: widget.code)
        .getDocuments()
        .catchError((e) {
      print(e);
    });
    return qn.documents;
  }

  void _add(random) async {
    sub.createduid = widget.user1.uid;
    sub.classcode = widget.code;
    sub.subjectcode = random;
    sub.subjectname = _textfiled.text;
    final db = Firestore.instance;

    db.collection("Subjects").document(random).setData(sub.newsubjectvalues());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchSubjectsData(),
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
                      height: MediaQuery.of(context).size.height * 0.10,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        //color: Colors.pink,
                        elevation: 10,
                        child: ListTile(
                          onTap: () {},
                          title: Center(
                            child: Text(
                              snapshot.data[index].data['Subject Name'],
                              style: GoogleFonts.robotoMono(
                                  fontSize: 20, fontWeight: FontWeight.w600),
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
          child: Icon(Icons.add),
          onPressed: () {
            modalsheetfn(context);
          }),
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
                        "Add a Subject",
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
                        decoration: InputDecoration(hintText: "Subject Name"),
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
                            subjectname = _textfiled.text;
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
