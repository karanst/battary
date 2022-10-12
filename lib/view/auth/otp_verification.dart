import 'dart:convert';
import 'package:battary/api/api_helper.dart';
import 'package:battary/api/api_path.dart';
import 'package:battary/model/Resend_otp_model.dart';
import 'package:battary/model/request/otp_verify_request.dart';
import 'package:battary/model/response/otpverify_response.dart';
import 'package:battary/token/token_string.dart';
import 'package:battary/utility/my_color.dart';
import 'package:battary/utility/showDialog.dart';
import 'package:battary/utility/toast_string.dart';
import 'package:battary/utility/utility_hlepar.dart';
import 'package:battary/view/home/main_home_page.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationView extends StatefulWidget {
  String otp;
  String phoneNumber;
  String roleId;
  OtpVerificationView(
      {Key? key,
      required this.otp,
      required this.phoneNumber,
      required this.roleId})
      : super(key: key);

  @override
  _OtpVerificationViewState createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  String? myOTP;
  String? newOtp;
  late OtpverifyResponse _otpverifyResponse;

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: mysize.height * 0.5,
                      width: mysize.width,
                      child: Image.asset(
                        'assets/auth_img/login_bg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: mysize.height / 20,
                      left: mysize.width / 20,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          "assets/icons/back_arrow.png",
                          height: mysize.height / 20,
                        ),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(
                          0.0, -mysize.height / 15, 0.0),
                      child: Center(
                        child: Text(
                          "OTP",
                          style: TextStyle(
                              color: MyColor.secondary,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    newOtp == null ? Text(
                      "Enter 4 digit OTP number sent to your phone\n Testing otp ${widget.otp}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ) : Text(
                      "Enter 4 digit OTP number sent to your phone\n Testing otp $newOtp",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                //new row
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: mysize.height / 25,
                  ),
                  width: mysize.width * 0.9,
                  transform:
                      Matrix4.translationValues(0.0, -mysize.height / 8, 0.0),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: mysize.width / 1.2,
                        child: OTPTextField(
                          length: 4,
                          width: mysize.width / 1.2,
                          fieldWidth: mysize.width / 6,
                          style: TextStyle(fontSize: 17),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.box,
                          onCompleted: (pin) {
                            myOTP = pin;
                            setState(() {});
                            print("Completed: " + pin);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                // new row
                // new row
                SizedBox(
                    width: mysize.width * 0.9,
                    child: InkWell(
                      onTap: () => otpVilification(context),
                      child: UtilityWidget.fletButton(mysize,
                          btnText: "Continue".toUpperCase()),
                    )
                ),
                // new row
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't get the code? ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 3,),
                      InkWell(
                        onTap: (){
                          resendOtp();
                        },
                        child: Text(
                          "Resend OTP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// OTP Vilification
  otpVilification(BuildContext context) async {
    OtpVerifyRequest request = OtpVerifyRequest(
        phone: widget.phoneNumber, otp: myOTP!, firebaseToken: "");
    if (widget.otp == myOTP || newOtp == myOTP) {
      MyDialogBox.loadingDialog(context);
      _otpverifyResponse = await ApiHelper.otpVerify(request);
      if (_otpverifyResponse.status == true) {
        onTapGoNextScreen(context,
            userid: _otpverifyResponse.data!.userId.toString());
      }
      Navigator.pop(context);
    } else {
      UtilityHlepar.getToast(ToastString.msgOTP);
    }
  }

  resendOtp() async {

    var request = http.MultipartRequest('POST', Uri.parse(Apipath.resend_otp));
    request.fields.addAll({
      'mobile': '${widget.phoneNumber}'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = ResendOtpModel.fromJson(json.decode(str));
      if(jsonResponse.status == true){
        setState(() {
          newOtp = jsonResponse.data.toString();
        });
        UtilityHlepar.getToast(ToastString.newMsgOtp);
        print("NEW OTP ==== $newOtp");
      }
      return ResendOtpModel.fromJson(json.decode(str));
    }
    else {
    return null;
    }
  }

  onTapGoNextScreen(context, {userid}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TokenString.userid, userid);
    await prefs.setString(TokenString.roleId, widget.roleId.toString());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainHomePageView()),
        (route) => false);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => MainHomePageView()));
  }
}
