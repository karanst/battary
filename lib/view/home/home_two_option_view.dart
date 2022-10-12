import 'package:battary/utility/my_string.dart';
import 'package:battary/view/barcode_scan/scan_new_battary/barcode_scan.dart';
import 'package:battary/view/scan_history/main_scan_history.dart';

import 'package:flutter/material.dart';

class HomeTwoOptionView extends StatelessWidget {
  HomeTwoOptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: mysize.height / 50),
          child: InkWell(
            onTap: () => onTapGoNextScreen(context),
            child: cardView(mysize,
                imgIcon: "assets/home/scanner_icon.png",
                title: "Scan Your Battery Code Here"),
          ),
        ),
        Container(
          child: InkWell(
            onTap: () => onTapGoScanHistory(context),
            child: cardView(mysize,
                imgIcon: "assets/home/battary_icon_img.png",
                title: "Scan History"),
          ),
        ),
      ],
    );
  }

  Card cardView(Size mysize, {imgIcon, title}) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imgIcon ?? "assets/home/scanner_icon.png",
              height: mysize.height / 8,
              width: mysize.width / 4,
            ),
            Column(
              children: [
                SizedBox(
                  width: mysize.width / 1.5,
                  child: Text(
                    title ?? "Scan Your Battery Code Here",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                    width: mysize.width / 1.5,
                    child: Text(MyString.description))
              ],
            )
          ],
        ),
      ),
    );
  }

  onTapGoScanHistory(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainScanHistory()));
  }

  onTapGoNextScreen(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MainBarcodeScannerView()));
  }
}
