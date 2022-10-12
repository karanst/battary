class LoginResponse {
  bool? status;
  String? message;
  Data? data;

  LoginResponse({this.status, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
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
  String? userPhone;
  String? firstname;
  String? lastname;
  String? userFullname;
  String? userEmail;
  String? userBdate;
  String? userPassword;
  String? userCity;
  String? address;
  String? varificationCode;
  String? userImage;
  String? pincode;
  String? socityId;
  String? houseNo;
  String? mobileVerified;
  String? userGcmCode;
  String? userIosToken;
  String? varifiedToken;
  String? status;
  String? regCode;
  String? wallet;
  String? rewards;
  String? created;
  String? modified;
  String? otp;
  String? otpStatus;
  String? social;
  String? firebaseToken;
  String? countryCode;
  String? areaCode;
  String? userType;
  String? isAvaible;
  String? vehicleType;
  String? vehicleNo;
  String? drivingLicenceNo;
  String? drivingLicencePhoto;
  String? loginStatus;
  String? branch;
  String? identity;
  String? identityNumber;
  String? review;
  String? latitude;
  String? longitude;
  String? facebookID;
  String? city;
  String? country;
  String? state;
  String? newPassword;
  String? storeName;
  String? gstNumber;
  String? roleId;

  Data(
      {this.userId,
      this.restroId,
      this.userPhone,
      this.firstname,
      this.lastname,
      this.userFullname,
      this.userEmail,
      this.userBdate,
      this.userPassword,
      this.userCity,
      this.address,
      this.varificationCode,
      this.userImage,
      this.pincode,
      this.socityId,
      this.houseNo,
      this.mobileVerified,
      this.userGcmCode,
      this.userIosToken,
      this.varifiedToken,
      this.status,
      this.regCode,
      this.wallet,
      this.rewards,
      this.created,
      this.modified,
      this.otp,
      this.otpStatus,
      this.social,
      this.firebaseToken,
      this.countryCode,
      this.areaCode,
      this.userType,
      this.isAvaible,
      this.vehicleType,
      this.vehicleNo,
      this.drivingLicenceNo,
      this.drivingLicencePhoto,
      this.loginStatus,
      this.branch,
      this.identity,
      this.identityNumber,
      this.review,
      this.latitude,
      this.longitude,
      this.facebookID,
      this.city,
      this.country,
      this.state,
      this.newPassword,
      this.storeName,
      this.gstNumber,
      this.roleId});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    restroId = json['restro_id'];
    userPhone = json['user_phone'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    userFullname = json['user_fullname'];
    userEmail = json['user_email'];
    userBdate = json['user_bdate'];
    userPassword = json['user_password'];
    userCity = json['user_city'];
    address = json['address'];
    varificationCode = json['varification_code'];
    userImage = json['user_image'];
    pincode = json['pincode'];
    socityId = json['socity_id'];
    houseNo = json['house_no'];
    mobileVerified = json['mobile_verified'];
    userGcmCode = json['user_gcm_code'];
    userIosToken = json['user_ios_token'];
    varifiedToken = json['varified_token'];
    status = json['status'];
    regCode = json['reg_code'];
    wallet = json['wallet'];
    rewards = json['rewards'];
    created = json['created'];
    modified = json['modified'];
    otp = json['otp'];
    otpStatus = json['otp_status'];
    social = json['social'];
    firebaseToken = json['firebaseToken'];
    countryCode = json['country_code'];
    areaCode = json['area_code'];
    userType = json['user_type'];
    isAvaible = json['is_avaible'];
    vehicleType = json['vehicle_type'];
    vehicleNo = json['vehicle_no'];
    drivingLicenceNo = json['driving_licence_no'];
    drivingLicencePhoto = json['driving_licence_photo'];
    loginStatus = json['login_status'];
    branch = json['branch'];
    identity = json['identity'];
    identityNumber = json['identity_number'];
    review = json['review'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    facebookID = json['facebookID'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    newPassword = json['new_password'];
    storeName = json['store_name'];
    gstNumber = json['gst_number'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['restro_id'] = this.restroId;
    data['user_phone'] = this.userPhone;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['user_fullname'] = this.userFullname;
    data['user_email'] = this.userEmail;
    data['user_bdate'] = this.userBdate;
    data['user_password'] = this.userPassword;
    data['user_city'] = this.userCity;
    data['address'] = this.address;
    data['varification_code'] = this.varificationCode;
    data['user_image'] = this.userImage;
    data['pincode'] = this.pincode;
    data['socity_id'] = this.socityId;
    data['house_no'] = this.houseNo;
    data['mobile_verified'] = this.mobileVerified;
    data['user_gcm_code'] = this.userGcmCode;
    data['user_ios_token'] = this.userIosToken;
    data['varified_token'] = this.varifiedToken;
    data['status'] = this.status;
    data['reg_code'] = this.regCode;
    data['wallet'] = this.wallet;
    data['rewards'] = this.rewards;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['otp'] = this.otp;
    data['otp_status'] = this.otpStatus;
    data['social'] = this.social;
    data['firebaseToken'] = this.firebaseToken;
    data['country_code'] = this.countryCode;
    data['area_code'] = this.areaCode;
    data['user_type'] = this.userType;
    data['is_avaible'] = this.isAvaible;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_no'] = this.vehicleNo;
    data['driving_licence_no'] = this.drivingLicenceNo;
    data['driving_licence_photo'] = this.drivingLicencePhoto;
    data['login_status'] = this.loginStatus;
    data['branch'] = this.branch;
    data['identity'] = this.identity;
    data['identity_number'] = this.identityNumber;
    data['review'] = this.review;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['facebookID'] = this.facebookID;
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['new_password'] = this.newPassword;
    data['store_name'] = this.storeName;
    data['gst_number'] = this.gstNumber;
    data['role_id'] = this.roleId;
    return data;
  }
}
