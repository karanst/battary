class UpdateProfileRequest {
  String name;
  String email;
  String phone;
  String shopName;
  String gstNumber;
  String address;
  String userId;

  UpdateProfileRequest(
      {required this.name,
      required this.email,
      required this.phone,
      required this.shopName,
      required this.gstNumber,
      required this.address,
      required this.userId});

  Map<String, dynamic> tojson() => {
        'user_id': this.userId,
        'user_fullname': this.name,
        'user_email': this.email,
        'user_phone': this.phone,
        'store_name': this.shopName,
        'gst_number': this.gstNumber,
        'address': this.address,
      };
}
