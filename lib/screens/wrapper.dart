import 'package:flutter/material.dart';
import 'package:kahveni_sec_app/models/user.dart';
import 'package:kahveni_sec_app/screens/authenticate/authenticate.dart';
import 'package:kahveni_sec_app/screens/home/home.dart';
import 'package:provider/provider.dart';
//import 'package:kahveni_sec_app/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<Kullanici>(context);
    print(user);
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}