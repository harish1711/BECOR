import 'package:Becor/signin/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Becor/signin/Signin.dart';

import 'services/Auth.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return Scaffold(
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
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "BECOR",
                    style: GoogleFonts.robotoMono(
                        color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "",
                    style: GoogleFonts.robotoMono(
                        color: Colors.white54, fontSize: 24),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.fromLTRB(12, 40, 12, 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                          //  BoxShadow(
                          //    color: Color.fromRGBO(225, 95, 157, 3),
                          //    blurRadius: 20,
                          //     offset: Offset(0, 10))
                        ])),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 80,
                      width: 300,
                      child: (RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(300.0),
                          side: BorderSide(color: Colors.red),
                        ),
                        color: Colors.pink[600],
                        textColor: Colors.white,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat'),
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 80,
                      width: 300,
                      child: (RaisedButton(
                        onPressed: () {
                          print("SignedUp");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(300.0),
                          side: BorderSide(color: Colors.red),
                        ),
                        color: Colors.pink[600],
                        textColor: Colors.white,
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat'),
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 80,
                      width: 300,
                      child: (RaisedButton.icon(
                        icon: Image.asset(
                          'assets/google.png',
                          height: 35,
                        ),
                        onPressed: () async {
                          print("Google SignIn");
                          await _auth.googleSignin(context);

                          // Navigator.push(context,
                          //   MaterialPageRoute(builder: (context) => GooglePage()));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(300.0),
                          side: BorderSide(color: Colors.red),
                        ),
                        color: Colors.white,
                        textColor: Colors.black,
                        label: Text(
                          "Google",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      )),
                    ),
                  ]),
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
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
