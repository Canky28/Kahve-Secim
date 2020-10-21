//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahveni_sec_app/screens/home/order_tile.dart';
import 'package:provider/provider.dart';
import 'package:kahveni_sec_app/models/order.dart';

class SiparisList extends StatefulWidget {
  @override
  _SiparisListState createState() => _SiparisListState();
}

class _SiparisListState extends State<SiparisList> {
  @override
  Widget build(BuildContext context) {
    final siparisler=Provider.of<List<Siparis>>(context) ?? [];
    //print(siparisler.documents);
    siparisler.forEach((siparis){
      print(siparis.isim);
      print(siparis.seker);
      print(siparis.koyuluk);
    });
    return ListView.builder(
      itemCount: siparisler.length,
      itemBuilder: (context,index){
        return SiparisTile(siparis: siparisler[index],);
      }
      );
  }
}