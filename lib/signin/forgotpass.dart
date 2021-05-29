import 'package:Becor/services/Auth.dart';
import 'package:Becor/signin/Signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flushbar/flushbar.dart';
import 'package:Becor/models/loading.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final number = TextEditingController();
  String _email='';
  final AuthService _auth = AuthService();
  bool loading = false;

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
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Forgot Password",
                          style: GoogleFonts.robotoMono(
                              color: Colors.white, fontSize: 40),
                        ),
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
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: TextFormField(
                                      autofocus: true,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter a valid email';
                                        }
                                      },
                                      style: TextStyle(
                                          decoration: TextDecoration.none),
                                      decoration: InputDecoration(
                                        labelText: 'Email Id',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple)),
                                        labelStyle: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onChanged: (value) {
                                        setState(() => _email = value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),

                          SizedBox(
                            height: 50,
                            width: 180,
                            child: (RaisedButton(
                              onPressed: () async {
                                if (_email.isNotEmpty) {
                                  await Flushbar(
                                    title: "Forget password",
                                    message: "Password link sent to Email Id",
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.pink[100],
                                  ).show(context);
                                  await _auth.resetPass(_email);
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                                  
                                } else {
                                  
                                  await Flushbar(
                                    title: "Forget password",
                                    message: "enter a valid email id",
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.pink[100],
                                  ).show(context);
                                  
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(300.0),
                                side: BorderSide(color: Colors.red),
                              ),
                              color: Colors.pink[600],
                              textColor: Colors.white,
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(5),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            textColor: Colors.grey[900],
                            color: null,
                            child: Text("Return to Login Page ?"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //Text(error,
                          //style:TextStyle(color:Colors.red, fontSize:14.0,),
                          // ),
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
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}
