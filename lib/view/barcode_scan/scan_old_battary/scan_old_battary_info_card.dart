import 'package:battary/utility/my_color.dart';
import 'package:battary/utility/utility_hlepar.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';

class ScanOldBattaryInfoCard extends StatelessWidget {
  const ScanOldBattaryInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Card(
      child: Container(
        padding: EdgeInsets.all(mysize.height / 150.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: mysize.width * 0.31,
                    height: mysize.height / 7,
                    // color: MyColor.primary,
                    child: Image.asset(
                      "assets/home/battary_img.png",
                      fit: BoxFit.cover,
                    )),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  // width: mysize.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "dsdsd",
                        style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.w500),
                      ),
                      cardRow(title: "Scan ID :", value: " 55"),
                      cardRow(
                          title: "Start Date : ",
                          value: UtilityHlepar.getbatteryWarranty("255")),
                      cardRow(
                          title: "End date : ",
                          value: UtilityHlepar.getbatteryWarranty("dd")),
                      cardRow(
                          title: "Capacity : ",
                          value: UtilityHlepar.convertNA("dd")),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Container cardRow({required title, required value}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Text(
          title ?? "",
          style: TextStyle(color: MyColor.primary),
        ),
        Text(
          value,
          style: TextStyle(
              color: MyColor.primaryLight, fontWeight: FontWeight.w300),
        ),
      ],
    ),
  );
}
