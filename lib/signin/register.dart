import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Becor/models/registermodel.dart';
import 'package:Becor/services/Auth.dart';
import 'package:Becor/signin/Signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Becor/signin/home.dart';
import 'package:Becor/models/loading.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final number = TextEditingController();
  UserData user = new UserData();
  String _email = '', _password = '', _name = '', _phonenumber = '';
  final AuthService _auth = AuthService();

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
                                      obscureText: false,
                                      validator: (value) => value.isEmpty
                                          ? 'Enter an email'
                                          : null,
                                      style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.none),
                                      decoration: InputDecoration(
                                        labelText: 'Email Id',
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
                                        setState(() => _email = value);
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: TextFormField(
                                      //autofocus: true,
                                      obscureText: true,
                                      validator: (value) => value.length < 6
                                          ? 'Enter an Password 6+ char'
                                          : null,
                                      style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.none),
                                      decoration: InputDecoration(
                                        labelText: 'Password',
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
                                        setState(() => _password = value);
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: TextFormField(
                                      //autofocus: true,
                                      //obscureText: true,
                                      validator: (value) => value.isEmpty
                                          ? 'Enter an name'
                                          : null,
                                      style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.none),
                                      decoration: InputDecoration(
                                        labelText: 'Name',
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
                                        setState(() => _name = value);
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: TextFormField(
                                      //autofocus: true,
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
                                              fontWeight: FontWeight.bold),
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
                                  if (_formKey.currentState.validate()) {
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            _email, _password);
                                    if (result == null) {
                                      setState(() => loading = false);
                                      //setState(() => _error = 'Not able to register');
                                    } else {
                                      setState(() => loading = true);
                                      (Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePage())));
                                      user.uid = result.uid;
                                      user.name = _name;
                                      user.emailid = _email;
                                      user.mobilenumber = _phonenumber;
                                      user.usertype = dropdownValue;
                                      final db = Firestore.instance;
                                      db
                                          .collection("UserList")
                                          .document(result.uid)
                                          .setData(user.uservalues());
                                    }
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(300.0),
                                  side: BorderSide(color: Colors.red),
                                ),
                                color: Colors.pink[600],
                                textColor: Colors.white,
                                child: Text(
                                  "SignUp",
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
                                        builder: (context) => LoginPage()));
                              },
                              textColor: Colors.grey[900],
                              color: null,
                              child: Text("Already have a account? Login"),
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
