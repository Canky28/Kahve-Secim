import 'package:flutter/material.dart';
import 'package:kahveni_sec_app/models/order.dart';

class SiparisTile extends StatelessWidget {
  final Siparis siparis;
  SiparisTile({this.siparis});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child:ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[siparis.koyuluk],
          ),
          title: Text(siparis.isim),
          subtitle: Text('${siparis.seker} adet şeker'),
        ),
      ),
    );
  }
}