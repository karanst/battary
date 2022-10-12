class ResendOtpModel {
  ResendOtpModel({
      this.status, 
      this.message, 
      this.data,});

  ResendOtpModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }
  bool? status;
  String? message;
  int? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}