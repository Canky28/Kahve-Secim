//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahveni_sec_app/models/order.dart';
import 'package:kahveni_sec_app/screens/home/order_list.dart';
import 'package:kahveni_sec_app/screens/home/settings_form.dart';
import 'package:kahveni_sec_app/services/auth.dart';
import 'package:kahveni_sec_app/services/database.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {

    void ayarlarPaneliniGoster(){
      showModalBottomSheet(
        context: context, 
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
            child: SettingForm(),
          );
        }
      );
    }


    return StreamProvider<List<Siparis>>.value(
        value:DatabaseService().siparisler,
        child: Scaffold(
        backgroundColor: Colors.tealAccent,
        appBar: AppBar(
          title: Text('Anasayfa'),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: ()=>ayarlarPaneliniGoster(), 
              icon: Icon(Icons.settings), 
              label: Text('Ayarlar')
            ),
            FlatButton.icon(
              onPressed: () async{
                await _auth.signOut();
              }, 
              icon: Icon(Icons.person_outline), 
              label: Text('Çıkış')
              ),
            
          ],
        ),
        body:SiparisList()
      ),
    );
  }
}