import 'package:battary/api/api_path.dart';
import 'package:battary/model/response/scan_history_response.dart';
import 'package:battary/utility/my_color.dart';
import 'package:battary/utility/my_string.dart';
import 'package:battary/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';

class ScanHistoryCard extends StatelessWidget {
  ScanHistoryResponse response;
  int i;
  ScanHistoryCard({Key? key, required this.response, required this.i})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Card(
      child: Container(
        padding: EdgeInsets.all(mysize.height / 150.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: mysize.width * 0.2,
                  height: mysize.height / 7,
                  child: response.data![i].productImage != null
                      ? Image.network(
                          Apipath.BASH_IMG +
                              response.data![i].productImage.toString(),
                        )
                      : Image.asset(
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
                        UtilityHlepar.convertNA(response.data![i].productName),
                        style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.w500),
                      ),
                      cardRow(mysize,
                          title: "Name",
                          value:
                              UtilityHlepar.convertNA(response.data![i].name)),
                      // cardRow(
                      //     title: "Battery Price : ",
                      //     value: MyString.currencySymbol + '5999'),
                      cardRow(mysize,
                          title: "Scan ID ",
                          value: UtilityHlepar.convertNA(
                              response.data![i].newBarcodeId)),
                      cardRow(mysize,
                          title: "Warranty ",
                          value: UtilityHlepar.convertNA(response
                              .data![i].warrantyInfo!.warranty
                              .toString())),
                      cardRow(mysize,
                          title: "Start Date ",
                          value: UtilityHlepar.convertNA(response
                              .data![i].warrantyInfo!.fromDate
                              .toString())),
                      cardRow(mysize,
                          title: "End Date ",
                          value: UtilityHlepar.convertNA(response
                              .data![i].warrantyInfo!.toDate
                              .toString())),
                      cardRow(mysize,
                          title: "Capacity ",
                          value: UtilityHlepar.convertNA(
                              response.data![i].capacity)),
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

Container cardRow(mysize, {required title, required value}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    width: mysize.width * 0.6,
    child: Text(
      "$title : " + value,
      style:
          TextStyle(color: MyColor.primaryLight, fontWeight: FontWeight.w300),
    ),
  );
}
