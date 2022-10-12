import 'package:battary/api/api_helper.dart';
import 'package:battary/model/request/get_profile_request.dart';
import 'package:battary/model/response/get_profile_response.dart';
import 'package:battary/token/app_token_data.dart';
import 'package:battary/utility/toast_string.dart';
import 'package:battary/view/auth/splash_view.dart';
import 'package:battary/view/user_prfile/edit_profile_view.dart';
import 'package:battary/view/utility_widget/myappbar.dart';
import 'package:battary/view/utility_widget/shimmer_loding_view/loding_all_page.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileView extends StatefulWidget {
  UserProfileView({Key? key}) : super(key: key);

  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController shopName = TextEditingController();
  TextEditingController gstNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  late GetProfileResponse response;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyappBarView(
        appBar: AppBar(),
        titleText: "My Profile",
      ),
      body: FutureBuilder(
          future: getMyProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Container(
                  child: Text(ToastString.msgSomeWentWrong),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return LodingAllPage();
            }
            return SingleChildScrollView(
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
                      readOnly: true,
                      decoration: UtilityWidget.newInputDecoration(
                          hintText: "Full Name"),
                    ),
                    SizedBox(
                      height: mysize.height / 60,
                    ),
                    TextFormField(
                      controller: phone,
                      readOnly: true,
                      decoration: UtilityWidget.newInputDecoration(
                          hintText: "Phone Number"),
                    ),
                    SizedBox(
                      height: mysize.height / 60,
                    ),
                    TextFormField(
                      controller: email,
                      readOnly: true,
                      decoration: UtilityWidget.newInputDecoration(
                          hintText: "Email Address"),
                    ),
                    SizedBox(
                      height: mysize.height / 60,
                    ),
                    TextFormField(
                      controller: shopName,
                      readOnly: true,
                      decoration: UtilityWidget.newInputDecoration(
                          hintText: "Store Name "),
                    ),
                    SizedBox(
                      height: mysize.height / 60,
                    ),
                    TextFormField(
                      controller: gstNumber,
                      readOnly: true,
                      decoration: UtilityWidget.newInputDecoration(
                          hintText: "GST Number"),
                    ),

                    SizedBox(
                      height: mysize.height / 60,
                    ),
                    TextFormField(
                      controller: address,
                      readOnly: true,
                      decoration: UtilityWidget.newInputDecoration(
                          hintText: "Shop Address"),
                    ),

                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: mysize.height / 60),
                        child: InkWell(
                            onTap: () => editProfile(context),
                            child: UtilityWidget.fletButton(mysize,
                                btnText: 'Edit Profile'.toUpperCase()))),

                    Container(
                        child: InkWell(
                            onTap: () => _logOut(context),
                            child: UtilityWidget.fletButton(mysize,
                                btnText: 'Logout'.toUpperCase()))),
                  ],
                ),
              ),
            );
          }),
    );
  }

  getMyProfile() async {
    var userid = await MyToken.getUserID();
    GetProfileRequest request = GetProfileRequest(userId: userid);
    print("USER ID == $userid");
    response = await ApiHelper.getProfile(request);
    fullName.text = response.data![0].userFullname.toString();
    phone.text = response.data![0].userPhone.toString();
    email.text = response.data![0].userEmail.toString();
    shopName.text = response.data![0].storeName.toString();
    gstNumber.text = response.data![0].gstNumber.toString();
    address.text = response.data![0].address.toString();
    return response;
  }

  editProfile(context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => EditUserProfile(
                  response: response,
                )));
  }

  Future _logOut(context) async {
    _showMyDialog(context);
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you want to logout ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to log out '),
                // Text('So please  '),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                logOutNow(context);
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void logOutNow(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (route) => false);
  }
}
