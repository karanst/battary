import 'package:battary/utility/my_color.dart';
import 'package:flutter/material.dart';

class MyappBarView extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor = Colors.red;
  final String? titleText;
  final AppBar appBar;
  final int? from;

  /// you can add more fields that meet your needs
  MyappBarView({
    Key? key,
    this.titleText,
    required this.appBar,
    this.from,
    // required this.widgets,
    // required this.iconsWidgets
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.repeated,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [MyColor.primary, MyColor.primaryLight],
            stops: [
              0.5,
              1.7,
            ],
          ),
        ),
      ),
      title: Text(
        titleText.toString(),
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: MyColor.primary,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Image.asset(
            'assets/icons/back_arrow.png',
            height: 50,
            width: 30,
          ),
        ),
      ),
      // leading: Container(
      //   margin: EdgeInsets.all(10),
      //   decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Image.asset(
      //       'assets/icons/appbar_back_arow.png',
      // height: 90,
      // width: 30,
      //     ),
      //   ),
      // ),
      actions: <Widget>[
        // Padding(
        //   padding: EdgeInsets.only(right: 5.0, bottom: 10),
        //   child: Icon(
        //     Icons.notifications,
        //     size: 26.0,
        //   ),
        // )
        Container(),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
