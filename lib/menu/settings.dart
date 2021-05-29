import 'package:Becor/menu/dark.dart';
import 'package:Becor/models/registermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:Becor/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//dark mode
//notification
//language
//terms and policy
//help center
//change password

class SettingsOnePage extends StatefulWidget {
  //static final String path = "lib/menu/settings.dart";

  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<SettingsOnePage> {
  //String _email;
  final AuthService _auth = AuthService();
  final FirebaseAuth auth1 = FirebaseAuth.instance;
  FirebaseUser user1;
  //FirebaseUser user = FirebaseAuth.getInstance().getCurrentUser();

  void getEmail() async {
    user1 = await auth1.currentUser();

    var _email = user1.email;
    print(_email);
    await _auth.resetPass(_email);
  }

  UserData currentdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        //brightness: _getBrightness(),
        //iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
        title: Text(
          'Settings',
          //style: TextStyle(color: _dark ? Colors.white : Colors.black),
        ),
        // actions: <Widget>[
        // IconButton(
        //icon: Icon(FontAwesomeIcons.moon),
        // icon: Icon(Icons.visibility),
        // onPressed: () {
        //  setState(() {
        //   _dark = !_dark;
        // });
        // },
        // )
        // ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Card(
                //   elevation: 8.0,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10.0)),
                //   color: Colors.pink,
                //   child: ListTile(
                //     onTap: () {
                //       //open edit profile
                //     },
                //     title: Text(
                //       "",
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 10.0),
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.lock_outline,
                          color: Colors.pink,
                        ),
                        title: Text("Change Password"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          //await _auth.resetPass(this._email);
                          //open change password
                          //print(this._email);
                          getEmail();
                          Flushbar(
                            title: "Forget password",
                            message: "Password link sent to Email Id",
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.pink[100],
                          ).show(context);
                        },
                      ),
                      _buildDivider(),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.pink,
                        ),
                        title: Text("Delete account"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      ),
                      _buildDivider(),
                      ListTile(
                        leading: Icon(
                          Icons.brightness_3,
                          color: Colors.pink,
                        ),
                        title: Text("Change Theme"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DarkTheme()));
                          // _getBrightness();
                          //open change location
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Notification Settings",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                SwitchListTile(
                  //inactiveThumbColor: Colors.white,
                  //activeColor: Colors.pink,
                  contentPadding: const EdgeInsets.all(0),
                  value: false,
                  title: Text("Receive notification"),
                  onChanged: (val) {},
                ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
