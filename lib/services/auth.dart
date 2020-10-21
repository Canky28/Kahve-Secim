import 'package:firebase_auth/firebase_auth.dart';
import 'package:kahveni_sec_app/models/user.dart';
import 'package:kahveni_sec_app/services/database.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Kullanici _firebasedenGelenKullanici(FirebaseUser kullanici){

    return kullanici !=null ?Kullanici(uid: kullanici.uid):null;
  }

  Future signInAnonim() async{
    try{
      AuthResult result=await _auth.signInAnonymously();
      FirebaseUser user=result.user;
      print(user.uid);
      return _firebasedenGelenKullanici(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Stream<Kullanici> get user{
    return _auth.onAuthStateChanged.map(_firebasedenGelenKullanici);
  }

  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future register(String mail,String parola) async{

    try {
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: mail, password: parola);

      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).veriGuncelle('yeni kullanıcı', '0', 100);
      return _firebasedenGelenKullanici(user);

    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signIn(String mail,String parola) async{

    try {
      AuthResult result=await _auth.signInWithEmailAndPassword(email: mail, password: parola);

      FirebaseUser user = result.user;
      return _firebasedenGelenKullanici(user);

    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}