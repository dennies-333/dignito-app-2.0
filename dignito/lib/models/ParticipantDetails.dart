// models/candidate_details_model.dart

class Participantdetails {
  final String iname;
  final String cname;
  final String events;
  final int status;
  final String paystatus;
  final String chestcode;
  final int chestnumber;
  final int cheststatus;

  Participantdetails({
    required this.iname,
    required this.cname,
    required this.events,
    required this.status,
    required this.paystatus,
    required this.chestcode,
    required this.chestnumber,
    required this.cheststatus,
  });
    
  Map<String, dynamic> toJson() {
    return {
      'iname': iname,
      'cname': cname,
      'events': events,
      'status': status,
    };
  }
}
