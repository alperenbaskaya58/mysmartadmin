import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mysmartadmin/models/Device.dart';
import 'package:mysmartadmin/models/UserMod.dart';

class FirestoreService{


    addUserToDB(String userId, Map<String, dynamic> userInfo)async{
    return await FirebaseFirestore.instance.
    collection("users")
    .doc(userId)
    .set(userInfo);
  }

  getUserFromDB(String userId)async{
    return await FirebaseFirestore.instance.collection("users").doc(userId).get();
  }

  /*getDevicesDataFromDb(){
    return FirebaseFirestore.instance.collection("devices")
    .doc("kurum1")
    .snapshots().map((event) => KurumCihazModel.fromJson(event.data()!));

   
  }*/

  getDevicesFromDb()async{
   //List<Device>?  asd =  await FirebaseFirestore.instance.collection("devices").snapshots().map((event) =>  Device.fromJson(event.docs[0].data() )).toList();
    //log(asd.toString());
    //print(asd.toString());
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("devices").get();
    var list = querySnapshot.docs.map((e) =>  Device.fromJson(e.data() as Map<String, dynamic> )).toList();
     //QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("devices").get();
     //List<Device>? allData = querySnapshot..map((doc) => Device.fromJson(doc.data() )).toList();

     return list;

  }
  getAllUSers()async{
    var list = [] ;
      //print(asd.toString());
      try{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users").get();
    log(querySnapshot.toString());
     list = querySnapshot.docs.map((e) =>  UserMod.fromJson(e.data() as Map<String, dynamic> )).toList();
     log(list.toString());
      }
      catch (e){
        log("error");
        log(e.toString());

      }
     //QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("devices").get();
     //List<Device>? allData = querySnapshot..map((doc) => Device.fromJson(doc.data() )).toList();

     return list;
  }

  deleteDevice(id)async{
     await FirebaseFirestore.instance.collection("devices").doc(id).delete();
  }

  deleteUser(id)async{
    await FirebaseFirestore.instance.collection("users").doc(id).delete();
  }

  addDevice(Map<String, dynamic> deviceinfo)async{
    return await FirebaseFirestore.instance.
    collection("devices")
    .add(deviceinfo).then(
      (value) async{
        await value.update({
          "id" : value.id
        });
        
      }
    
    );
  }

    updateDevices(id, List<Device?> array)async{
      List asd = [];
      log(array.toString());
      if(array.isNotEmpty){
        for (var ar in array ){
          Map awr = {
            "topic" : ar!.topic!,
            "name" : ar.name,
          };
          asd.add(awr);
        }
      }

      try{

      
    return await FirebaseFirestore.instance.
    collection("users").doc(id).
    update(
      {'topics': asd});
      
    }
    catch(e){
       Get.snackbar("Device de??i??tirilemedi.", e.toString());
       log(e.toString());


    }
    
  }

}
  

  


