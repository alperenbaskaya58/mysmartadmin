import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
//import 'package:mysmartadmin/screens/AddDeviceScreen.dart';
//import 'package:mysmartadmin/screens/DevicesScreen.dart';
import 'package:mysmartadmin/screens/HomeScreen.dart';
import 'package:mysmartadmin/screens/LoginScreen.dart';
import 'package:mysmartadmin/services/auth_service.dart';
//import 'package:mysmartadmin/screens/LoginScreen.dart';
import 'package:url_strategy/url_strategy.dart';
Widget? widget;
 main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
   await Firebase.initializeApp(
    options: FirebaseOptions(
    apiKey: "AIzaSyDY-YwBOPgld0Tm6olJR89Q0YzaX4RTM7o", 
    appId: "1:519485501291:web:b93c8a1e86fa76da3da62e", 
    messagingSenderId: "519485501291", projectId: "kesinflutterapp")

   );
  User? user = await AuthService().getCurrentUser();
  //AuthService().logout();
  if (user == null) {
    widget = LoginScreen();
  } else {
    widget = HomeScreen();
  }
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget
    );
  }
}
