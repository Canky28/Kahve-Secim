import 'package:flutter/material.dart';
import 'package:kahveni_sec_app/services/auth.dart';
import 'package:kahveni_sec_app/shared/contants.dart';
import 'package:kahveni_sec_app/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleSayfa;
  Register({this.toggleSayfa});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService=AuthService();
  String email='';
  String password='';
  final _formKey=GlobalKey<FormState>();

  String error='';
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0.0,
        title: Text('Üye Olunuz'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              widget.toggleSayfa();
            }, 
            icon: Icon(Icons.person), 
            label: Text('Giriş Yap')
          )
        ],
      ),
      body:Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
            key:_formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  validator: (val)=>val.isEmpty?'Lütfen mail adresinizi giriniz':null,
                  onChanged: (val){
                    setState(() {
                      email=val;
                    });
                  },
                  decoration: inputDecoration,
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  validator: (val)=>val.length<6?'Parola 5 karakterden fazla olmalı':null,
                  obscureText: true,
                  onChanged: (val){
                      setState(() {
                      password=val;
                    });
                  },
                  decoration: inputDecoration.copyWith(hintText:'Parola'),
                ),
                SizedBox(height: 50.0,),
                RaisedButton(
                  color:Colors.greenAccent,
                  child: Text(
                    'Üye Ol',
                    style: TextStyle(color:Colors.black),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                        // print(email);
                        // print(password);
                        setState(() {
                        loading=true;
                      });
                        dynamic sonuc=await _authService.register(email, password);
                      if(sonuc==null){
                        setState(() {
                          error="Lütfen geçerli bir mail adresi ya da parola giriniz";
                          loading=false;
                        });
                      }
                      
                    }
                    
                  },
                ),
                SizedBox(height: 12.0,),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}