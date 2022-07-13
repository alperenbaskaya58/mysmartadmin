import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mysmartadmin/constants/uiconstants.dart';
import 'package:mysmartadmin/models/Device.dart';
import 'package:mysmartadmin/models/UserMod.dart';
import 'package:mysmartadmin/services/firestore_service.dart';

class UserScren extends StatelessWidget {
   UserScren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UsersCt devicesController = Get.put(UsersCt());
    return GetBuilder<UsersCt>(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: UiConstants.appbar,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,),
              onPressed: (){
                Get.back();
              },
            ),
            title: Text("Kullanıcılar", style: TextStyle(color: Colors.black87),),
          ),

          body:  
          
          ListView.separated(

              itemCount: devicesController.dev.length,
              separatorBuilder: (BuildContext context, int index){
                return Divider(
                  thickness: 10,
                );
              } ,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 150,
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.all(10),
                            leading:  Icon(Icons.list),
                            //subtitle:   Text(devicesController.dev[index].topics.toString()),
                            trailing: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(onPressed: ()async{
                                   // await devicesController.deleteDevice(devicesController.dev[index].uid);

                                  }, icon: Icon(Icons.delete, color: Colors.red,))
                                ],
                              ),
                            ),
                            title: Text(devicesController.dev[index].email.toString())),


                      devicesController.devices == null ? CircularProgressIndicator() :
                      DropdownSearch<Device?>.multiSelection(
                                  items: devicesController.devices,
                                  itemAsString: (d)=> d!.topic!.toString(),
                                  popupProps: PopupPropsMultiSelection.menu(
                                    showSearchBox: true
                                  ),

                                  onChanged: (it)async{
                                   //addUserCont.addRemDev(it);
                                   try{
                                   await devicesController.changeDevicesOfUser(it, devicesController.dev[index].uid!);
                                   }
                                   catch (e){
                                    Get.snackbar("Device değiştirilemedi.", "Hata");
                                   }
                                  },
                                  selectedItems:  devicesController.buildSelectedDevices(index),
                              ),      


                      ],
                    ),
                        
                        
                  ),
                );
              }),
        );
      }
    );
  }
}

class UsersCt extends GetxController{
  FirestoreService firestoreService = FirestoreService();
  List<UserMod> dev = [];
  List<Device> devices = [];
  List<String?> devces = [];
  bool loading = true;
  @override
   onInit()async {
    await wss();
    super.onInit();
  }

  List<Device> buildSelectedDevices (int index){
    List<Device> another = [];
    if(dev[index] == null ){
      log("retunr null");
      return [];
    }
    if(dev[index].topics == null){
      log("retunr empty topic");
      return [];
    }

    List<Topic> topics = dev[index].topics!;
    for(var devs in topics){
       int a = devices.indexWhere((Device element) => element.topic == devs.topic);
       log(a.toString());
       log(topics.toString());
       if(a != -1){
        another.add(devices[a]);
       }
    }

    log(another.toString());

    //update();

    return another;
   
  }

  wss()async{
    dev = await firestoreService.getAllUSers() as List<UserMod>;
    devices = await firestoreService.getDevicesFromDb() as List<Device>;
    devces = List.generate(devices.length , (index) {
      return devices[index].topic;
    } );
    print(dev.toString());
    loading = false;
    update();
  }

  /*deleteDevice(id)async{
    await firestoreService.deleteUser(id);
    wss();
    update();
  } */

  changeDevicesOfUser(List<Device?> it, String uid)async{
    await firestoreService.updateDevices(uid, it);
    update();

  }
}


 