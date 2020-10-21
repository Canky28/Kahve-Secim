import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool girisYap=true;
  void toggleSayfa(){
    setState(()=>girisYap=!girisYap);
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child:Text('Authenticate')
    // );
    if(girisYap){
      return SignIn(toggleSayfa: toggleSayfa,);
    }else{
      return Register(toggleSayfa: toggleSayfa,);
    }
    
  }
}