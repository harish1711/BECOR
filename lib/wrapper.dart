import 'package:Becor/signin/home.dart';
import 'package:flutter/material.dart';
import 'package:Becor/signin/Authenticate/Authenticate.dart';
import 'package:provider/provider.dart';
import 'package:Becor/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    if(user == null){
      return Authenticate();
    }
    else{
      return MyHomePage();
    }
  }
}