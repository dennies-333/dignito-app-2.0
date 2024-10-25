import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/http_service.dart';
import '../services/local_storage_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../errors.dart';
import '../models/ParticipantDetails.dart';
import '../views/event/event_details.dart';
import '../views/event/homepage.dart';


class Eventcontroller extends GetxController {
  final participantid = TextEditingController();
  final TextEditingController allocatedNumberController = TextEditingController();

  var errorMsg = ''.obs;
  QRViewController? qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void onQRCodeScanned(Barcode scanData) async {
    final String scannedCode = scanData.code ?? '';
    participantid.text = scannedCode;
    await LocalStorage.setValue('CandId', scannedCode);
  }

  void eventDetailsPage() async{
    Participantdetails? participantDetails = await HttpServices.EventId();
    if (participantDetails != null && participantDetails.cname.isNotEmpty){
      if(participantDetails.cname == "Err"){
        errorMsg.value = ErrorMessages.InvalidCandidateIdError;
      } else {
        print('moving to displau page');
        Get.off(() => EventDetails(participantdetails: participantDetails));}
    } else {
      errorMsg.value = ErrorMessages.InvalidCandidateIdError;
    }
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
