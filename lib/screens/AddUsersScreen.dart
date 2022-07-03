
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mysmartadmin/constants/uiconstants.dart';
import 'package:mysmartadmin/models/Device.dart';
import 'package:mysmartadmin/services/auth_service.dart';
import 'package:mysmartadmin/services/firestore_service.dart';
import 'package:mysmartadmin/widget/textfield.dart';
import 'package:mysmartadmin/widget/textwidget.dart';

class AddUser extends StatelessWidget {
   AddUser({Key? key}) : super(key: key);
  var usercontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AddUserCont addUserCont = Get.put(AddUserCont());
    
    return GetBuilder<AddUserCont>(
      builder: (context) {
        Size size = Get.size;
        return Scaffold(
               appBar: AppBar(
            backgroundColor: UiConstants.appbar,
            title: Text("Kullanıcı Ekle", style: TextStyle(color: Colors.black87),),
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
              Get.back();
            },),
          ),

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
                          "Kullanıcı Adı",
                          size,
                          false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(() => TextFieldLog(passwordcontroller, "Şifre", size, true)),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          splashColor: Colors.grey,
                          hoverColor: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          onTap: () async{
                            //Get.to(CihazScreen());
                            if(usercontroller.text.isEmpty || passwordcontroller.text.isEmpty){
                              // TODO: show snackbar
                              Get.snackbar("Hata!", "Alanları boş bırakmayınız.");
                            }
                            else{
                              await addUserCont.addUser(usercontroller.text.toString(), passwordcontroller.text.toString());
                              //await AddUserCont.login(usercontroller.text.toString(), passwordcontroller.text.toString());
                            }
                          },
                          child: Ink(
                            width: 7 * size.width / 10,
                            height: 40,
                            decoration:  BoxDecoration(
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
                              child: addUserCont.loading 
                              ? 
                              CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
        
                              ) :
                               Text(
                                "Kullanıcıyı Ekle",
                                style: TextStyle(color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        addUserCont.loading ? Container() : 
                      Padding(
                        padding:  EdgeInsets.all(40.0),
                        child: DropdownSearch<Device>.multiSelection(
                                  items: addUserCont.dev ?? [],
                                  itemAsString: (d)=>d.topic.toString(),
                                  popupProps: PopupPropsMultiSelection.menu(
                                    showSearchBox: true
                                  ),
                                
                                

                                  
                                  /*popupProps: PopupPropsMultiSelection.menu(
                                      showSelectedItems: true,
                                      searchDelay: Duration(seconds: 0),

                                      //disabledItemFn: (String s) => s.startsWith('I'),
                                  ), */
                                  onChanged: (it){
                                   addUserCont.addRemDev(it);

                                  },
                                  selectedItems: addUserCont.selectedItems ?? [],
                              ),
                      )                     
                                                
                      ],
                    ),
                  ),
                ),
          ),

        );
      }
    );
  }
}

class AddUserCont extends GetxController{
  List<Device>? dev = [];
  List<Device>? selectedItems = [];
  bool loading = false;
  FirestoreService firestoreService = FirestoreService();
  AuthService authService = AuthService();

  @override
   onInit() async{
    await getDevs();
    super.onInit();
  }

  getDevs()async{
    dev = await firestoreService.getDevicesFromDb();
    update();
  }

  addRemDev(it){
    selectedItems = it;
    log(selectedItems.toString());
    update();
  }

  addUser(email, pass)async{
    loading =true;
    update();
   UserCredential? usr = await authService.createUserEmailPass(email, pass);
   if(usr != null){
    List tpc = [];
      if(selectedItems != []){
        tpc = List.generate(selectedItems!.length, (index) => selectedItems![index].topic);
      }
        
      await firestoreService.addUserToDB(usr.user!.uid, 
      {
      "email" : usr.user!.email,
      "notifToken" : "",
      "uid" : usr.user!.uid,
      "topics" : tpc
      }
      );
   }
   else{
     Get.snackbar("Hata", "Kullanıcı eklenmedi.");
   loading =false;
   update();
    return;
   }
   Get.snackbar("Başarılı", "Kullanucı eklendi.");
   loading =false;
   update();
  }
  

}
