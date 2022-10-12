import 'package:battary/api/api_path.dart';
import 'package:battary/model/response/scanInfo_response.dart';
import 'package:battary/utility/my_color.dart';
import 'package:battary/utility/my_string.dart';
import 'package:battary/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';

class ScanHistoryCardView extends StatelessWidget {
  final ScanInfoResponse response;
  final String scanid;
  ScanHistoryCardView({Key? key, required this.response, required this.scanid})
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: mysize.width * 0.31,
                    height: mysize.height / 7,
                    // color: MyColor.primary,
                    child: response.data![0].productImage != null
                        ? Image.network(
                            Apipath.BASH_IMG +
                                response.data![0].productImage.toString(),
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
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
                        UtilityHlepar.convertNA(response.data![0].productName),
                        style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.w500),
                      ),
                      cardRow(title: "Scan ID :", value: " EX-$scanid"),
                      cardRow(
                          title: "Warranty : ",
                          value: UtilityHlepar.convertNA(response
                              .data![0].warrantyInfo!.warranty
                              .toString())),
                      response
                          .data![0].warrantyInfo!.fromDate!=null?cardRow(
                          title: "Start Date : ",
                          value: UtilityHlepar.convertNA(response
                              .data![0].warrantyInfo!.fromDate
                              .toString())):SizedBox(),
                      response
                          .data![0].warrantyInfo!.fromDate!=null?cardRow(
                          title: "End date : ",
                          value: UtilityHlepar.convertNA(response
                              .data![0].warrantyInfo!.toDate
                              .toString())):SizedBox(),
                      cardRow(
                          title: "Capacity : ",
                          value: UtilityHlepar.convertNA(
                              response.data![0].capacity)),
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
