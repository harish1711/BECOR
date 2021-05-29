import 'package:Becor/First.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Becor/models/registermodel.dart';
import 'package:Becor/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Becor/signin/home.dart';
import 'package:Becor/models/loading.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GooglePage extends StatefulWidget {
  @override
  _GooglePageState createState() => _GooglePageState();
}

class _GooglePageState extends State<GooglePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final number = TextEditingController();
  String _phonenumber = '';
  UserData user = new UserData();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final AuthService _auth = AuthService();
  final FirebaseAuth user1 = FirebaseAuth.instance;

  bool loading = false;
  String dropdownValue = 'Teacher';
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.pink[700],
                    Colors.purple[500],
                    Colors.pink[900],
                    Colors.purple[500]
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          "New User?",
                          style: GoogleFonts.robotoMono(
                              color: Colors.white, fontSize: 24),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "SignUp",
                          style: GoogleFonts.robotoMono(
                              color: Colors.white, fontSize: 40),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    //  BoxShadow(
                                    //    color: Color.fromRGBO(225, 95, 157, 3),
                                    //    blurRadius: 20,
                                    //     offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: TextFormField(
                                      autofocus: true,
                                      //obscureText: true,
                                      validator: (value) => value.length < 10
                                          ? 'Enter an mobile number'
                                          : null,
                                      style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.none),
                                      decoration: InputDecoration(
                                        labelText: 'Mobile Number',
                                        labelStyle: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple)),
                                      ),
                                      onChanged: (value) {
                                        setState(() => _phonenumber = value);
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        child: Text(
                                          "Enter Type of User :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        child: DropdownButton<String>(
                                          value: dropdownValue,
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          items: <String>[
                                            'Teacher',
                                            'Student',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              dropdownValue = newValue;
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              width: 180,
                              child: (RaisedButton(
                                onPressed: () async {
                                  final result = await user1.currentUser();
                                  if (_formKey.currentState.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyHomePage(),
                                      ),
                                    );
                                    user.uid = result.uid;
                                    user.name = result.displayName;
                                    user.emailid = result.email;
                                    user.mobilenumber = _phonenumber;
                                    user.usertype = dropdownValue;
                                    user.photourl = result.photoUrl.toString();
                                    final db = Firestore.instance;
                                    db
                                        .collection("UserList")
                                        .document(result.uid)
                                        .setData(user.uservalues());

                                    //  dynamic result =
                                    ///    await AuthService().googleSignin();

                                    //setState(() => loading = true);

                                    //       Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) => MyHomePage()));
                                    //   user.uid = result.uid;
                                    //  // user.name = _googleSignIn.currentUser.displayName;
                                    //   user.emailid = _googleSignIn.currentUser.email;
                                    //   user.mobilenumber = _phonenumber;
                                    //   user.usertype = dropdownValue;
                                    // // print(user.name);
                                    //   print(user.uid);
                                    //   print(user.emailid);
                                    //   print(user.mobilenumber);
                                    //final db = Firestore.instance;
                                    //await db
                                    //  .collection("UserList")
                                    //.document(result.uid)
                                    //.setData(user.uservalues());

                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(300.0),
                                  side: BorderSide(color: Colors.red),
                                ),
                                color: Colors.pink[600],
                                textColor: Colors.white,
                                child: Text(
                                  "SignIn",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FlatButton(
                              padding: EdgeInsets.all(5),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FirstPage()));
                              },
                              textColor: Colors.grey[900],
                              color: null,
                              child: Text("Back to main menu"),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          );
  }
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}
