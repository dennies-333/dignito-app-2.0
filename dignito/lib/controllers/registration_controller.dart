import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/reg/registration.dart';
import '../services/http_service.dart';
import '../services/local_storage_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../errors.dart';
import '../models/CandDetails.dart';
import '../views/reg/reg_qr.dart';


class Regcontroller extends GetxController {
  final gatewayIdctrl = TextEditingController();
  
  var errorMsg = ''.obs;
  var gatewayName = '';
  QRViewController? qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void onQRCodeScanned(Barcode scanData) async {
    final String scannedCode = scanData.code ?? '';
    gatewayIdctrl.text = scannedCode;
  }

void getCandidateDetails() async {

  await LocalStorage.setValue('CandId', gatewayIdctrl.text);
  CandidateDetails? candidateDetails = await HttpServices.isCandIdValid();
  if (candidateDetails != null && candidateDetails.cname.isNotEmpty) {
    if(candidateDetails.cname == "Err"){
      errorMsg.value = ErrorMessages.InvalidCandidateIdError;
    } else {
      Get.off(() => Registration(candidateDetails: candidateDetails));
    }
  } else {
    errorMsg.value = ErrorMessages.InvalidCandidateIdError;
  }
}



  void issuseIdCard() async {
  bool response = await HttpServices.issueIdCard();

  if (response == true) {
    Get.snackbar('Successful','ID issued.');
    await LocalStorage.removeValue('CandId');
    Get.off(() => const Reg_scanqr());
  } else {
    Get.snackbar('error', 'try again');
    errorMsg.value = ErrorMessages.InvalidCandidateIdError;
  }
    
  }

  void clearErrorMsg() {
    errorMsg.value = '';
  }

  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    qrViewController?.dispose();
    super.onClose();
  }
}
