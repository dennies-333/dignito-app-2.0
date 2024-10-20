import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/event/event_qr.dart';
import '../services/http_service.dart';
import '../services/local_storage_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../errors.dart';
import '../models/ParticipantDetails.dart';
import '../views/event/event_details.dart';
import '../views/event/homepage.dart';


class Eventcontroller extends GetxController {
  final gatewayIdctrl = TextEditingController();
  
  var errorMsg = ''.obs;
  var gatewayName = '';
  QRViewController? qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void onQRCodeScanned(Barcode scanData) async {
    final String scannedCode = scanData.code ?? '';
    gatewayIdctrl.text = scannedCode;
    await LocalStorage.setValue('CandId', scannedCode);
  }

  void eventDetailsPage() async{
    print('waitinf for participant details');
    Participantdetails participantDetails = await HttpServices.EventId();
    if (participantDetails.cname.isNotEmpty){
      print('moving to displau page');
      Get.off(() => EventDetails(participantdetails: participantDetails));
    } else {
      errorMsg.value = ErrorMessages.InvalidCandidateIdError;
    }
    // bool loginStatus = await HttpServices.isCandIdValid();
    // print('waitinf for cand details');
    // CandidateDetails candidateDetails = await HttpServices.isCandIdValid();
    // if (candidateDetails.cname.isNotEmpty){
    //   print('moving to displau page');
    //   Get.off(() => Registration(candidateDetails: candidateDetails));
    // } else {
    //   errorMsg.value = ErrorMessages.InvalidCandidateIdError;
    // }
    // print("event deatils");
    // Get.to(() => EventDetails());
  }

  void allocateNumber() async{
    
    Get.to(() => const Homepage());
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
