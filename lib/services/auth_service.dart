import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mysmartadmin/services/firestore_service.dart';


class AuthService{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirestoreService firestoreService = FirestoreService();


  Future<User?>? getCurrentUser()async{
    User user;
    return await firebaseAuth.currentUser;
  }

  createUserEmailPass (String email, String pass)async{
    UserCredential? userCredential;
    try{
    userCredential= await firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
    }
    on FirebaseAuthException catch(e){

        switch(e.code){
        case "invalid-email": {
          Get.snackbar("Hata!", "Emaile geçerli değil.");
          break;
        }
        case "weak-password": {
          Get.snackbar("Hata!", "Şifre zayıf.");
          break;
        }
        case "operation-not-allowed": {
          Get.snackbar("Hata!", "İşlem için izin bulunmuyor.");
          break;
        }
        case "email-already-in-use": {
          Get.snackbar("Hata!", "Maile ait kullanıcı zaten bulunuyor!");
          break;
        }
        

      }

    }
    catch(e){
      Get.snackbar("Error", e.toString());
    }
    return userCredential;

  }

  Future<UserCredential?>? loginWithEmailAndPass(String email, String pass)async{
     UserCredential? userCredential;
    
    try{
    
    userCredential = 
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
    }
    on FirebaseAuthException catch(e){
      switch(e.code){
        case "invalid-email": {
          Get.snackbar("Hata!", "Emaile ait hesap bulunamadı.");
          break;
        }
        case "user-disabled": {
          Get.snackbar("Hata!", "Emaile ait hesap kapatılmıştır.");
          break;
        }
        case "user-not-found": {
          Get.snackbar("Hata!", "Emaile ait hesap bulunamadı.");
          break;
        }
        case "wrong-password": {
          Get.snackbar("Hata!", "Hatalı Şifre!");
          break;
        }
        

      }
      Get.snackbar("Error", e.message!);
    }
    catch(e){
      log(e.toString());
    }
    
    /*if(userCredential != null){
      Map<String,dynamic> userInfo = 
      {
        "email": email,
        "password": pass,
        "uid" : firebaseAuth.currentUser!.uid,
        "notifToken" : ""
      };

      await firestoreService.addUserToDB(
        firebaseAuth.currentUser!.uid, userInfo);

    } */
    log(userCredential.toString());

    return userCredential;


  }

  

  forgotPassword(email)async{
    try{
    await firebaseAuth.sendPasswordResetEmail(email: email);
    Get.snackbar("Başarılı!", "$email adresinize şifre sıfırlama linki gönderildi.");
    } 
    on FirebaseAuthException catch (e){
      Get.snackbar("HATA!", e.message!);
    }
    catch(e){
      Get.snackbar("HATA!", e.toString());
    }
  }

  logout()async{
    try{
    await firebaseAuth.signOut();
    }
    catch(e){
       Get.snackbar("HATA!", "Çıkış yaparken hata oluştu.");
    }
  }

}