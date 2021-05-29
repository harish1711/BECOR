import 'package:Becor/menu/profile.dart';
import 'package:Becor/menu/settings.dart';

import 'package:Becor/scanner/scanner.dart';
import 'package:Becor/services/Auth.dart';
import 'package:Becor/signin/Authenticate/Authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Becor/models/widget.dart';
import 'package:Becor/models/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';
import 'package:Becor/models/registermodel.dart';

import 'googlesignin.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserData currentuser;
  PersistentTabController _controller;
  int _cIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget1(),
    PlaceholderWidget2(),
    IndexPage()
  ];

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

  final AuthService _auth = AuthService();
  bool loading = false;
  final FirebaseAuth auth1 = FirebaseAuth.instance;
  FirebaseUser user;
  void fetchuserdata() async {
    user = await auth1.currentUser();
    final db = Firestore.instance;
    DocumentSnapshot doc =
        await db.collection("UserList").document(user.uid).get();
    await setState(() => loading = false);
    if (!doc.exists) {
      await setState(() => loading = true);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GooglePage(),
        ),
      );
      doc = await db.collection("UserList").document(user.uid).get();
    }
    currentuser = UserData.fromDocument(doc);
    print("google page");
  }

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: _cIndex);
    fetchuserdata();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            drawer: Drawer(
              child: Column(
                children: [
                  Expanded(
                    flex: 0,
                    child: Container(
                      color: Colors.pink[50],
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: DrawerHeader(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        child: Stack(children: <Widget>[
                          Center(
                            child: ClipOval(
                              child: Material(
                                color: Colors.pink,
                                // button color
                                child: InkWell(
                                  splashColor: Colors.red, // inkwell color
                                  child: SizedBox(
                                      width: 110,
                                      height: 110,
                                      child: Icon(Icons.person)),
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 12.0,
                              left: 16.0,
                              child: Text(
                                "Menu",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              )),
                        ]),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView(children: [
                      ListTile(
                        trailing: Icon(Icons.person),
                        title: Text(
                          "Profile",
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile(user)));
                        },
                      ),
                      _buildDivider(),
                      ListTile(
                        trailing: Icon(Icons.settings),
                        title: Text("Settings"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsOnePage()));
                        },
                      ),
                      _buildDivider(),
                      ListTile(
                        trailing: Icon(Icons.supervisor_account),
                        title: Text("About"),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      _buildDivider(),
                      ListTile(
                        trailing: Icon(Icons.camera),
                        title: Text("Scanner"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scanner()));
                        },
                      ),
                    ]),
                  )
                ],
              ),
            ),
            appBar: AppBar(
              elevation: 0,
              title: Text(
                "BECOR",
                style: GoogleFonts.robotoMono(),
              ),
              //automaticallyImplyLeading: false,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('logout'),
                  onPressed: () async {
                    await _auth.signOut();
                    setState(() => loading = true);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authenticate()));
                  },
                ),
              ],
            ),
            // body: _children[_cIndex],
            bottomNavigationBar: Container(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height * 0.11, 0, 0),
              child: PersistentTabView(
                navBarCurveRadius: 2,
                backgroundColor: Colors.transparent,

                controller: _controller,
                items: [
                  PersistentBottomNavBarItem(
                    icon: Icon(Icons.home),
                    title: ("Classes"),
                    activeColor: Colors.pink,
                    inactiveColor: Colors.grey,
                    isTranslucent: false,
                  ),
                  PersistentBottomNavBarItem(
                    icon: Icon(Icons.person),
                    title: ("Attendance"),
                    activeColor: Colors.pink,
                    inactiveColor: Colors.grey,
                    isTranslucent: false,
                  ),
                  PersistentBottomNavBarItem(
                    icon: Icon(Icons.videocam),
                    title: ("OnlineClass"),
                    activeColor: Colors.pink,
                    inactiveColor: Colors.grey,
                    isTranslucent: false,
                  ),
                ],
                screens: _children,
                showElevation: true,
                navBarCurve: NavBarCurve.upperCorners,
                confineInSafeArea: true,
                handleAndroidBackButtonPress: true,
                iconSize: 26.0,
                navBarStyle: NavBarStyle
                    .style1, // Choose the nav bar style with this property
                onItemSelected: (index) {
                  print(index);
                },
              ),
            )

            //BottomNavigationBar(
            //onTap:,
            //currentIndex: _cIndex,
            //type: BottomNavigationBarType.fixed,
            //items: [
            //BottomNavigationBarItem(
            //  icon: Icon(Icons.person_add, color: Colors.pink[800]),
            //title: new Text(
            //'Classes',
            //  style: GoogleFonts.robotoMono(color: Colors.black),
            // )),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.history, color: Colors.pink[800]),
            // title: new Text(
            // 'Attendance',
            // style: GoogleFonts.robotoMono(color: Colors.black),
            // )),
            //BottomNavigationBarItem(
            //  icon: Icon(Icons.group, color: Colors.pink[800]),
            //title: new Text(
            //'Online Class',
            //style: GoogleFonts.robotoMono(color: Colors.black),
            // )),
            // ],
            //onTap: (index) {
            //_incrementTab(index);
            //},
            //),
            );
  }
}
