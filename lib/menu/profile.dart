import 'package:Becor/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Becor/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:Becor/models/registermodel.dart';
import 'package:Becor/signin/home.dart';

//dark mode
//notification
//language
//terms and policy
//help center
//change password

class Profile extends StatefulWidget {
  FirebaseUser user;
  Profile(this.user);

  //static final String path = "lib/menu/settings.dart";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  fetchData() async {
    final db = Firestore.instance;
    DocumentSnapshot doc =
        await db.collection('UserList').document(widget.user.uid).get();
    currentdata = UserData.fromDocument(doc);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  UserData currentdata;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: ClipOval(
                    child: Material(
                      // button color
                      child: InkWell(
                        splashColor: Colors.red, // inkwell color
                        child: SizedBox(
                            width: 110,
                            height: 110,
                            child: CachedNetworkImage(
                                imageUrl:
                                    'https://lh3.googleusercontent.com/a-/AOh14GjK4qQBRr0r6UIORj_pxdP_dlGOgzidB1IF9UfT=s96-c')),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Center(child: Text(currentdata.name)),
                        onTap: () {
                          print(currentdata.name);
                        },
                      ),
                      _buildDivider(),
                      ListTile(
                        title: Center(child: Text(widget.user.uid)),
                        onTap: () {},
                      ),
                      _buildDivider(),
                      ListTile(
                        title: Center(child: Text(widget.user.email)),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
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
