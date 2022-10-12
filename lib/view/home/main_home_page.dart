import 'package:battary/utility/img_assets.dart';
import 'package:battary/utility/my_color.dart';
import 'package:battary/view/drawer_menu/main_drawer_view.dart';
import 'package:battary/view/home/home_latest_scan_history.dart';
import 'package:battary/view/home/home_two_option_view.dart';
import 'package:battary/view/user_prfile/get_user_profile_view.dart';
import 'package:flutter/material.dart';

class MainHomePageView extends StatefulWidget {
  const MainHomePageView({Key? key}) : super(key: key);

  @override
  _MainHomePageViewState createState() => _MainHomePageViewState();
}

class _MainHomePageViewState extends State<MainHomePageView> {
  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          MyAssetsImg.appLogo,
          height: 30,
        ),
        centerTitle: true,
        backgroundColor: MyColor.primary,
        actions: [
          InkWell(
            onTap: () => onTapGoProfileScreen(context),
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.account_box),
            ),
          )
        ],
      ),
      drawer: MainDrawerView(),
      body: LayoutBuilder(
        builder: (context, constraints) => RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HomeTopHeder(),
                HomeTwoOptionView(),
                HomeLatestScanHistory(),
                //new row
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapGoProfileScreen(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserProfileView()));
  }

  Future _refresh() async {
    setState(() {});
  }
}
