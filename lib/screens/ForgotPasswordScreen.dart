import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysmartadmin/constants/uiconstants.dart';
import 'package:mysmartadmin/services/auth_service.dart';
import 'package:mysmartadmin/widget/textfield.dart';
import 'package:mysmartadmin/widget/textwidget.dart';


class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  var usercontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
    Size size = Get.size;
    return GetBuilder<ForgotPasswordController>(
      builder: (context) {
        return Scaffold(
            backgroundColor: UiConstants.bg,
            body: SingleChildScrollView(
              reverse: true,
              physics: ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    child: Center(
                        child: TextWidget(
                      name: "K",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 70,
                    )),
                  ),
                  SizedBox(
                    height: 10,
                    width: size.width,
                  ),
                  TextFieldLog(
                    usercontroller,
                    "Email",
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
                      //Get.to(CihazScreen());
                      if(usercontroller.text.isEmpty || !usercontroller.text.isEmail){
                        log("log");
                        // TODO: show snackbar
                      }
                      else{
                        await forgotPasswordController.forgotPassResetMail(usercontroller.text.toString());
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
                        child: forgotPasswordController.loading 
                        ? 
                        CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,

                        ) :
                         Text(
                          "Şifremi Sıfırla",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                   InkWell(
                    splashColor: Colors.grey,
                    hoverColor: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    onTap: () async{
                      Get.back();
                   
                    },
                    child: Ink(
                      width: 7 * size.width / 10,
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black12,
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
                        child: 
                         Text(
                          "Geri Dön",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),

                  
                ],
              ),
            ));
      }
    );
  }

}

class ForgotPasswordController extends GetxController{
  bool loading = false;
  AuthService authService = AuthService();
  forgotPassResetMail(email)async{
    loading = true;
    update();
    UserCredential? userCredential = await authService.forgotPassword(email);
    loading = false;
    update();
    if(userCredential != null){
      //Get.to(CihazScreen());
    }
  }
}