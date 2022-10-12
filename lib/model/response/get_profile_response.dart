class GetProfileResponse {
  bool? status;
  String? message;
  List<Data>? data;

  GetProfileResponse({this.status, this.message, this.data});

  GetProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? userPhone;
  String? userFullname;
  String? userEmail;
  String? storeName;
  String? gstNumber;
  String? address;
  Data(
      {this.userId,
      this.userPhone,
      this.userFullname,
      this.userEmail,
      this.storeName,
      this.gstNumber,
      this.address});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userPhone = json['user_phone'];
    userFullname = json['user_fullname'];
    userEmail = json['user_email'];
    storeName = json['store_name'];
    gstNumber = json['gst_number'];
    address = json['address'] == null ? "" : json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_phone'] = this.userPhone;
    data['user_fullname'] = this.userFullname;
    data['user_email'] = this.userEmail;
    data['store_name'] = this.storeName;
    data['gst_number'] = this.gstNumber;
    data['address'] = this.address;
    return data;
  }
}
