import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysmartadmin/screens/ForgotPasswordScreen.dart';
import 'package:mysmartadmin/screens/HomeScreen.dart';
import 'package:mysmartadmin/services/auth_service.dart';
import 'package:mysmartadmin/widget/textfield.dart';
import 'package:mysmartadmin/widget/textwidget.dart';
import 'package:mysmartadmin/constants/uiconstants.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var usercontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    Size size = Get.size;
    return GetBuilder<LoginController>(
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              backgroundColor: UiConstants.bg,
              body: Center(
                child: SingleChildScrollView(
                  reverse: true,
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /*Container(
                        width: 300,
                        height: 300,
                        child: Center(
                            child: TextWidget(
                          name: "K",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontsize: 70,
                        )),
                      ),*/
                      SizedBox(
                        height: 10,
                        width: size.width,
                      ),
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
                      GestureDetector(
                        onTap: () =>
                         Get.to(()=>ForgotPasswordScreen()),
                         
                        child: Container(
                          width: 9 * size.width / 10,
                          height: 20,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Şifremi Unuttum",
                              style: TextStyle(
                                  color: UiConstants.bluebutton, fontSize: 12),
                            ),
                          ),
                        ),
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
                            if(usercontroller.text.toString() == "a@gmail.com"){
                              await loginController.login(usercontroller.text.toString(), passwordcontroller.text.toString());
                            }
                            
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
                            child: loginController.loading 
                            ? 
                            CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
        
                            ) :
                             Text(
                              "Giriş Yap",
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
              )
              ),
        );
      }
    );
  }

}

class LoginController extends GetxController{
  bool loading = false;
  AuthService authService = AuthService();
  login(email, pass)async{
    loading = true;
    update();
    UserCredential? userCredential = await authService.loginWithEmailAndPass(email, pass);
    loading = false;
    update();
    if(userCredential != null){
      Get.to(HomeScreen());
      //Get.to(CihazScreen());
    }
  }
}