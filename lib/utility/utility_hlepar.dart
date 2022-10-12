import 'dart:io';

import 'package:battary/view/no_internet_view/main_no_internet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class UtilityHlepar {
  // get Flutter toast MSG
  static getToast(msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      // backgroundColor: Colors.red,
      // textColor: Colors.white,
      // fontSize: 16.0
    );
  }

  // check if not null data
  static String convertNA(data) {
    return data ?? "N/A";
  }

  // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

  static String convertDataTime(getFormat) {
    var dateTime = DateTime.parse(getFormat.toString());
    // var now = DateTime.now();
    // var dateTime = DateTime.parse(getFormat.toString());
    var mydatetime =
        "${DateFormat.d().format(dateTime)} ${DateFormat.LLL().format(dateTime)} ${DateFormat.y().format(dateTime)}, ${DateFormat.jm().format(dateTime)}";
    return mydatetime;
  }

  static String getbatteryWarranty(getFormat) {
    // var dateTime = DateTime.parse(getFormat.toString());
    var dateTime = DateTime.now();
    List convateFormet = dateTime.toString().split("-");
    print(convateFormet);
    String yearName = convateFormet[0];
    String date = convateFormet[2];
    var myMonthIndex = DateFormat.M().format(dateTime);
    var finalFormet =
        DateTime.parse("$yearName-0${int.parse(myMonthIndex) + 6}-$date");
    print(finalFormet);
    return convertDataTime(finalFormet).split(",")[0];
  }

  static noInternet(context) async {
    try {
      final result = await InternetAddress.lookup('https://www.google.co.in/');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NoInternetView()));
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
}
