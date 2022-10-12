import 'dart:convert';

import 'package:battary/api/api_path.dart';
import 'package:battary/api/api_services.dart';
import 'package:battary/model/request/complent_box_request.dart';
import 'package:battary/model/request/get_Issue_request.dart';
import 'package:battary/model/request/get_profile_request.dart';
import 'package:battary/model/request/login_with_otp_request.dart';
import 'package:battary/model/request/otp_verify_request.dart';
import 'package:battary/model/request/registration_request.dart';
import 'package:battary/model/request/replace_new_battary_request.dart';
import 'package:battary/model/request/scan_form_request.dart';
import 'package:battary/model/request/scan_history_info_request.dart';
import 'package:battary/model/request/scan_info_request.dart';
import 'package:battary/model/request/update_profile_request.dart';
import 'package:battary/model/response/complain_box_response.dart';
import 'package:battary/model/response/get_profile_response.dart';
import 'package:battary/model/response/image_gallery_response.dart';
import 'package:battary/model/response/issue_history_response.dart';
import 'package:battary/model/response/login_with_otp_response.dart';
import 'package:battary/model/response/otpverify_response.dart';
import 'package:battary/model/response/registration_response.dart';
import 'package:battary/model/response/replace_battary_response.dart';
import 'package:battary/model/response/scanInfo_response.dart';
import 'package:battary/model/response/scan_from_response.dart';
import 'package:battary/model/response/scan_history_response.dart';
import 'package:battary/model/response/update_profile_response.dart';
import 'package:battary/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';

class ApiHelper {
  //  Login With OTP
  static Future<LoginResponse> loginWithOTP(LoginRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.login_url, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    UtilityHlepar.getToast(data["message"]);
    return LoginResponse.fromJson(data);
  }

  //  Registration
  static Future<RegistrationResponse> registration(
      RegistrationRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.registration_url, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    UtilityHlepar.getToast(data["message"]);
    return RegistrationResponse.fromJson(data);
  }

  //  Otp Verify
  static Future<OtpverifyResponse> otpVerify(OtpVerifyRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.otp_verify_url, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    UtilityHlepar.getToast(data["message"]);
    return OtpverifyResponse.fromJson(data);
  }

  //  Scan Info Response
  static Future<ScanInfoResponse> getScanInfo(ScanInfoRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.get_scan_Info_url, parameters: request.tojson());
    print(responsData);
    print(request.tojson());
    var data = jsonDecode(responsData.body);
    UtilityHlepar.getToast(data["message"]);
    return ScanInfoResponse.fromJson(data);
  }

  // after Scan from
  static Future<ScanFromResponse> submitScanFrom(
      ScanFormRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.customer_from_url, parameters: request.tojson());
    print(responsData);
    print(request.tojson());
    var data = jsonDecode(responsData.body);
    UtilityHlepar.getToast(data["message"]);
    return ScanFromResponse.fromJson(data);
  }

  //  Scan history
  static Future<ScanHistoryResponse> scanHistory(
      ScanHistoryRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.scan_history_info, parameters: request.tojson());
    print(responsData);
    print(request.tojson());
    var data = jsonDecode(responsData.body);
    if (data['status'] == true) {
      return ScanHistoryResponse.fromJson(data);
    } else {
      return data;
    }
  }

  //  Get user profile data
  static Future<GetProfileResponse> getProfile(
      GetProfileRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.get_profile_url, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    if (data['status'] == true) {
      return GetProfileResponse.fromJson(data);
    } else {
      return data;
    }
  }

  //  Update user profile data
  static Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.update_profile_url, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    UtilityHlepar.getToast(data["message"]);
    return UpdateProfileResponse.fromJson(data);
  }

  //  issue with battery
  static Future<ComplentBoxResponse> issueWithBatter(
      ComplentBoxRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.complent_box_request_url, parameters: request.tojson());
    print(responsData.toString());
    print(request.toString());
    var data = jsonDecode(responsData.body);
    UtilityHlepar.getToast(data["message"]);
    return ComplentBoxResponse.fromJson(data);
  }

  // Get issue  Request
  static Future<IssueHistoryResponse> getIssueHistory(
      IssueHistoryRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.get_issue_history_url, parameters: request.tojson());
    print(request.tojson());
    print(responsData);
    var data = jsonDecode(responsData.body);
    return IssueHistoryResponse.fromJson(data);
  }

  // Get issue  Request
  static Future<ImageGalleryResponse> getImageGallery() async {
    var responsData = await ApiService.getAPI(path: Apipath.image_gallery_url);
    var data = jsonDecode(responsData.body);
    return ImageGalleryResponse.fromJson(data);
  }

  // replace battary
  static Future<ReplaceBattaryResponse> replaceBattary(
      ReplaceBattaryRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.replace_battary_url, parameters: request.tojson());
    print(responsData);
    print(request.tojson());
    var data = jsonDecode(responsData.body);
    UtilityHlepar.getToast(data["message"]);
    return ReplaceBattaryResponse.fromJson(data);
  }

  Future<void> _showMyDialog(BuildContext context, msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You Request Save'),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
