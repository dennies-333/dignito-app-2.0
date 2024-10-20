// models/candidate_details_model.dart

class Participantdetails {
  final String iname;
  final String cname;
  final Map<String, String> events;
  final String status;

  Participantdetails({
    required this.iname,
    required this.cname,
    required this.events,
    required this.status,
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
