
import 'package:flutter/material.dart';
import 'package:kahveni_sec_app/models/user.dart';
import 'package:kahveni_sec_app/services/database.dart';
import 'package:kahveni_sec_app/shared/contants.dart';
import 'package:kahveni_sec_app/shared/loading.dart';
import 'package:provider/provider.dart';


class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey=GlobalKey<FormState>();
  final List<String> sekerler=['0','1','2','3','4'];

  String currentIsim;
  String currentSeker;
  int currentKoyuluk;

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<Kullanici>(context);
    return StreamBuilder<KullaniciVeriler>(
      stream: DatabaseService(uid: user.uid).kullaniciVerileri,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          KullaniciVeriler kv=snapshot.data;
          return Form(
          key:_formKey,
          child: Column(
            children: <Widget>[
              Text('Ayarları Güncelleyebilirsiniz',style: TextStyle(fontSize: 18),),
              SizedBox(height: 20.0,),
              TextFormField(
                initialValue: kv.isim,
                decoration: inputDecoration.copyWith(hintText:'İsim'),
                validator: (val)=>val.isEmpty ? 'Lütfen isim giriniz':null,
                onChanged: (val)=>setState(()=>currentIsim=val),
              ),
              SizedBox(height: 10.0,),
              //dropdown
              DropdownButtonFormField(
                items: sekerler.map((seker){
                  return DropdownMenuItem(
                    value: seker,
                    child: Text('$seker şeker'),
                  );
                }).toList(), 
                onChanged: (val)=>setState(()=>currentSeker=val),
                decoration: inputDecoration,
                value: currentSeker ?? kv.seker,
              ),
              //slider
              Slider(
                value: (currentKoyuluk ?? kv.koyuluk).toDouble(),
                min:100,
                max:900,
                divisions: 8,
                onChanged: (val)=>setState(()=>currentKoyuluk=val.round()),
                activeColor: Colors.brown[currentKoyuluk??kv.koyuluk],
                inactiveColor: Colors.brown[currentKoyuluk ?? kv.koyuluk],
              ),
              RaisedButton(
                color:Colors.green[400],
                child: Text('Güncelle',style: TextStyle(color: Colors.white),),
                onPressed: () async{
                  // print(currentIsim);
                  // print(currentSeker);
                  // print(currentKoyuluk);
                  if(_formKey.currentState.validate()){
                    try {
                      await DatabaseService(uid: user.uid).veriGuncelle(
                      currentIsim ?? kv.isim, 
                      currentSeker ?? kv.seker, 
                      currentKoyuluk ?? kv.koyuluk
                    );
                    Navigator.pop(context);
                    } catch (e) {
                      print('hata oluştu');
                    }

                  }
                },
              )
            ],
          ),
        );
        }else{
          return Loading();
        }
      }
    );
  }
}