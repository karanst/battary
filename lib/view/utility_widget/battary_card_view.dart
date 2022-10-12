import 'package:battary/utility/my_color.dart';
import 'package:battary/utility/my_string.dart';
import 'package:flutter/material.dart';

class MyBattaryCard {
  static Card scanHistoryCardView(Size mysize) {
    Container cardRow({required title, required value}) {
      return Container(
        // width: mysize.width,
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

    return Card(
      child: Container(
        padding: EdgeInsets.all(mysize.height / 50.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: mysize.width * 0.31,
                  height: mysize.height / 5,
                  child: Image.asset(
                    "assets/home/battary_img.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  // width: mysize.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Exide FMIO-ML38b20R",
                        style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.w500),
                      ),
                      cardRow(title: "Customer name : ", value: "Johan deo"),
                      cardRow(
                          title: "Battery Price : ",
                          value: MyString.currencySymbol + '5999'),
                      cardRow(title: "Scan ID :", value: "EX0012"),
                      cardRow(title: "Warranty : ", value: "12 Months"),
                      cardRow(title: "Capacity : ", value: "50Ah"),
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
