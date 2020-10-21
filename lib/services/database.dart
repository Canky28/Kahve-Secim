import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kahveni_sec_app/models/order.dart';
import 'package:kahveni_sec_app/models/user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference siparisCollection=Firestore.instance.collection('siparisler');

  Future veriGuncelle(String isim,String seker,int koyuluk) async{
    return await siparisCollection.document(uid).setData({
      'seker':seker,
      'isim':isim,
      'koyuluk':koyuluk
    });
  }

  List<Siparis> _snapshottanGelenSiparis(QuerySnapshot snap){
    return snap.documents.map((doc){
      return Siparis(
        isim:doc.data['isim'] ?? '',
        seker:doc.data['seker'] ?? '0',
        koyuluk:doc.data['koyuluk'] ?? 0
      );
    }).toList();
  }


  Stream<List<Siparis>> get siparisler{
    return siparisCollection.snapshots().map(_snapshottanGelenSiparis);
  }

  KullaniciVeriler _snapshottanGelenKullaniciVerileri(DocumentSnapshot snap){
    return KullaniciVeriler(
      uid:uid,
      isim:snap.data['isim'],
      seker:snap.data['seker'],
      koyuluk: snap.data['koyuluk']
    );
  }

  Stream<KullaniciVeriler> get kullaniciVerileri{
    return siparisCollection.document(uid).snapshots().map(_snapshottanGelenKullaniciVerileri);
  }

}