import 'package:Becor/services/theme.dart';
//import 'package:Becor/theme/app_theme.dart';
//import 'package:Becor/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DarkTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Dark Theme'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text("Dark Theme"),
              onPressed: () => _themeChanger.setTheme(ThemeData(
                  accentColor: Colors.purple[100],
                  brightness: Brightness.dark)),
            ),
            FlatButton(
              child: Text("Light Theme"),
              onPressed: () => _themeChanger.setTheme(ThemeData(
                primaryColor: Colors.white,
                accentColor: Colors.purple[300],
                brightness: Brightness.light,
              )),
            )
          ],
        ),
      ),
      // body: ListView.builder(
      //   padding: EdgeInsets.all(10),
      //   itemCount: AppTheme.values.length,
      //   itemBuilder: (context, index) {
      //     final itemAppTheme = AppTheme.values[index];
      //     return Card(
      //       color: appThemeData[itemAppTheme].primaryColor,
      //       child: ListTile(
      //         title: Text(
      //           itemAppTheme.toString(),
      //           style: appThemeData[itemAppTheme].textTheme.bodyText1,
      //         ),
      //         onTap: () {
      //           BlocProvider.of<ThemeBloc>(context)
      //               .add(ThemeChanged(theme: itemAppTheme));
      //         },
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
