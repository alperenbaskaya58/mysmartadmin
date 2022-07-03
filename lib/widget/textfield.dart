import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysmartadmin/constants/uiconstants.dart';
import 'package:mysmartadmin/widget/textwidget.dart';
import 'package:mysmartadmin/controllers/password_controller.dart';

Widget TextFieldProfile(TextEditingController controller, String name) {
  Size size = Get.size;
  return Container(
    width: 200,
    decoration: const BoxDecoration(
      //borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: TextWidget(
            name: name,
            color: UiConstants.logintext,
            fontsize: 10,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          height: 50,
          width: 300,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 1),
            child: TextFormField(
              style: TextStyle(color: UiConstants.logintext),
              scrollPadding: const EdgeInsets.only(bottom: 10),
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              cursorHeight: 20,
              cursorColor: UiConstants.logintext,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                //labelText: name,
                //labelStyle: TextStyle(color: Colors.white),
                //focusColor: Colors.white,
                isCollapsed: true,
                prefixIconConstraints: BoxConstraints(
                    maxWidth: 15, minWidth: 12, minHeight: 40, maxHeight: 41),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),

                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: UiConstants.logintext, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: UiConstants.logintext, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                hintStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget TextFieldLog(
    TextEditingController controller, String name, Size size, bool isSifre) {
  final PasswordState passwordvisible = Get.put(PasswordState());
  return Container(
    height: 50,
    width: 6 * size.width / 10,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: UiConstants.loginbg,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(1, 1),
          spreadRadius: 1,
          blurRadius: 1,
        ),
        BoxShadow(
          color: Colors.black38,
          offset: Offset(-1, -1),
          spreadRadius: 1,
          blurRadius: 1,
        ),
      ],
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
        ),
        child: TextFormField(
          //textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
          ),
          
          scrollPadding: const EdgeInsets.only(bottom: 10),
          obscureText: isSifre ? passwordvisible.isPasswordHidden.value : false,
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: UiConstants.logintext,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            focusColor: UiConstants.logintext,
            isCollapsed: true,
            
            prefixIcon: isSifre
                ? const Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Icon(
                      Icons.lock,
                      color: UiConstants.logintext,
                      size: 20,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Icon(
                      Icons.person,
                      color: UiConstants.logintext,
                      size: 20,
                    ),
                  ),
            hintText: name,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1),
            ),
            suffixIcon: isSifre
                ? InkWell(
                    onTap: () {
                      passwordvisible.isPasswordHidden.value =
                          !passwordvisible.isPasswordHidden.value;
                    },
                    child: Icon(
                      passwordvisible.isPasswordHidden.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: UiConstants.logintext,
                    ),
                  )
                : null,
            hintStyle: const TextStyle(
              color: UiConstants.logintext,
            ),
          ),
        ),
      ),
    ),
  );
}
