class ScanFormRequest {
  String fastName;
  String lastName;
  String phoneNumber;
  String email;
  String barcodeId;
  String userid;
  String warrantyData;
  ScanFormRequest(
      {required this.fastName,
      required this.lastName,
      required this.phoneNumber,
      required this.email,
      required this.barcodeId,
      required this.userid,
      required this.warrantyData});

  Map<String, dynamic> tojson() => {
        'user_fullname': this.fastName + " " + this.lastName,
        'user_phone': this.phoneNumber,
        'user_email': this.email,
        'mechanic_id': this.userid,
        'barcode_id': this.barcodeId,
        'varenty': this.warrantyData
      };
}
