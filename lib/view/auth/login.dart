import 'package:battary/api/api_helper.dart';
import 'package:battary/model/request/login_with_otp_request.dart';
import 'package:battary/model/response/login_with_otp_response.dart';
import 'package:battary/token/token_string.dart';
import 'package:battary/utility/my_color.dart';
import 'package:battary/utility/showDialog.dart';
import 'package:battary/validation/form_validation.dart';
import 'package:battary/view/auth/otp_verification.dart';
import 'package:battary/view/auth/register.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _Formkey = GlobalKey<FormState>();
  late final LoginResponse _loginResponse;
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: MyColor.scaffoldBg,
        body: Form(
          key: _Formkey,
          child: SafeArea(
            child: SingleChildScrollView(
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
                        Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: MyColor.secondary,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: mysize.height / 25,
                      ),
                      width: mysize.width * 0.9,
                      transform: Matrix4.translationValues(
                          0.0, -mysize.height / 8, 0.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 1), // changes position of shadow
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
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: FormValidation.validateMobile,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: phoneController,
                              decoration: UtilityWidget.myInputDecoration(
                                mysize: mysize,
                                hintText: "Enter your mobile number",
                                iconImg: "assets/icons/call.png",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // new row
                    SizedBox(
                        width: mysize.width * 0.9,
                        child: InkWell(
                          onTap: () => loginWithOTP(context),
                          child: UtilityWidget.fletButton(mysize,
                              btnText: "Continue".toUpperCase()),
                        )),
                    // new row

                    Container(
                      margin: EdgeInsets.only(top: mysize.height / 20),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Don't have Account? "),
                          InkWell(
                            onTap: () => onTapGoNextScreen(context),
                            child: Text(
                              "Register Now",
                              style: TextStyle(color: Colors.deepOrange),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// login API
  loginWithOTP(context) async {
    if (_Formkey.currentState!.validate()) {
      MyDialogBox.loadingDialog(context);
      LoginRequest request =
          LoginRequest(phone: phoneController.text, firebaseToken: '');
      _loginResponse = await ApiHelper.loginWithOTP(request);

      if (_loginResponse.status == true) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpVerificationView(
                      phoneNumber: phoneController.text,
                      otp: _loginResponse.data!.otp.toString(),
                      roleId: _loginResponse.data!.roleId.toString(),
                    )));

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            TokenString.userName, _loginResponse.data!.userFullname.toString());
      } else {
        onTapGoNextScreen(context, phoneNumber: phoneController.text);
      }
    }
  }

  onTapGoNextScreen(context, {phoneNumber}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserRegister(
                  phoneNumber: phoneNumber,
                )));
  }
}
