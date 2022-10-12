import 'package:battary/token/app_token_data.dart';
import 'package:battary/utility/my_color.dart';
import 'package:battary/utility/showDialog.dart';
import 'package:battary/view/auth/splash_view.dart';
import 'package:battary/view/barcode_scan/scan_new_battary/barcode_scan.dart';
import 'package:battary/view/gallery_view/main_gallery_view.dart';
import 'package:battary/view/home/main_home_page.dart';
import 'package:battary/view/scan_history/main_scan_history.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user_prfile/get_user_profile_view.dart';

class MainDrawerView extends StatefulWidget {
  const MainDrawerView({Key? key}) : super(key: key);

  @override
  _MainDrawerViewState createState() => _MainDrawerViewState();
}

class _MainDrawerViewState extends State<MainDrawerView> {
  var fastName = "My Name";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setFastName();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return SafeArea(
      child: Drawer(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        left: mysize.width / 20, top: mysize.height / 30),
                    child: Icon(Icons.clear_outlined)),
              ),
              Center(
                  child: SizedBox(
                width: mysize.width / 2,
                child: Text(
                  "Hii $fastName  ",
                  style: TextStyle(fontSize: 20.0),
                ),
              )),
              UtilityWidget.menuStyle(context,
                  widgetName: () => MainHomePageView(),
                  icon: Icons.home,
                  text: "Home"),
              UtilityWidget.menuStyle(context,
                  widgetName: () => MainScanHistory(),
                  icon: Icons.history,
                  text: "Scan History"),
              UtilityWidget.menuStyle(context,
                  widgetName: () => MainBarcodeScannerView(),
                  icon: Icons.qr_code,
                  text: "Scan Now"),
              UtilityWidget.menuStyle(context,
                  widgetName: () => UserProfileView(),
                  icon: Icons.account_box,
                  text: "My Profile"),
              UtilityWidget.menuStyle(context,
                  widgetName: () => ImageGalleryView(),
                  icon: Icons.image,
                  text: "My Gallery"),
              InkWell(
                onTap: () => _logOut(context),
                child: Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: MyColor.primary,
                    ),
                    title: Text("Logout"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  setFastName() async {
    fastName = await MyToken.getName();

    setState(() {});
  }

  Future _logOut(context) async {
    // _showMyDialog(context);
    MyDialogBox.showAlertDialogWithTwobtn(context,
        title: "Do you want to logOut ? ",
        body: "",
        funtionName: () => logOutNow(context));
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
