import 'package:battary/utility/img_assets.dart';
import 'package:battary/view/user_prfile/get_user_profile_view.dart';
import 'package:flutter/material.dart';

class HomeTopHeder extends StatelessWidget {
  const HomeTopHeder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(mysize.width / 10),
            bottomRight: Radius.circular(mysize.width / 10),
          ),
          child: Container(
            height: mysize.height * 0.3,
            child: Image.asset(
              "assets/home/home_app_bar_bg.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        // logo
        Container(
          child: Image.asset(
            MyAssetsImg.appLogo,
            height: mysize.height / 7,
          ),
        ),
        // logo
        //
        //Drawers icon Menu
        Positioned(
            top: mysize.height / 15,
            right: mysize.width / 50,
            child: InkWell(
              onTap: () => onTapGoProfileScreen(context),
              child: Icon(Icons.account_box,
                  color: Colors.white, size: mysize.height / 20),
            )),
        //Drawers icon Menu
      ],
    );
  }

  onTapGoProfileScreen(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserProfileView()));
  }
}
