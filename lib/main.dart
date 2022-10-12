import 'package:battary/utility/my_color.dart';
import 'package:battary/view/auth/login.dart';
import 'package:battary/view/auth/splash_view.dart';
import 'package:battary/view/complain_view/complain_box.dart';
import 'package:battary/view/gallery_view/main_gallery_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: MyColor.primaryLight, // navigation bar color
    statusBarColor: MyColor.primary, // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      // home: ImageGalleryView(),
    );
  }
}
