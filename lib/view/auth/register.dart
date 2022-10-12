import 'package:battary/api/api_helper.dart';
import 'package:battary/model/request/registration_request.dart';
import 'package:battary/model/response/registration_response.dart';
import 'package:battary/token/token_string.dart';
import 'package:battary/utility/my_color.dart';
import 'package:battary/utility/showDialog.dart';
import 'package:battary/validation/form_validation.dart';
import 'package:battary/view/auth/otp_verification.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class UserRegister extends StatefulWidget {
  String? phoneNumber;
  UserRegister({Key? key, this.phoneNumber}) : super(key: key);

  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController shopName = TextEditingController();
  TextEditingController gstNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  late RegistrationResponse _registrationResponse;
  @override
  void initState() {
    super.initState();
    phone.text =
        widget.phoneNumber != null ? widget.phoneNumber.toString() : "";
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Form(
          key: formKey,
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
                            "SIGN UP",
                            style: TextStyle(
                                color: MyColor.secondary,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // new row
                  Container(
                    // height: mysize.height / 5,
                    padding: EdgeInsets.symmetric(
                      vertical: mysize.height / 25,
                    ),
                    width: mysize.width * 0.9,
                    transform:
                        Matrix4.translationValues(0.0, -mysize.height / 4, 0.0),
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
                        //  new row
                        SizedBox(
                          width: mysize.width / 1.2,
                          child: TextFormField(
                            controller: name,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z]')),
                            ],
                            validator: FormValidation.checkEmptyValidator,
                            decoration: UtilityWidget.myInputDecoration(
                              mysize: mysize,
                              hintText: "Enter full name",
                              iconImg: "assets/icons/user_icon.png",
                            ),
                          ),
                        ),
                        //  new row
                        SizedBox(
                          height: mysize.height / 50,
                        ),
                        //  new row
                        SizedBox(
                          width: mysize.width / 1.2,
                          child: TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            validator: FormValidation.EmailVeledetion,
                            decoration: UtilityWidget.myInputDecoration(
                              mysize: mysize,
                              hintText: "Enter email address",
                              iconImg: "assets/icons/email_icon.png",
                            ),
                          ),
                        ),
                        //  new row
                        SizedBox(
                          height: mysize.height / 50,
                        ),
                        //  new row
                        SizedBox(
                          width: mysize.width / 1.2,
                          child: TextFormField(
                            controller: phone,
                            maxLength: 10,
                            validator: FormValidation.validateMobile,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: UtilityWidget.myInputDecoration(
                              mysize: mysize,
                              hintText: "Enter phone number",
                              iconImg: "assets/icons/call.png",
                            ),
                          ),
                        ),
                        //  new row
                        SizedBox(
                          height: mysize.height / 50,
                        ),
                        //  new row
                        SizedBox(
                          width: mysize.width / 1.2,
                          child: TextFormField(
                            controller: shopName,
                            keyboardType: TextInputType.text,
                            validator: FormValidation.checkEmptyValidator,
                            decoration: UtilityWidget.myInputDecoration(
                              mysize: mysize,
                              hintText: "Enter shop name",
                              iconImg: "assets/icons/shop_name.png",
                            ),
                          ),
                        ),
                        //  new row
                        SizedBox(
                          height: mysize.height / 50,
                        ),
                        //  new row
                        SizedBox(
                          width: mysize.width / 1.2,
                          child: TextFormField(
                            controller: gstNumber,
                            keyboardType: TextInputType.text,
                            validator: FormValidation.checkEmptyValidator,
                            decoration: UtilityWidget.myInputDecoration(
                              mysize: mysize,
                              hintText: "Enter GST number",
                              iconImg: "assets/icons/gst_number.png",
                            ),
                          ),
                        ),
                        //  new row
                        SizedBox(
                          height: mysize.height / 50,
                        ),
                        //  new row
                        SizedBox(
                          width: mysize.width / 1.2,
                          child: TextFormField(
                            controller: address,
                            keyboardType: TextInputType.text,
                            validator: FormValidation.checkEmptyValidator,
                            decoration: UtilityWidget.myInputDecoration(
                              mysize: mysize,
                              hintText: "Enter address",
                              iconImg: "assets/icons/location.png",
                            ),
                          ),
                        ),
                        //  new row
                      ],
                    ),
                  ),
                  // new row
                  Container(
                    transform:
                        Matrix4.translationValues(0.0, -mysize.height / 5, 0.0),
                    child: SizedBox(
                        width: mysize.width * 0.9,
                        child: InkWell(
                            onTap: () => validation(),
                            child: UtilityWidget.fletButton(mysize))),
                  )
                  //new row
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validation() {
    if (formKey.currentState!.validate()) {
      userRegistration(context);
    }
  }

  // Registration
  userRegistration(BuildContext context) async {
    MyDialogBox.loadingDialog(context);
    RegistrationRequest request = RegistrationRequest(
        name: name.text,
        email: email.text,
        phone: phone.text,
        shopName: shopName.text,
        gstNumber: gstNumber.text,
        address: address.text,
        firebaseToken: '');
    _registrationResponse = await ApiHelper.registration(request);
    if (_registrationResponse.status == true) {
      onTapGoNextScreen(context, otp: _registrationResponse.otp.toString());
    } else {
      Navigator.pop(context);
    }
  }

  onTapGoNextScreen(context, {otp}) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpVerificationView(
                  roleId: "0",
                  otp: otp,
                  phoneNumber: phone.text,
                )));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TokenString.userName, name.text);
  }
}
