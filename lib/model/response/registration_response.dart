class RegistrationResponse {
  bool? status;
  int? otp;
  String? phoneNumber;
  String? message;
  Data? data;

  RegistrationResponse(
      {this.status, this.otp, this.phoneNumber, this.message, this.data});

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    otp = json['otp'];
    phoneNumber = json['phone_number'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['otp'] = this.otp;
    data['phone_number'] = this.phoneNumber;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? restroId;

  Data({
    this.userId,
    this.restroId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    restroId = json['restro_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['restro_id'] = this.restroId;

    return data;
  }
}
