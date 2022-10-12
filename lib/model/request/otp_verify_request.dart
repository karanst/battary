class OtpVerifyRequest {
  String phone;
  String otp;
  String firebaseToken;

  OtpVerifyRequest(
      {required this.phone, required this.otp, required this.firebaseToken});

  Map<String, dynamic> tojson() => {
        'mobile': this.phone,
        'otp': this.otp,
        'firebaseToken': this.firebaseToken
      };
}
