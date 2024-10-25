import 'package:dignito/views/event/homepage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dignito/errors.dart';
import '../services/http_service.dart';
import '../views/reg/reg_qr.dart';
import '../services/local_storage_service.dart';
//import '../views/hi.dart';
//import 'package:dignito/services/local_storage_service.dart';

class LoginController extends GetxController {
  String username = '';
  String password = '';
  String errorMsg = '';
  final String oldPasswd = 'oldpass';
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();


  void validateInputs() async {
    if (usernameCtrl.text.trim() == '' || passwordCtrl.text.trim() == '') {
      errorMsg = ErrorMessages.emptyInputFieldsError;
    } else {
      username = usernameCtrl.text.trim();
      password = passwordCtrl.text.trim();
      bool loginStatus = await HttpServices.login(username, password);
      if(loginStatus == true)
      {
        String? category = await LocalStorage.getValue('category');
        if( category == '0'){
          print("registration");
          Get.to(() => const Reg_scanqr());
        } else if ( category == "2"){
          print("event"); 
          Get.to(() => const Homepage());
        }   else{
          errorMsg = "Contact Admin";
        }    
      } else {
      errorMsg = 'Invalid Credentials!';
      } 
    }
    update();
  }

  void clearErrorMsg() {
    errorMsg = '';
    update();
  }



  @override
  void onClose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }
}
