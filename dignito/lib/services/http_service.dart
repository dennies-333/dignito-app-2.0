import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dignito/services/local_storage_service.dart';
import '../models/CandDetails.dart';
import 'package:get/get.dart';
import '../models/ParticipantDetails.dart';

class HttpServices {
  static String baseUrl = 'http://dicoman.dist.ac.in/api/';
    
  static Future<bool> login(String username, String password) async {
  bool retVal = false;
  final credentials = {
    'username': username,
    'password': password,
  };

  final headers = {
    'Content-Type': 'application/json',
  };

  final body = json.encode(credentials);

  final response = await http.post(
    Uri.parse('https://dicoman.dist.ac.in/api/login'),
    headers: headers,
    body: body,
  );
  print(response.body);
  if (response.statusCode == 200) {
    
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (responseData['status'] == 1){
      print(responseData);
      retVal = true;
      String staffid = responseData['staff_id'].toString();
      String category = responseData['category'].toString();
      String eventid = responseData['event_id'].toString();

      await LocalStorage.setValue('staffid', staffid);
      await LocalStorage.setValue('category', category);
      await LocalStorage.setValue('eventid', eventid);
    } else {
      print("status 0");
    }
  } else {
    print('server failed');
  }

  return retVal;
  }

      static Future<CandidateDetails?> isCandIdValid() async {
    bool isValid = false;
    String? Candid = await LocalStorage.getValue('CandId');
    String? StaffId = await LocalStorage.getValue('staff_id');
    String? category = await LocalStorage.getValue('category');
    String? eventid = await LocalStorage.getValue('eventid');

    final credentials = {
    'cand_id': Candid,
    'staff_id':StaffId,
    'category': category,
    'eventid': eventid
    };

    final headers = {
      'Content-Type': 'application/json',
    };
    
    final body = json.encode(credentials);

    final response = await http.post(
      Uri.parse('https://dicoman.dist.ac.in/api/candidate'), //change uri
      headers: headers,
      body: body,
    );


    if (response.statusCode == 200){
      print(response.body);
      Get.log("Response: ${response.body}");

        final decodedResponse = json.decode(response.body);

        CandidateDetails candidateDetails = CandidateDetails(
          iname: decodedResponse['iname'],
          cname: decodedResponse['cname'],
          events: decodedResponse['events'],
          pay_status: decodedResponse['pay_status'],
          status: decodedResponse['status'],
        );
        return candidateDetails;
    } else {
      return null;
    }
  }

static Future<bool> issueIdCard() async {

  bool retVal = false;
  String? Candid = await LocalStorage.getValue('CandId');
  String? StaffId = await LocalStorage.getValue('staff_id');
  String? category = await LocalStorage.getValue('category');
  String? eventid = await LocalStorage.getValue('eventid');

  final credentials = {
  'cand_id': Candid,
  'staff_id':StaffId,
  'category': category,
  'eventid': eventid
  };

  final headers = {
    'Content-Type': 'application/json',
  };
  
  final body = json.encode(credentials);

  final response = await http.post(
    Uri.parse('https://dicoman.dist.ac.in/api/update'),
    headers: headers,
    body: body,
  );
  print(response.body);
  if(response.statusCode == 200)
  {
    print("updated");
    Get.log("Response: ${response.toString()}");
    retVal = true; 
  }
  return retVal;
}
static Future<Participantdetails?> EventId() async {
    bool isValid = false;
    String? Candid = await LocalStorage.getValue('CandId');
    String? StaffId = await LocalStorage.getValue('staff_id');
    String? category = await LocalStorage.getValue('category');
    String? eventid = await LocalStorage.getValue('eventid');

    final credentials = {
    'cand_id': Candid,
    'staff_id':StaffId,
    'category': category,
    'eventid': eventid
    };

    final headers = {
      'Content-Type': 'application/json',
    };
    
    final body = json.encode(credentials);

    final response = await http.post(
      Uri.parse('https://dicoman.dist.ac.in/api/candidate'), //change uri
      headers: headers,
      body: body,
    );
  
    print(response.body);
    if(response.statusCode == 200)
    {
      print(response.body);
      Get.log("Response: ${response.body}");
      final decodedResponse = json.decode(response.body);
       Participantdetails participantdetails = Participantdetails(
          iname: decodedResponse['iname'],
          cname: decodedResponse['cname'],
          events: decodedResponse['events'],
          paystatus: decodedResponse['pay_status'],
          status: decodedResponse['status'],
          chestcode: decodedResponse['chestcode'],
          chestnumber: decodedResponse['chestno'],
          cheststatus: decodedResponse['cheststatus'],
        );
      return participantdetails;
    } else {
      return null;
    }
  }


  // Participantdetails participantDetails = Participantdetails(
  //   iname: decodedResponse['iname'],
  //   cname: decodedResponse['cname'],
  //   events: decodedResponse['events'],
  //   status: decodedResponse['status'],
  // );

  
  // return participantDetails;
  // }

}

