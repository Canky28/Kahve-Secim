import 'package:flutter/material.dart';
import 'package:kahveni_sec_app/services/auth.dart';
import 'package:kahveni_sec_app/shared/contants.dart';
import 'package:kahveni_sec_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleSayfa;
  SignIn({this.toggleSayfa});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService=AuthService();
  String email='';
  String password='';

  String error='';

  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0.0,
        title: Text('Giriş Yapınız'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              widget.toggleSayfa();
            }, 
            icon: Icon(Icons.person_add), 
            label: Text('Üye Ol')
          )
        ],
      ),
      body:Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  onChanged: (val){
                    setState(() {
                      email=val;
                    });
                  },
                  decoration: inputDecoration.copyWith(hintText:'Email giriniz'),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  obscureText: true,
                  onChanged: (val){
                      setState(() {
                      password=val;
                    });
                  },
                  decoration: inputDecoration.copyWith(hintText:'Parola giriniz'),
                ),
                SizedBox(height: 50.0,),
                RaisedButton(
                  color:Colors.greenAccent,
                  child: Text(
                    'Giriş Yap',
                    style: TextStyle(color:Colors.black),
                  ),
                  onPressed: () async{
                    // print(email);
                    // print(password);
                    setState(() {
                      loading=true;
                    });
                    dynamic sonuc=await _authService.signIn(email, password);
                    if(sonuc==null){
                      setState(() {
                        error='giriş başarısız';
                        loading=false;
                      });
                    }
                    
                  },
                ),
                SizedBox(height: 12.0,),
                Text(
                  error,
                  style: TextStyle(color:Colors.red,fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}