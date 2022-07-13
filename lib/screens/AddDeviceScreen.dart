

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mysmartadmin/constants/uiconstants.dart';
import 'package:mysmartadmin/services/firestore_service.dart';
import 'package:mysmartadmin/widget/textfield.dart';
import 'package:mysmartadmin/widget/textwidget.dart';

class AddDeviceScreen extends StatelessWidget {
   AddDeviceScreen
({Key? key}) : super(key: key);
  var usercontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
    Widget build(BuildContext context) {
    DeviceAddController addController = Get.put(DeviceAddController());
    Size size = Get.size;
    return GetBuilder<DeviceAddController>(
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
        backgroundColor: UiConstants.appbar,
        title: Text("Cihaz Ekle", style: TextStyle(color: Colors.black87),),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Get.back();
        },),
      ),
              backgroundColor: UiConstants.bg,
              body: Center(
                child: SingleChildScrollView(
                  reverse: true,
                  physics: ClampingScrollPhysics(),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    
                        TextFieldLog(
                          usercontroller,
                          "Cihaz (Topic) Ekle",
                          size,
                          false,
                        ),
                        SizedBox(
                          height: 20,
                        ),

                         TextFieldLog(
                          passwordcontroller,
                          "Ad (Name) Ekle",
                          size,
                          false,
                        ),
                     

                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          splashColor: Colors.grey,
                          hoverColor: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          onTap: () async{
                             
                    
                        if(usercontroller.text.isNotEmpty || passwordcontroller.text.isNotEmpty){
                          addController.addDevice(usercontroller.text.toString(), passwordcontroller.text.toString());
                        }
                        else{
                          Get.snackbar("Hata", "Alan Boş");  
                        }
                        

                      
                      
                          },
                          child: Ink(
                            width: 7 * size.width / 10,
                            height: 40,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: UiConstants.bluebutton,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(2, 3),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: addController.loading 
                              ? 
                              CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
        
                              ) :
                               Text(
                                "EKLE",
                                style: TextStyle(color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],

                  ),
                ),
              )),
          )
        );
      }
    );
  }
    
  
}


class DeviceAddController extends GetxController{
  bool loading = false;
  FirestoreService firestoreService = FirestoreService();

  addDevice(devicename, name)async{
    loading = true;
    update();

    await firestoreService.addDevice({
      "topic" : devicename,
      "name" : name
    });


    loading  = false;
    update();
    Get.snackbar("Başarılı", "$devicename eklendi.");
  }
  
}