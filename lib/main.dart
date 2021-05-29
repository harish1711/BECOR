//import 'dart:ffi';

import 'package:Becor/models/user.dart';
import 'package:Becor/services/Auth.dart';
import 'package:Becor/services/theme.dart';
//import 'package:Becor/theme/bloc/theme_bloc.dart';
import 'package:Becor/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      //BlocProvider(
      //   create: (context) => ThemeBloc(),
      //   child: BlocBuilder<ThemeBloc, ThemeState>(
      //     builder: _buildWithTheme,
      //   ),
      // )
      child: ChangeNotifierProvider<ThemeChanger>(
        create: (_) => ThemeChanger(ThemeData(
          primaryColor: Colors.pink[50],
          accentColor: Colors.purple[100],
          brightness: Brightness.light,
        )),
        child: MaterialAppWithTheme(),
      ),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'BECOR',
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
      theme: theme.getTheme(),
      // theme: ThemeData(
      // brightness: Brightness.light,
      //primaryColor: Colors.white,
      // accentColor: Colors.purple[700]),
      // darkTheme: ThemeData(brightness: Brightness.dark),
    );
  }
}
//   Widget _buildWithTheme(BuildContext context, ThemeState state) {
//             return MaterialApp(
//               title: 'BECOR',

//               theme: state.themeData,
//               debugShowCheckedModeBanner: false,
//               home: Wrapper(),

//               //home: FirstPage(),
//             );
//           }
// }
