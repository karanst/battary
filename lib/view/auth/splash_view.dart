import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:battary/token/app_token_data.dart';
import 'package:battary/utility/img_assets.dart';
import 'package:battary/utility/my_color.dart';
import 'package:battary/view/auth/login.dart';
import 'package:battary/view/home/main_home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var myTokenData;
  @override
  void initState() {
    super.initState();
    checkingToken();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: AnimatedSplashScreen(
          splash: MyAssetsImg.appLogo,
          nextScreen: myTokenData == null ? LoginView() : MainHomePageView(),
          splashIconSize: mysize.width / 4,
          splashTransition: SplashTransition.sizeTransition,
          backgroundColor: MyColor.primary,
          // pageTransitionType: PageTransitionType.scale,
        ),
      ),
    );
  }

  void checkingToken() async {
    myTokenData = await MyToken.getUserID();
    print(myTokenData);
    setState(() {});
  }
}
