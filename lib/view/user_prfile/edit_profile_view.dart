import 'package:battary/api/api_helper.dart';
import 'package:battary/model/request/get_profile_request.dart';
import 'package:battary/model/request/update_profile_request.dart';
import 'package:battary/model/response/get_profile_response.dart';
import 'package:battary/model/response/update_profile_response.dart';
import 'package:battary/token/app_token_data.dart';
import 'package:battary/utility/showDialog.dart';
import 'package:battary/utility/toast_string.dart';
import 'package:battary/validation/form_validation.dart';
import 'package:battary/view/auth/splash_view.dart';
import 'package:battary/view/home/main_home_page.dart';
import 'package:battary/view/user_prfile/get_user_profile_view.dart';
import 'package:battary/view/utility_widget/myappbar.dart';
import 'package:battary/view/utility_widget/shimmer_loding_view/loding_all_page.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserProfile extends StatefulWidget {
  late GetProfileResponse response;

  EditUserProfile({Key? key, required this.response}) : super(key: key);

  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController shopName = TextEditingController();
  TextEditingController gstNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  late UpdateProfileResponse profileResponse;
  @override
  void initState() {
    getMyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyappBarView(
        appBar: AppBar(),
        titleText: "Edit Profile",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _fromKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: mysize.width / 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: mysize.height / 50,
                ),
                // Container(child: ,),
                TextFormField(
                  controller: fullName,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                  validator: FormValidation.checkEmptyValidator,
                  decoration:
                      UtilityWidget.newInputDecoration(hintText: "Full Name"),
                ),
                SizedBox(
                  height: mysize.height / 60,
                ),
                TextFormField(
                  controller: phone,
                  validator: FormValidation.validateMobile,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: UtilityWidget.newInputDecoration(
                      hintText: "Phone Number"),
                ),
                SizedBox(
                  height: mysize.height / 60,
                ),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidation.EmailVeledetion,
                  decoration: UtilityWidget.newInputDecoration(
                      hintText: "Email Address"),
                ),
                SizedBox(
                  height: mysize.height / 60,
                ),
                TextFormField(
                  controller: shopName,
                  keyboardType: TextInputType.text,
                  validator: FormValidation.checkEmptyValidator,
                  decoration:
                      UtilityWidget.newInputDecoration(hintText: "Store Name "),
                ),
                SizedBox(
                  height: mysize.height / 60,
                ),
                TextFormField(
                  controller: gstNumber,
                  keyboardType: TextInputType.text,
                  validator: FormValidation.checkEmptyValidator,
                  decoration:
                      UtilityWidget.newInputDecoration(hintText: "GST Number"),
                ),
                SizedBox(
                  height: mysize.height / 60,
                ),
                TextFormField(
                  controller: address,
                  keyboardType: TextInputType.text,
                  validator: FormValidation.checkEmptyValidator,
                  decoration: UtilityWidget.newInputDecoration(
                      hintText: "Shop Address"),
                ),

                Container(
                    margin: EdgeInsets.symmetric(vertical: mysize.height / 60),
                    child: InkWell(
                        onTap: () => editProfile(context),
                        child: UtilityWidget.fletButton(mysize,
                            btnText: 'Edit Profile'.toUpperCase()))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getMyProfile() async {
    fullName.text = widget.response.data![0].userFullname.toString();
    phone.text = widget.response.data![0].userPhone.toString();
    email.text = widget.response.data![0].userEmail.toString();
    shopName.text = widget.response.data![0].storeName.toString();
    gstNumber.text = widget.response.data![0].gstNumber.toString();
    address.text = widget.response.data![0].address.toString();
  }

  editProfile(context) {
    MyDialogBox.showMyDialog(context,
        title: "Do you want to update profile",
        functionName: () => updateProfile(context));
  }

  updateProfile(context) async {
    if (_fromKey.currentState!.validate()) {
      MyDialogBox.loadingDialog(context);
      var userId = await MyToken.getUserID();
      UpdateProfileRequest request = UpdateProfileRequest(
          name: fullName.text,
          email: email.text,
          phone: phone.text,
          shopName: shopName.text,
          gstNumber: gstNumber.text,
          address: address.text,
          userId: userId);
      profileResponse = await ApiHelper.updateProfile(request);
      if (profileResponse.status == true) {
        print("true");
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => UserProfileView()));
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
    }
  }
}
