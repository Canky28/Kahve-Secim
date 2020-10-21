import 'package:flutter/material.dart';
import 'package:kahveni_sec_app/models/user.dart';
import 'package:kahveni_sec_app/screens/wrapper.dart';
import 'package:kahveni_sec_app/services/auth.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Kullanici>.value(
        value: AuthService().user,
        child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
         
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}

