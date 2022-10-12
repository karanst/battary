class ScanHistoryRequest {
  String userid;

  ScanHistoryRequest({required this.userid});

  Map<String, dynamic> tojson() => {
        'mechanic_id': this.userid,
      };
}
