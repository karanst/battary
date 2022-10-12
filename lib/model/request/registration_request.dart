class RegistrationRequest {
  String name;
  String email;
  String phone;
  String shopName;
  String gstNumber;
  String address;
  String firebaseToken;

  RegistrationRequest(
      {required this.name,
      required this.email,
      required this.phone,
      required this.shopName,
      required this.gstNumber,
      required this.address,
      required this.firebaseToken});

  Map<String, dynamic> tojson() => {
        'user_fullname': this.name,
        'user_email': this.email,
        'user_phone': this.phone,
        'store_name': this.shopName,
        'gst_number': this.gstNumber,
        'address': this.address,
        'firebaseToken': this.firebaseToken
      };
}
