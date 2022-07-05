import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysmartadmin/constants/uiconstants.dart';
import 'package:mysmartadmin/screens/AddDeviceScreen.dart';
import 'package:mysmartadmin/screens/AddUsersScreen.dart';
import 'package:mysmartadmin/screens/DevicesScreen.dart';
import 'package:mysmartadmin/screens/LoginScreen.dart';
import 'package:mysmartadmin/screens/UsersScreen.dart';
import 'package:mysmartadmin/services/auth_service.dart';

 class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: UiConstants.appbar,
          title: Text("Ana Ekran", style: TextStyle(color: Colors.black87),),
          actions: [IconButton(onPressed: ()async{
            AuthService authService = AuthService();
            await authService.logout();
            Get.offAll(LoginScreen());
          }, icon: Icon(Icons.logout))],
        ),
    
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               GestureDetector(
                onTap: (){
                  Get.to(UserScren());
                },
                child: card("Kullanıcılar")),
    
               GestureDetector(
                onTap: (){
                  Get.to(DevicesScreen());
                },
                child: card("Cihazlar")),
    
               GestureDetector(
                onTap: (){
                  Get.to(AddUser());
                },
                child: card("Kullanıcı Ekle")),
               GestureDetector(
                 onTap: (){
                  Get.to(AddDeviceScreen());
                },
              
                child: card("Cihaz Ekle"))
        
              ],
            ),
          ),
        ),
      ),
    );
  }

 Widget card (ts){

  return Container(
    height: 180,
    width: 6.5*Get.size.width/10,
    child: Card(
            child: Center(
              child: 
                Text(ts, style: TextStyle(
                  fontSize: 35
                ),),
              
              
            ),
            elevation: 8,
            shadowColor: UiConstants.bluebutton,
            margin: EdgeInsets.all(20),
            shape:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: UiConstants.bluebutton, width: 1)
            ),
          ),
  );
 }


}