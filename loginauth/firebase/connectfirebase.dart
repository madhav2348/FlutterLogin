import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/loginauth/toastmessage/toastmessage.dart';


class FirebaseAuthService{

  
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpEpPass(String email ,String password) async{
    try{
      UserCredential credential = await  _auth.createUserWithEmailAndPassword(email: email, password: password);

      return credential.user;

    } catch (e){
      // error
    }
    return null;

  }


Future<User?> loginInEpPass(String email ,String password) async{
    try{
      UserCredential credential = await  _auth.signInWithEmailAndPassword(email: email, password: password);

      return credential.user;

    }on FirebaseAuthException catch (e){
      if(e.code == 'email-already-in-use'){
        showToast(message: 'The email address has beeen already in use');

      }
      else{
        showToast(message: 'something wrong happened');
      }
    }
    return null;

  }

}