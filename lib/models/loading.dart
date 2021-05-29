import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[100],
      child: Center(
        child: SpinKitCircle(duration: Duration(seconds:5),
          color: Colors.purple[700],
          size: 50.0,
        ),
      ),
    );
  }
}