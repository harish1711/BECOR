import 'package:Becor/models/loading.dart';
import 'package:Becor/models/user.dart';
import 'package:Becor/signin/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    
 //final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ?  User(uid: user.uid):null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }


  Future signInAnon() async{
    try{
      AuthResult result  = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;

    }
  }


  Future signInWithEmailAndPassword(String _email,String _password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      FirebaseUser user = result.user;
      
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;

    }
  }



  Future registerWithEmailAndPassword(String _email,String _password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
      FirebaseUser user = result.user;
      
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;

    }
  }


  Future signOut() async{
    if(_auth.currentUser() != null){
    try{
       await _auth.signOut();
       await _googleSignIn.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }}
  }


  // Future<bool> googleSignin() async{
  //   try{
  //    // final GoogleSignIn googleSignIn = GoogleSignIn();
  //     GoogleSignInAccount account= await GoogleSignIn().signIn();
      
  //     AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
  //       idToken: (await account.authentication).idToken, 
  //       accessToken: (await account.authentication).accessToken));
      
  //     return true;

  //     //GoogleSignInAuthentication googleAuth= await googleUser.authentication;

      
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }
 Future googleSignin(BuildContext context) async {
    // hold the instance of the authenticated user
    FirebaseUser user;
    // flag to check whether we're signed in already
    
    bool isSignedIn = await _googleSignIn.isSignedIn();
     if (isSignedIn) {
    /// if so, return the current user
      user = await _auth.currentUser();
      }
    else{
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
     
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
    
      
      
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      // ignore: omit_local_variable_types
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      user = (await _auth.signInWithCredential(credential)).user;
    }
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
    return _userFromFirebaseUser(user);
  }


Future resetPass(String email) async{
  try{
    return await _auth.sendPasswordResetEmail(email:email);
  }catch(e){
    print(e.toString());
  }
}
}